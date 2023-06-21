//
//  ArticleDetailViewController.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import UIKit
import WebKit

protocol ArticleDetailViewInterface: AnyObject {
    var presenterArticleDetail: ArticleDetailPresenterInterface? { get set }
    
    func update(with url: String)
}

class ArticleDetailViewController: UIViewController, ArticleDetailViewInterface {
    
    @IBOutlet weak var webView: WKWebView!
    
    var presenterArticleDetail: ArticleDetailPresenterInterface?
    var url: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func update(with url: String) {
        self.url = url
    }
    
    private func setupViews() {
        guard let url = self.url else {
            AlertView().showAlert(title: "Sorry!", message: "url is nil", viewController: self)
            return
        }
        let link = URL(string: url)!
        let request = URLRequest(url: link)
        webView?.load(request)
    }
}
