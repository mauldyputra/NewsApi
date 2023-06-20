//
//  NewsSourceCell.swift
//  NewsApi
//
//  Created by mauldy.putra on 19/06/23.
//

import UIKit

class NewsSourceCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(title: String?) {
        self.titleLabel.text = title
    }
}
