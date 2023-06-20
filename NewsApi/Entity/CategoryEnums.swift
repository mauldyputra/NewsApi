//
//  CategoryEnums.swift
//  NewsApi
//
//  Created by mauldy.putra on 20/06/23.
//

import Foundation

enum Category: String {
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    
    var value: String {
        return self.rawValue
    }
}
