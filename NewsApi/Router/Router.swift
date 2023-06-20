//
//  Router.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation
import UIKit

typealias EntryPoint = UIViewController

protocol RouterInterface: AnyObject {
    var entry: EntryPoint? { get }
    static func initial() -> RouterInterface
    static func source() -> RouterInterface
    static func article() -> RouterInterface
    static func detail() -> RouterInterface
}

class Router: RouterInterface {
    var entry: EntryPoint?
    
    static func initial() -> RouterInterface {
        let router = Router()
        
        var view: NewsCategoryViewInterface = NewsCategoriesController()
        var presenter: NewsCategoryPresenterInterface = NewsCategoryPresenter()
        var interactor: NewsInteractorInterface = NewsInteractor()
        
        view.presenterCategory = presenter
        interactor.presenterCategory = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    static func source() -> RouterInterface {
        let router = Router()
        
        var view: NewsSourceViewInterface = NewsCategoriesController()
        var presenter: NewsSourcePresenterInterface = NewsSourcePresenter()
        var interactor: NewsInteractorInterface = NewsInteractor()

        view.presenterSource = presenter
        interactor.presenterSource = presenter

        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        router.entry = view as? EntryPoint
        
        return router
    }
    
    static func article() -> RouterInterface {
        let router = Router()
        
        var view: NewsArticleViewInterface = NewsCategoriesController()
        var presenter: NewsArticlePresenterInterface = NewsArticlePresenter()
        var interactor: NewsInteractorInterface = NewsInteractor()

        view.presenterArticle = presenter
        interactor.presenterArticle = presenter

        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        router.entry = view as? EntryPoint
        
        return router
    }
    
    static func detail() -> RouterInterface {
        let router = Router()
        
        var view: ArticleDetailViewInterface = ArticleDetailViewController()
        var presenter: ArticleDetailPresenterInterface = ArticleDetailPresenter()
        var interactor: NewsInteractorInterface = NewsInteractor()
        
        view.presenterArticleDetail = presenter
        interactor.presenterArticleDetail = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
