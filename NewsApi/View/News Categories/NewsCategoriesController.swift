//
//  NewsCategoriesController.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import UIKit

protocol NewsViewInterface: AnyObject {
    var presenter: NewsPresenterInterface? { get set }
    
    func update(with news: [NewsCategory])
    func update(with error: String)
}

class NewsCategoriesController: UIViewController, NewsViewInterface {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var newsCategories: [NewsCategory] = []
    var newsType: NewsEnum = .categories
    var presenter: NewsPresenterInterface?
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch newsType {
        case .categories:
            setupNavBar(title: "News Categories")
        case .sources:
            setupNavBar(title: "News Sources")
        case .articles:
            setupNavBar(title: "News Articles")
        }
        
        setupTableView()
    }
    
    func setupNavBar(title: String) {
        let navigationItem = UINavigationItem(title: title)
        let reloadButton = UIBarButtonItem(image: UIImage(named: "options-outline"), style: .plain, target: self, action: #selector(self.showMoreCategory(_:)))
        navigationItem.rightBarButtonItem = reloadButton
        
        navBar.prefersLargeTitles = true
        navBar.setItems([navigationItem], animated: false)
        navBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
    }
    
    func setupTableView() {
        tableView.registerNIB(with: NewsCategoryCell.self)
        tableView.registerNIB(with: NewsSourceCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.backgroundColor = .clear
        self.refreshControl.tintColor = .black
        
        self.refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        self.tableView.addSubview(self.refreshControl)
    }
    
    @objc func pullToRefresh(sender: AnyObject) {
        self.refreshControl?.beginRefreshing()
        self.newsCategories = []
        self.presenter?.refreshData(completion: {
            self.refreshControl.endRefreshing()
        })
    }
    
    @objc func showMoreCategory(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Other Categories", message: "Choose news category", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: Category.business.value, style: .default , handler:{ (UIAlertAction)in
//            self.presenter.didSelectOtherCategory("technology")
        }))
        
        alert.addAction(UIAlertAction(title: Category.entertainment.value, style: .default , handler:{ (UIAlertAction)in
//            self.presenter.didSelectOtherCategory("sport")
        }))
        
        alert.addAction(UIAlertAction(title: Category.general.value, style: .default , handler:{ (UIAlertAction)in
//            self.presenter.didSelectOtherCategory("politics")
        }))
        
        alert.addAction(UIAlertAction(title: Category.health.value, style: .default , handler:{ (UIAlertAction)in
//            self.presenter.didSelectOtherCategory("business")
        }))
        
        alert.addAction(UIAlertAction(title: Category.science.value, style: .default , handler:{ (UIAlertAction)in
//            self.presenter.didSelectOtherCategory("others")
        }))
        
        alert.addAction(UIAlertAction(title: Category.sports.value, style: .default , handler:{ (UIAlertAction)in
//            self.presenter.didSelectOtherCategory("others")
        }))
        
        alert.addAction(UIAlertAction(title: Category.technology.value, style: .default , handler:{ (UIAlertAction)in
//            self.presenter.didSelectOtherCategory("others")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
        }))
        
        self.present(alert, animated: true, completion: {
            
        })
    }
    
    func update(with news: [NewsCategory]) {
        print("Success fetch news")
        DispatchQueue.main.async {
            self.newsCategories.append(contentsOf: news)
            self.tableView.reloadData()
        }
    }
    
    func update(with error: String) {
        print(error)
    }
}

extension NewsCategoriesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch newsType {
        case .categories, .articles :
            if newsCategories.isEmpty == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCategoryCell", for: indexPath) as! NewsCategoryCell
                cell.configure(data: newsCategories[indexPath.row])
                cell.selectionStyle = .none
                
                if indexPath.row > newsCategories.count - 2,
                   tableView.indexPathsForVisibleRows?.contains(IndexPath(row: indexPath.row - 2, section: indexPath.section)) ?? false {
                    self.presenter?.loadMoreData()
                }
                
                return cell
            } else {
                return UITableViewCell()
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell", for: indexPath) as! NewsSourceCell
            cell.configure(title: newsCategories[indexPath.row].source?.name)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
