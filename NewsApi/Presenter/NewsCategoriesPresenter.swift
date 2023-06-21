//
//  NewsCategoriesPresenter.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol NewsCategoryPresenterInterface {
    var router: NewsRouter? { get set }
    var interactor: NewsInteractorInterface? { get set }
    var view: NewsCategoryViewInterface? { get set }
    
    func didSelectCategory(view: NewsCategoryViewInterface)
}

class NewsCategoryPresenter: NewsCategoryPresenterInterface {
    var router: NewsRouter?
    var interactor: NewsInteractorInterface?
    var view: NewsCategoryViewInterface?
    
    func didSelectCategory(view: NewsCategoryViewInterface) {
        interactor?.routeToSource(view: view)
    }
}
