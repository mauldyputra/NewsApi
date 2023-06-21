//
//  NewsArticle.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import Foundation
import ObjectMapper

class ErrorModel: Mappable {
    var status: String?
    var code: String?
    var message: String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        status <- map["status"]
        code <- map["code"]
        message <- map["message"]
    }
}
