//
//  NewsCategoriesPresenter.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol NewsCategoryPresenterInterface {
    var router: RouterInterface? { get set }
    var interactor: NewsInteractorInterface? { get set }
    var view: NewsCategoryViewInterface? { get set }
}

class NewsCategoryPresenter: NewsCategoryPresenterInterface {
    var router: RouterInterface?
    var interactor: NewsInteractorInterface?
    var view: NewsCategoryViewInterface?
}
