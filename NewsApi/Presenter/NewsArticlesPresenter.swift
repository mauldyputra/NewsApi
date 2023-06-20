//
//  NewsArticlesPresenter.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol NewsArticlePresenterInterface {
    var router: RouterInterface? { get set }
    var interactor: NewsInteractorInterface? { get set }
    var view: NewsArticleViewInterface? { get set }
    
    func fetchNewsByCategories(with result: Result<[NewsCategory], Error>)
    func fetchLoadMore(with result: Result<[NewsCategory], Error>)
    func loadMoreData()
    func refreshData(completion: (() -> Void?))
}

class NewsArticlePresenter: NewsArticlePresenterInterface {
    
    var router: RouterInterface?
    
    var interactor: NewsInteractorInterface? {
        didSet {
            interactor?.fetchSources()
        }
    }
    
    var loadMoreInteractor: NewsInteractorInterface? {
        didSet {
            interactor?.loadMoreData()
        }
    }
    
    var view: NewsArticleViewInterface?
    
    func fetchNewsByCategories(with result: Result<[NewsCategory], Error>) {
        switch result {
        case .success(let success):
            view?.update(with: success)
        case .failure:
            view?.update(with: "Failed to Fetch")
        }
    }
    
    func fetchLoadMore(with result: Result<[NewsCategory], Error>) {
        switch result {
        case .success(let success):
            view?.update(with: success)
        case .failure:
            view?.update(with: "Failed to Fetch")
        }
    }
    
    func loadMoreData() {
        interactor?.loadMoreData()
    }
    
    func refreshData(completion: (() -> Void?)) {
        page = 1
        interactor?.fetchNewsByCategories()
        completion()
    }
}
