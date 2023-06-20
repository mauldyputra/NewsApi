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
        
        case headline
        case category(category: String)
        
        public var path: String {
            switch self {
            case .headline: return "/top-headlines?country=id&category=technology&apiKey=\(API.apiKey)"
            case .category(let category):
                return "/top-headlines?country=id&category=\(category)&apiKey=\(API.apiKey)"
            }
        }
        
        
        public var url: String {
            return "\(API.baseUrl)v2\(path)"
        }
    }
}

