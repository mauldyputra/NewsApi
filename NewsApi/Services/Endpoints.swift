//
//  Endpoints.swift
//  NewsApi
//
//  Created by mauldy.putra on 20/06/23.
//

import Foundation

struct API {
    static let baseUrl = "http://newsapi.org/"
    static let apiKey = "face311600f24459955ddc7e753f4798"
}


protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum News: Endpoint {
        
        case article(source: String, page: Int, pageSize: Int, search: String?)
        case source(category: String?, page: Int, pageSize: Int)
        
        public var path: String {
            switch self {
            case .article(let source, let page, let pageSize, let search):
                if let search {
                    return "/top-headlines?sources=\(source)&page=\(page)&pageSize=\(pageSize)&q=\(search)&apiKey=\(API.apiKey)"
                } else {
                    return "/top-headlines?sources=\(source)&page=\(page)&pageSize=\(pageSize)&apiKey=\(API.apiKey)"
                }
            case .source(let category, let page, let pageSize):
                if let category {
                    return "/top-headlines/sources?category=\(category)&page=\(page)&pageSize=\(pageSize)&apiKey=\(API.apiKey)"
                } else {
                    return "/top-headlines/sources?&page=\(page)&pageSize=\(pageSize)&apiKey=\(API.apiKey)"
                }
            }
        }
        
        
        public var url: String {
            return "\(API.baseUrl)v2\(path)"
        }
    }
}

