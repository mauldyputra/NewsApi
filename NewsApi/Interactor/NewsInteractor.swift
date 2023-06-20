//
//  NewsInteractor.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol NewsInteractorInterface {
    var presenterCategory: NewsCategoryPresenterInterface? { get set }
    var presenterSource: NewsSourcePresenterInterface? { get set }
    var presenterArticle: NewsArticlePresenterInterface? { get set }
    var presenterArticleDetail: ArticleDetailPresenterInterface? { get set }
    func fetchSources()
    func fetchNewsByCategories()
    func loadMoreData()
}

class NewsInteractor: NewsInteractorInterface {
    
    var apiService = NewsApiServices()
    
    var presenterCategory: NewsCategoryPresenterInterface?
    var presenterSource: NewsSourcePresenterInterface?
    var presenterArticle: NewsArticlePresenterInterface?
    var presenterArticleDetail: ArticleDetailPresenterInterface?
    
    func fetchSources() {
        apiService.fetchNewsSources { response in
            switch response {
            case .success(let success):
                self.presenterSource?.fetchSources(with: .success(success))
            case .failure:
                self.presenterSource?.fetchSources(with: .failure(FetchError.failed))
            }
        }
    }
    
    func fetchNewsByCategories() {
        apiService.fetchNewsByCategories() { response in
            switch response {
            case .success(let success):
                self.presenterArticle?.fetchNewsByCategories(with: .success(success))
            case .failure:
                self.presenterArticle?.fetchNewsByCategories(with: .failure(FetchError.failed))
            }
        }
    }
    
    func loadMoreData() {
        page += 1
        apiService.fetchNewsByCategories() { response in
            switch response {
            case .success(let success):
                self.presenterArticle?.fetchNewsByCategories(with: .success(success))
            case .failure:
                self.presenterArticle?.fetchNewsByCategories(with: .failure(FetchError.failed))
            }
        }
    }
}
