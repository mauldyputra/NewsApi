//
//  ArticleDetailViewController.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import UIKit
import WebKit

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        guard let url = self.url else {
            return
        }
        let link = URL(string: url)!
        let request = URLRequest(url: link)
        webView?.load(request)
    }
}
