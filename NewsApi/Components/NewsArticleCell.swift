//
//  NewsArticleCell.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import UIKit

class NewsArticleCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: NewsModel) {
        newsImage.setImage(url: data.urlToImage)
        titleLabel.text = data.title
        sourceLabel.isHidden = true
        authorLabel.isHidden = true
        descriptionLabel.isHidden = true
        
        if let source = data.source {
            authorLabel.isHidden = false
            sourceLabel.text = "Source: \(source)"
        }
        if let author = data.author {
            authorLabel.isHidden = false
            authorLabel.text = "Author: \(author)"
        }
        
        if let description = data.description {
            descriptionLabel.isHidden = false
            if description.isHTML {
                descriptionLabel.sethtml(description)
            } else {
                descriptionLabel.text = description
            }
        }
    }
}
