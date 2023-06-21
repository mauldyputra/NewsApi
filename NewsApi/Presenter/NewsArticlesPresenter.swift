//
//  NewsArticlesPresenter.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol NewsArticlePresenterInterface {
    var router: NewsRouter? { get set }
    var interactor: NewsInteractorInterface? { get set }
    var view: NewsArticleViewInterface? { get set }
    
    func fetchArticles(with result: Result<[NewsModel], Error>)
    func fetchLoadMore(with result: Result<[NewsModel], Error>)
    func searchArticle(completion: (() -> Void)?)
    func loadMoreData()
    func refreshData(completion: (() -> Void?))
    func didSelectArticle(view: NewsArticleViewInterface, url: String)
}

class NewsArticlePresenter: NewsArticlePresenterInterface {
    
    var router: NewsRouter?
    
    var interactor: NewsInteractorInterface? {
        didSet {
            interactor?.fetchArticles()
        }
    }
    
    var loadMoreInteractor: NewsInteractorInterface?
    
    var view: NewsArticleViewInterface?
    
    func fetchArticles(with result: Result<[NewsModel], Error>) {
        switch result {
        case .success(let success):
            view?.update(with: success)
        case .failure(let error):
            view?.update(with: error.localizedDescription)
        }
    }
    
    func fetchLoadMore(with result: Result<[NewsModel], Error>) {
        switch result {
        case .success(let success):
            view?.updateLoadMore(with: success)
        case .failure(let error):
            view?.update(with: error.localizedDescription)
        }
    }
    
    func searchArticle(completion: (() -> Void)?) {
        page = 1
        interactor?.fetchArticles()
        completion?()
    }
    
    func loadMoreData() {
        interactor?.loadMoreData()
    }
    
    func refreshData(completion: (() -> Void?)) {
        page = 1
        interactor?.fetchArticles()
        completion()
    }
    
    func didSelectArticle(view: NewsArticleViewInterface, url: String) {
        interactor?.routeToArticleDetail(view: view, url: url)
    }
}
