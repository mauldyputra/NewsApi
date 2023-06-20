//
//  NewsSourcesController.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import UIKit

class NewsSourcesController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
//    var presenter: NewsCategoryPresenterInterface?
    var newsSources: [NewsCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News Sources"
//        presenter?.startFetchingNewsCategories()
//        showProgressIndicator(view: self.view)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension NewsSourcesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell", for: indexPath) as! NewsSourceCell
        cell.configure(title: newsSources[indexPath.row].source?.name)
        
        return cell
    }
}
