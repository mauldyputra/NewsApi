//
//  NewsUserDefaults.swift
//  NewsApi
//
//  Created by mauldy.putra on 20/06/23.
//

import Foundation

class NewsUserDefaults {
    static let newsCategory = "news_category"
    
    static func setNewsCategoryKey(_ category: String) {
        UserDefaults.standard.set(category, forKey: newsCategory)
    }
    
    static func getNewsCategoryKey() -> String {
        let category = UserDefaults.standard.string(forKey: newsCategory)
        return category ?? Category.business.value
    }
    
    static func reset() {
        setNewsCategoryKey(Category.business.value)
    }
}
