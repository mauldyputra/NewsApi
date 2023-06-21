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

class NewsCategoriesController: UIViewController, NewsCategoryViewInterface {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var navBar: UINavigationBar!
    
    var selectedCategory: Category = .business
    var newsType: NewsEnum = .categories
    var presenterCategory: NewsCategoryPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIsLoadingWithAlpha(true)
        setupView()
    }
    
    func setupView() {
        setupNavBar(title: "News Categories")
        
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
        tableView.registerNIB(with: NewsSourceCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        setIsLoadingWithAlpha(false)
    }
}

extension NewsCategoriesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell", for: indexPath) as! NewsSourceCell
        cell.configure(title: Category.allCases[indexPath.row].value)
        cell.selectionStyle = .none
        self.tableView.separatorStyle = .singleLine
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect category")
        selectedCategory = Category.allCases[indexPath.row]
        if selectedCategory.value.lowercased() == Category.all.value.lowercased() {
            NewsUserDefaults.setNewsCategoryKey(nil)
        } else {
            NewsUserDefaults.setNewsCategoryKey(selectedCategory.value)
        }
        
        presenterCategory?.didSelectCategory(view: self)
    }
}
