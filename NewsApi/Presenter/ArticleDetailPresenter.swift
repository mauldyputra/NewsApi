//
//  ArticleDetailPresenter.swift
//  NewsApi
//
//  Created by mauldy.putra on 20/06/23.
//

import Foundation

protocol ArticleDetailPresenterInterface {
    var router: RouterInterface? { get set }
    var interactor: NewsInteractorInterface? { get set }
    var view: ArticleDetailViewInterface? { get set }
    var url: String? { get set }
}

class ArticleDetailPresenter: ArticleDetailPresenterInterface {
    var router: RouterInterface?
    
    var interactor: NewsInteractorInterface?
    
    var view: ArticleDetailViewInterface?
    
    var url: String?
}
