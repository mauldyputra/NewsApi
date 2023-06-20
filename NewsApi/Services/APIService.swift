//
//  APIService.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol APIService {
    func fetchNewsHeadlines(completion: @escaping (Result<[NewsCategory], Error>) -> Void)
    func fetchNewsCategories(completion: @escaping (Result<[NewsCategory], Error>) -> Void)
}
