//
//  APIService.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

protocol APIService {
    func fetchNewsSources(completion: @escaping (Result<[NewsSource], Error>) -> Void)
    func fetchNewsArticles(completion: @escaping (Result<[NewsModel], Error>) -> Void)
}
