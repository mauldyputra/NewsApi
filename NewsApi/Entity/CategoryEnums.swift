//
//  CategoryEnums.swift
//  NewsApi
//
//  Created by mauldy.putra on 20/06/23.
//

import Foundation

enum Category: CaseIterable {
    case all
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var value: String {
        switch self {
        case .all:
            return "All"
        case .business:
            return "Business"
        case .entertainment:
            return "Entertainment"
        case .general:
            return "General"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        }
    }
}
