//
//  UITableViewExtension.swift
//  NewsApi
//
//  Created by mauldy.putra on 20/06/23.
//

import UIKit

extension UITableView {
    func registerNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
}
