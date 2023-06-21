//
//  NewsEnums.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation

enum NewsEnum {
    case categories
    case sources
    case articles
    
    var title: String {
        switch self {
        case .categories:
            return "News Categories"
        case .sources:
            return "News Sources"
        case .articles:
            return "News Articles"
        }
    }
}
