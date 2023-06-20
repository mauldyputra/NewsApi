//
//  Endpoints.swift
//  NewsApi
//
//  Created by mauldy.putra on 20/06/23.
//

import Foundation

struct API {
    static let baseUrl = "http://newsapi.org/"
    static let apiKey = "8008cacaf3fa44f3b6b5f26f1cb624d4"
}


protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum News: Endpoint {
        
        case category(category: String)
        case source(category: String?)
        
        public var path: String {
            switch self {
            case .category(let category):
                return "/top-headlines?&category=\(category)&apiKey=\(API.apiKey)"
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

