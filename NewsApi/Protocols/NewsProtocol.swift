//
//  NewsProtocol.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol ReusableView: class {}

protocol NibLoadableView: class {}

protocol IndicateTableView: class {
    func showLoading()
    func hideLoading()
}
