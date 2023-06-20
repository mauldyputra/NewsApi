//
//  NewsArticlesController.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import UIKit

class NewsArticlesController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
//    var presenter: NewsCategoryPresenterInterface?
    var newsArticles: [NewsCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News Articles"
//        presenter?.startFetchingNewsCategories()
//        showProgressIndicator(view: self.view)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension NewsArticlesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCategoryCell", for: indexPath) as! NewsCategoryCell
        cell.configure(data: newsArticles[indexPath.row])
        
        return cell
    }
}
