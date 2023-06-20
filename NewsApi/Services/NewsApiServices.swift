//
//  NewsApiServices.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation
import Alamofire
import ObjectMapper

var page = 1
var pageSize = 10

final class NewsApiServices: APIService {
    func fetchNewsSources(completion: @escaping (Result<[NewsSource], Error>) -> Void) {
        print("URL: ", Endpoints.News.source(category: NewsUserDefaults.getNewsCategoryKey()).url)
        AF.request(Endpoints.News.source(category: NewsUserDefaults.getNewsCategoryKey()).url, method: .get)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    let json = try! JSONSerialization.jsonObject(with: data!)
                    let convertedJson = json as? [String: Any]
                    let arrayResponse = convertedJson?["sources"] as! NSArray
                    let arrayObject = Mapper<NewsSource>().mapArray(JSONArray: arrayResponse as! [[String: Any]])
                        completion(.success(arrayObject))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func fetchNewsByCategories(completion: @escaping (Result<[NewsCategory], Error>) -> Void) {
        let parameters: Parameters = ["page": page,
                                      "pageSize": pageSize]
        print("URL: ", Endpoints.News.category(category: NewsUserDefaults.getNewsCategoryKey()).url)
        AF.request(Endpoints.News.category(category: NewsUserDefaults.getNewsCategoryKey()).url, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    let json = try! JSONSerialization.jsonObject(with: data!)
                    let convertedJson = json as? [String: Any]
                    let arrayResponse = convertedJson?["articles"] as! NSArray
                    let arrayObject = Mapper<NewsCategory>().mapArray(JSONArray: arrayResponse as! [[String: Any]])
                        completion(.success(arrayObject))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    
}
