//
//  LoadingView.swift
//  NewsApi
//
//  Created by mauldy.putra on 21/06/23.
//

import UIKit
import ASSpinnerView

class LoadingView: UIView {
    @IBOutlet var contentView: UIView?
    @IBOutlet private var spinner: ASSpinnerView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        spinner?.spinnerDuration = 0.5
        spinner?.spinnerLineWidth = 3
        spinner?.spinnerStrokeColor = UIColor(red: 49, green: 53, blue: 56, alpha: 1).cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
