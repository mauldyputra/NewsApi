//
//  NewsInteractor.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol NewsInteractorInterface {
    var presenter: NewsPresenterInterface? { get set }
    func fetchNews()
    func loadMoreData()
}

class NewsInteractor: NewsInteractorInterface {
    
    var apiService = NewsApiServices()
    
    var presenter: NewsPresenterInterface?
    
    func fetchNews() {
        apiService.fetchNewsHeadlines { response in
            switch response {
            case .success(let success):
                self.presenter?.fetchNews(with: .success(success))
            case .failure:
                self.presenter?.fetchNews(with: .failure(FetchError.failed))
            }
        }
    }
    
    func loadMoreData() {
        page += 1
        apiService.fetchNewsHeadlines { response in
            switch response {
            case .success(let success):
                self.presenter?.fetchNews(with: .success(success))
            case .failure:
                self.presenter?.fetchNews(with: .failure(FetchError.failed))
            }
        }
    }
}
