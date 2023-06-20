//
//  NewsApiServices.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation
import Alamofire
import ObjectMapper

let base = "https://newsapi.org/v2/everything"
let apiKey = "8008cacaf3fa44f3b6b5f26f1cb624d4"
var category = "technology"
var page = 1
var pageSize = 10

final class NewsApiServices: APIService {
    func fetchNewsHeadlines(completion: @escaping (Result<[NewsCategory], Error>) -> Void) {
        let parameters: Parameters = ["page": page,
                                      "pageSize": pageSize]
        AF.request(Endpoints.News.headline.url, method: .get, parameters: parameters, encoding: URLEncoding.default)
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
    
    func fetchNewsCategories(completion: @escaping (Result<[NewsCategory], Error>) -> Void) {
        let parameters: Parameters = ["apiKey": apiKey,
                                      "page": page,
                                      "pageSize": pageSize,
                                      "q": category]
        AF.request(base, method: .get, parameters: parameters, encoding: URLEncoding.default)
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
