//
//  Router.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation
import UIKit

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterQuotesProtocol: AnyObject {
    
    static func createCategoriesModule() -> UINavigationController
    static func createSourcesModule() -> UIViewController
    static func createArticlesModule() -> UIViewController
    static func createArticleDetailModule(with url: String) -> UIViewController
    
    func pushToSource(on view: NewsCategoryViewInterface)
    func pushToArticle(on view: NewsSourceViewInterface)
    func pushToArticleDetail(on view: NewsArticleViewInterface, with url: String)
}

class NewsRouter: PresenterToRouterQuotesProtocol {
    static func createCategoriesModule() -> UINavigationController {
        let viewController = NewsCategoriesController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: NewsCategoryPresenterInterface = NewsCategoryPresenter()
        
        viewController.presenterCategory = presenter
        viewController.presenterCategory?.router = NewsRouter()
        viewController.presenterCategory?.view = viewController
        viewController.presenterCategory?.interactor = NewsInteractor()
        viewController.presenterCategory?.interactor?.presenterCategory = presenter
        
        return navigationController
    }
    
    static func createSourcesModule() -> UIViewController {
        let viewController = NewsSourcesController()
        
        let presenter: NewsSourcePresenterInterface = NewsSourcePresenter()
        
        viewController.presenterSource = presenter
        viewController.presenterSource?.router = NewsRouter()
        viewController.presenterSource?.view = viewController
        viewController.presenterSource?.interactor = NewsInteractor()
        viewController.presenterSource?.interactor?.presenterSource = presenter
        
        return viewController
    }
    
    static func createArticlesModule() -> UIViewController {
        let viewController = NewsArticlesController()
        
        let presenter: NewsArticlePresenterInterface = NewsArticlePresenter()
        
        viewController.presenterArticle = presenter
        viewController.presenterArticle?.router = NewsRouter()
        viewController.presenterArticle?.view = viewController
        viewController.presenterArticle?.interactor = NewsInteractor()
        viewController.presenterArticle?.interactor?.presenterArticle = presenter
        
        return viewController
    }
    
    static func createArticleDetailModule(with url: String) -> UIViewController {
        let viewController = ArticleDetailViewController()
        
        let presenter: ArticleDetailPresenterInterface = ArticleDetailPresenter()
        
        viewController.presenterArticleDetail = presenter
        viewController.presenterArticleDetail?.router = NewsRouter()
        viewController.presenterArticleDetail?.view = viewController
        viewController.presenterArticleDetail?.interactor = NewsInteractor()
        viewController.presenterArticleDetail?.url = url
        viewController.presenterArticleDetail?.interactor?.presenterArticleDetail = presenter
        
        return viewController
    }
    
    func pushToSource(on view: NewsCategoryViewInterface) {
        let sourceViewController = NewsRouter.createSourcesModule()
            
        let viewController = view as! NewsCategoriesController
        viewController.navigationController?.pushViewController(sourceViewController, animated: true)
    }
    
    func pushToArticle(on view: NewsSourceViewInterface) {
        let articleViewController = NewsRouter.createArticlesModule()
            
        let viewController = view as! NewsSourcesController
        viewController.navigationController?.pushViewController(articleViewController, animated: true)
    }
    
    func pushToArticleDetail(on view: NewsArticleViewInterface, with url: String) {
        let articleDetailViewController = NewsRouter.createArticleDetailModule(with: url)
            
        let viewController = view as! NewsArticlesController
        viewController.navigationController?.pushViewController(articleDetailViewController, animated: true)
    }
}
