//
//  NewsCategoriesController.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import UIKit

protocol NewsCategoryViewInterface: AnyObject {
    var presenterCategory: NewsCategoryPresenterInterface? { get set }
}

protocol NewsSourceViewInterface: AnyObject {
    var presenterSource: NewsSourcePresenterInterface? { get set }
    
    func update(with sources: [NewsSource])
    func update(with error: String)
}

protocol NewsArticleViewInterface: AnyObject {
    var presenterArticle: NewsArticlePresenterInterface? { get set }
    
    func update(with news: [NewsCategory])
    func update(with error: String)
}

class NewsCategoriesController: UIViewController, NewsCategoryViewInterface, NewsSourceViewInterface, NewsArticleViewInterface {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var newsCategories: [NewsCategory] = []
    var newsSources: [NewsSource] = []
    var selectedCategory: Category = .business
    var newsType: NewsEnum = .categories
    var presenterCategory: NewsCategoryPresenterInterface?
    var presenterSource: NewsSourcePresenterInterface?
    var presenterArticle: NewsArticlePresenterInterface?
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
            NewsUserDefaults.setNewsCategoryKey(selectedCategory.value)
        }
        
        setupTableView()
    }
    
    func setupNavBar(title: String) {
        let navigationItem = UINavigationItem(title: title)
        
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
        tableView.reloadData()
        
        if newsType != .categories {
            refreshControl = UIRefreshControl()
            refreshControl.backgroundColor = .clear
            refreshControl.tintColor = .black
            
            refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
            
            self.tableView.addSubview(refreshControl)
        }
    }
    
    @objc func pullToRefresh(sender: AnyObject) {
        self.refreshControl?.beginRefreshing()
        switch newsType {
        case .categories:
            print("This is not fetch")
        case .sources:
            self.newsSources = []
            self.presenterSource?.refreshData(completion: {
                self.refreshControl.endRefreshing()
            })
        case .articles:
            self.newsCategories = []
            self.presenterArticle?.refreshData(completion: {
                self.refreshControl.endRefreshing()
            })
        }
    }
    
    func update(with sources: [NewsSource]) {
        DispatchQueue.main.async {
            self.newsSources.append(contentsOf: sources)
            self.tableView.reloadData()
        }
    }
    
    func update(with news: [NewsCategory]) {
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
        switch newsType {
        case .categories:
            return Category.allCases.count
        case .sources:
            return newsSources.count
        default:
            return newsCategories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch newsType {
        case .categories:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell", for: indexPath) as! NewsSourceCell
            cell.configure(title: Category.allCases[indexPath.row].value)
            cell.selectionStyle = .none
            self.tableView.separatorStyle = .singleLine
            
            return cell
        case .sources:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell", for: indexPath) as! NewsSourceCell
            cell.configure(title: newsSources[indexPath.row].name)
            cell.selectionStyle = .none
            self.tableView.separatorStyle = .singleLine
            
            return cell
        default:
            if newsCategories.isEmpty == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCategoryCell", for: indexPath) as! NewsCategoryCell
                cell.configure(data: newsCategories[indexPath.row])
                cell.selectionStyle = .none
                
                if indexPath.row > newsCategories.count - 2,
                   tableView.indexPathsForVisibleRows?.contains(IndexPath(row: indexPath.row - 2, section: indexPath.section)) ?? false {
                    self.presenterArticle?.loadMoreData()
                }
                
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch newsType {
        case .categories:
            selectedCategory = Category.allCases[indexPath.row]
            NewsUserDefaults.setNewsCategoryKey(Category.allCases[indexPath.row].value)
            print("didSelect category")
        case .sources:
            print("didSelect source")
        default:
            print("didSelect article")
        }
    }
}
