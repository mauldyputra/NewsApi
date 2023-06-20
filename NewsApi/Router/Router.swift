//
//  Router.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation
import UIKit

typealias EntryPoint = NewsViewInterface & UIViewController

protocol RouterInterface: AnyObject {
    var entry: EntryPoint? { get }
    static func start() -> RouterInterface
}

class Router: RouterInterface {
    var entry: EntryPoint?
    
    static func start() -> RouterInterface {
        let router = Router()
        
        var view: NewsViewInterface = NewsCategoriesController()
        var presenter: NewsPresenterInterface = NewsPresenter()
        var interactor: NewsInteractorInterface = NewsInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
