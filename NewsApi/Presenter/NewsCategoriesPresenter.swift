//
//  NewsCategoriesPresenter.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol NewsPresenterInterface {
    var router: RouterInterface? { get set }
    var interactor: NewsInteractorInterface? { get set }
    var view: NewsViewInterface? { get set }
    
    func fetchNews(with result: Result<[NewsCategory], Error>)
    func fetchLoadMore(with result: Result<[NewsCategory], Error>)
    func loadMoreData()
    func refreshData(completion: (() -> Void?))
}

class NewsPresenter: NewsPresenterInterface {
    
    var router: RouterInterface?
    
    var interactor: NewsInteractorInterface? {
        didSet {
            interactor?.fetchNews()
        }
    }
    
    var loadMoreInteractor: NewsInteractorInterface? {
        didSet {
            interactor?.loadMoreData()
        }
    }
    
    var view: NewsViewInterface?
    
    func fetchNews(with result: Result<[NewsCategory], Error>) {
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
        interactor?.fetchNews()
        completion()
    }
}
