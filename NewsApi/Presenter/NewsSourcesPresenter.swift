//
//  NewsSourcesPresenter.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol NewsSourcePresenterInterface {
    var router: NewsRouter? { get set }
    var interactor: NewsInteractorInterface? { get set }
    var view: NewsSourceViewInterface? { get set }
    
    func fetchSources(with result: Result<[NewsSource], Error>)
    func fetchLoadMore(with result: Result<[NewsSource], Error>)
    func loadMoreData()
    func refreshData(completion: (() -> Void?))
    func didSelectSource(view: NewsSourceViewInterface)
}

class NewsSourcePresenter: NewsSourcePresenterInterface {
    
    var router: NewsRouter?
    
    var interactor: NewsInteractorInterface?
    
    var loadMoreInteractor: NewsInteractorInterface?
    
    var view: NewsSourceViewInterface?
    
    func fetchSources(with result: Result<[NewsSource], Error>) {
        switch result {
        case .success(let success):
            view?.update(with: success)
        case .failure(let error):
            view?.update(with: error.localizedDescription)
        }
    }
    
    func fetchLoadMore(with result: Result<[NewsSource], Error>) {
        switch result {
        case .success(let success):
            view?.updateLoadMore(with: success)
        case .failure(let error):
            view?.update(with: error.localizedDescription)
        }
    }
    
    func loadMoreData() {
        interactor?.loadMoreDataSource()
    }
    
    func refreshData(completion: (() -> Void?)) {
        interactor?.fetchSources()
        completion()
    }
    
    func didSelectSource(view: NewsSourceViewInterface) {
        interactor?.routeToArticle(view: view)
    }
}
