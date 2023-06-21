//
//  NewsInteractor.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol NewsInteractorInterface {
    var router: NewsRouter! { get set }
    var presenterCategory: NewsCategoryPresenterInterface? { get set }
    var presenterSource: NewsSourcePresenterInterface? { get set }
    var presenterArticle: NewsArticlePresenterInterface? { get set }
    var presenterArticleDetail: ArticleDetailPresenterInterface? { get set }
    var url: String? { get set }
    func fetchSources()
    func fetchArticles()
    func loadMoreDataSource()
    func loadMoreDataArticle()
    func routeToSource(view: NewsCategoryViewInterface)
    func routeToArticle(view: NewsSourceViewInterface)
    func routeToArticleDetail(view: NewsArticleViewInterface, url: String)
}

class NewsInteractor: NewsInteractorInterface {
    
    var router: NewsRouter!
    var apiService = NewsApiServices()
    
    var presenterCategory: NewsCategoryPresenterInterface?
    var presenterSource: NewsSourcePresenterInterface?
    var presenterArticle: NewsArticlePresenterInterface?
    var presenterArticleDetail: ArticleDetailPresenterInterface?
    
    var url: String? {
        didSet {
            guard let url = url else {
                print("url is nil")
                return
            }
            self.presenterArticleDetail?.url = url
        }
    }
    
    func fetchSources() {
        apiService.fetchNewsSources { [weak self] response in
            switch response {
            case .success(let success):
                self?.presenterSource?.fetchSources(with: .success(success))
            case .failure:
                self?.presenterSource?.fetchSources(with: .failure(FetchError.failed))
            }
        }
    }
    
    func fetchArticles() {
        apiService.fetchNewsArticles() { [weak self] response in
            switch response {
            case .success(let success):
                self?.presenterArticle?.fetchArticles(with: .success(success))
            case .failure:
                self?.presenterArticle?.fetchArticles(with: .failure(FetchError.failed))
            }
        }
    }
    
    func loadMoreDataSource() {
        page += 1
        apiService.fetchNewsSources() { [weak self] response in
            switch response {
            case .success(let success):
                self?.presenterSource?.fetchLoadMore(with: .success(success))
            case .failure:
                self?.presenterSource?.fetchLoadMore(with: .failure(FetchError.failed))
            }
        }
    }
    
    func loadMoreDataArticle() {
        page += 1
        apiService.fetchNewsArticles() { [weak self] response in
            switch response {
            case .success(let success):
                self?.presenterArticle?.fetchLoadMore(with: .success(success))
            case .failure:
                self?.presenterArticle?.fetchLoadMore(with: .failure(FetchError.failed))
            }
        }
    }
    
    func routeToSource(view: NewsCategoryViewInterface) {
        router = NewsRouter()
        router.pushToSource(on: view)
    }
    
    func routeToArticle(view: NewsSourceViewInterface) {
        router = NewsRouter()
        router.pushToArticle(on: view)
    }
    
    func routeToArticleDetail(view: NewsArticleViewInterface, url: String) {
        router = NewsRouter()
        router.pushToArticleDetail(on: view, with: url)
    }
}
