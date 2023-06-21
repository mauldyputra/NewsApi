//
//  Endpoints.swift
//  NewsApi
//
//  Created by mauldy.putra on 20/06/23.
//

import Foundation

struct API {
    static let baseUrl = "http://newsapi.org/"
    static let apiKey = "1f9bf7d4d97a42d2b64dfc2b27f7970b"
}


protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum News: Endpoint {
        
        case article(source: String, page: Int, pageSize: Int, search: String?)
        case source(category: String?)
        
        public var path: String {
            switch self {
            case .article(let source, let page, let pageSize, let search):
                if let search {
                    return "/top-headlines?sources=\(source)&page=\(page)&pageSize=\(pageSize)&q=\(search)&apiKey=\(API.apiKey)"
                } else {
                    return "/top-headlines?sources=\(source)&page=\(page)&pageSize=\(pageSize)&apiKey=\(API.apiKey)"
                }
            case .source(let category):
                if let category {
                    return "/top-headlines/sources?category=\(category)&apiKey=\(API.apiKey)"
                } else {
                    return "/top-headlines/sources?apiKey=\(API.apiKey)"
                }
            }
        }
        
        
        public var url: String {
            return "\(API.baseUrl)v2\(path)"
        }
    }
}

