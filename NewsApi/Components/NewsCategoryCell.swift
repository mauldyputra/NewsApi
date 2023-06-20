//
//  NewsCategoryCell.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import UIKit

class NewsCategoryCell: UITableViewCell {
    
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
    
    func configure(data: NewsCategory) {
        newsImage.setImage(url: data.urlToImage)
        titleLabel.text = data.title
        sourceLabel.text = "Source: \(data.source?.name ?? "-")"
        authorLabel.text = "Author: \(data.author ?? "-")"
        descriptionLabel.text = data.description
    }
}
