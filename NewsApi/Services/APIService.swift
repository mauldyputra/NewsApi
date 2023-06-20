//
//  APIService.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol APIService {
    func fetchNewsByCategories(completion: @escaping (Result<[NewsCategory], Error>) -> Void)
    func fetchNewsSources(completion: @escaping (Result<[NewsSource], Error>) -> Void)
}
