//
//  NewsSourcesPresenter.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol NewsSourcePresenterInterface {
    var router: RouterInterface? { get set }
    var interactor: NewsInteractorInterface? { get set }
    var view: NewsSourceViewInterface? { get set }
    
    func fetchSources(with result: Result<[NewsSource], Error>)
    func refreshData(completion: (() -> Void?))
}

class NewsSourcePresenter: NewsSourcePresenterInterface {
    
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
    
    var view: NewsSourceViewInterface?
    
    func fetchSources(with result: Result<[NewsSource], Error>) {
        switch result {
        case .success(let success):
            view?.update(with: success)
        case .failure:
            view?.update(with: "Failed to Fetch")
        }
    }
    
    func refreshData(completion: (() -> Void?)) {
        interactor?.fetchSources()
        completion()
    }
}
