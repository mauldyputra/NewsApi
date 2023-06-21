//
//  NewsArticlesController.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import UIKit

protocol NewsArticleViewInterface: AnyObject {
    var presenterArticle: NewsArticlePresenterInterface? { get set }
    var hasMore: Bool? { get set }
    
    func update(with news: [NewsModel])
    func updateLoadMore(with news: [NewsModel])
    func update(with error: String)
}

class NewsArticlesController: UIViewController, NewsArticleViewInterface {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var navBar: UINavigationBar!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var titleEmptyView: UILabel!
    
    var presenterArticle: NewsArticlePresenterInterface?
    var hasMore: Bool? = false
    var refreshControl: UIRefreshControl!
    var newsArticles: [NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setIsLoadingWithAlpha(true)
        page = 1
        presenterArticle?.interactor?.fetchArticles()
    }
    
    func setupView() {
        setupNavBar(title: NewsEnum.articles.title)
        setupTableView()
        searchBar.delegate = self
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
        tableView.registerNIB(with: NewsArticleCell.self)
        tableView.registerNIB(with: NewsSourceCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.reloadData()
        
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .black
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    func configureEmptyView() {
        tableView.isHidden = self.newsArticles.isEmpty == true ? true : false
        emptyView.isHidden = self.newsArticles.isEmpty == true ? false : true
        searchBar.isUserInteractionEnabled = self.newsArticles.isEmpty == true ? false : true
    }
    
    @objc func pullToRefresh(sender: AnyObject) {
        refreshControl?.beginRefreshing()
        newsArticles = []
        setIsLoadingWithAlpha(true)
        presenterArticle?.refreshData(completion: {
            self.setIsLoadingWithAlpha(false)
            self.refreshControl.endRefreshing()
        })
    }
    
    func update(with news: [NewsModel]) {
        setIsLoadingWithAlpha(true)
        DispatchQueue.main.async {
            self.hasMore = news.count == pageSize
            self.newsArticles.append(contentsOf: news)
            self.configureEmptyView()
            self.tableView.reloadData()
            self.setIsLoadingWithAlpha(false)
        }
    }
    
    func updateLoadMore(with news: [NewsModel]) {
        setIsLoadingWithAlpha(true)
        DispatchQueue.main.async {
            self.hasMore = news.count == pageSize
            self.newsArticles.append(contentsOf: news)
            self.configureEmptyView()
            self.tableView.reloadData()
            self.setIsLoadingWithAlpha(false)
        }
    }
    
    func update(with error: String) {
        setIsLoadingWithAlpha(false)
        configureEmptyView()
        titleEmptyView.text = error
    }
    
    @IBAction func refreshTapped(_ sender: UIButton) {
        pullToRefresh(sender: sender)
    }
}

extension NewsArticlesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if newsArticles.isEmpty == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsArticleCell", for: indexPath) as! NewsArticleCell
            cell.configure(data: newsArticles[indexPath.row])
            cell.selectionStyle = .none
            
            if indexPath.row > newsArticles.count - 2,
               tableView.indexPathsForVisibleRows?.contains(IndexPath(row: indexPath.row - 2, section: indexPath.section)) ?? false, hasMore == true {
                presenterArticle?.loadMoreData()
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect article")
        guard let url = newsArticles[indexPath.row].url else {
            print("url is nil")
            AlertView().showAlert(title: "Sorry!", message: "url is nil", viewController: self)
            return
        }
        
        presenterArticle?.didSelectArticle(view: self, url: url)
    }
}

extension NewsArticlesController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.setIsLoadingWithAlpha(true)
        NewsUserDefaults.setSearchNewsArticleKey(searchBar.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
        newsArticles = []
        presenterArticle?.searchArticle(completion: {
            self.tableView.reloadData()
            self.setIsLoadingWithAlpha(false)
        })
        
        view.endEditing(true)
    }
}
