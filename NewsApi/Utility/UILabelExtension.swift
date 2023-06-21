//
//  UILabelExtension.swift
//  NewsApi
//
//  Created by mauldy.putra on 21/06/23.
//

import UIKit

extension UILabel {
    func sethtml(_ htmlString: String) {
        if let attributedString = try? NSAttributedString(data: Data(htmlString.utf8),
                                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                                          documentAttributes: nil) {
            self.attributedText = attributedString
        } else {
            self.text = htmlString
        }
    }
}

extension String {
    var isHTML: Bool {
        let htmlRegex = try? NSRegularExpression(pattern: "<[^>]+>", options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.utf16.count)
        let matches = htmlRegex?.matches(in: self, options: [], range: range)
        return matches?.count ?? 0 > 0
    }
}
