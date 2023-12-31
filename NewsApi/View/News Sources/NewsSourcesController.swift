//
//  NewsSourcesController.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import UIKit

protocol NewsSourceViewInterface: AnyObject {
    var presenterSource: NewsSourcePresenterInterface? { get set }
    var hasMore: Bool? { get set }
    
    func update(with sources: [NewsSource])
    func updateLoadMore(with sources: [NewsSource])
    func update(with error: String)
}

class NewsSourcesController: UIViewController, NewsSourceViewInterface {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var navBar: UINavigationBar!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var titleEmptyView: UILabel!
    
    var presenterSource: NewsSourcePresenterInterface?
    var hasMore: Bool? = false
    var refreshControl: UIRefreshControl!
    var newsSources: [NewsSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setIsLoadingWithAlpha(true)
        page = 1
        presenterSource?.interactor?.fetchSources()
    }
    
    func setupView() {
        setupNavBar(title: NewsEnum.sources.title)
        
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
        tableView.isHidden = self.newsSources.isEmpty == true ? true : false
        emptyView.isHidden = self.newsSources.isEmpty == true ? false : true
        searchBar.isUserInteractionEnabled = self.newsSources.isEmpty == true ? false : true
    }
    
    @objc func pullToRefresh(sender: AnyObject) {
        refreshControl?.beginRefreshing()
        newsSources = []
        setIsLoadingWithAlpha(true)
        presenterSource?.refreshData(completion: {
            self.setIsLoadingWithAlpha(false)
            self.refreshControl.endRefreshing()
        })
    }
    
    func update(with sources: [NewsSource]) {
        setIsLoadingWithAlpha(true)
        DispatchQueue.main.async {
            self.hasMore = sources.count == pageSize
            self.newsSources.append(contentsOf: sources)
            self.configureEmptyView()
            self.tableView.reloadData()
            self.setIsLoadingWithAlpha(false)
        }
    }
    
    func updateLoadMore(with sources: [NewsSource]) {
        setIsLoadingWithAlpha(true)
        DispatchQueue.main.async {
            self.hasMore = sources.count == pageSize
            self.newsSources.append(contentsOf: sources)
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

extension NewsSourcesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if newsSources.isEmpty == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell", for: indexPath) as! NewsSourceCell
            cell.configure(title: newsSources[indexPath.row].name)
            cell.selectionStyle = .none
            
            if indexPath.row > newsSources.count - 2,
               tableView.indexPathsForVisibleRows?.contains(IndexPath(row: indexPath.row - 2, section: indexPath.section)) ?? false, hasMore == true {
                presenterSource?.loadMoreData()
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect source")
        guard let id = newsSources[indexPath.row].id else {
            AlertView().showAlert(title: "Sorry!", message: "Source id is nil", viewController: self)
            return
        }
        NewsUserDefaults.setNewsSourceKey(id)
        NewsUserDefaults.resetSearchNews()
        
        presenterSource?.didSelectSource(view: self)
    }
}

extension NewsSourcesController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.setIsLoadingWithAlpha(true)
        print("search source")
        guard let text = searchBar.text else {
            AlertView().showAlert(title: "Sorry!", message: "Your text can't be read", viewController: self)
            return
        }
        newsSources = newsSources.filter{ $0.name?.lowercased().contains(text.lowercased()) == true }
        tableView.reloadData()
        setIsLoadingWithAlpha(false)
        
        view.endEditing(true)
    }
}
