//
//  NewsUserDefaults.swift
//  NewsApi
//
//  Created by mauldy.putra on 20/06/23.
//

import Foundation

class NewsUserDefaults {
    static let newsCategory = "news_category"
    static let newsSearchArticle = "search_news_article"
    static let newsSource = "news_source"
    
    static func setNewsCategoryKey(_ category: String?) {
        UserDefaults.standard.set(category, forKey: newsCategory)
    }
    
    static func getNewsCategoryKey() -> String? {
        let category = UserDefaults.standard.string(forKey: newsCategory)
        return category
    }
    
    static func setSearchNewsArticleKey(_ search: String?) {
        UserDefaults.standard.set(search, forKey: newsSearchArticle)
    }
    
    static func getSearchNewsArticleKey() -> String? {
        let search = UserDefaults.standard.string(forKey: newsSearchArticle)
        return search
    }
    
    static func setNewsSourceKey(_ category: String) {
        UserDefaults.standard.set(category, forKey: newsSource)
    }
    
    static func getNewsSourceKey() -> String {
        let source = UserDefaults.standard.string(forKey: newsSource)
        return source ?? "-"
    }
    
    static func resetNewsCategory() {
        UserDefaults.standard.removeObject(forKey: newsCategory)
    }
    
    static func resetNewsSource() {
        UserDefaults.standard.removeObject(forKey: newsSource)
    }
    
    static func resetSearchNews() {
        UserDefaults.standard.removeObject(forKey: newsSearchArticle)
    }
}
