//
//  UIViewControllerExtension.swift
//  NewsApi
//
//  Created by mauldy.putra on 21/06/23.
//

import UIKit
import SnapKit

extension UIViewController {
    func setIsLoadingWithAlpha(_ isLoading: Bool, _ alpha: Float = 0.7) {
        let loadingView = UIView.nib(withType: LoadingView.self)
        loadingView.tag = 333
        
        if isLoading {
            guard !(view.subviews.contains(where: { $0.tag == 333 })) else { return }
            
            view.isUserInteractionEnabled = false
            view.addSubview(loadingView)
            loadingView.snp.makeConstraints({ (make) in
                make.leading.trailing.top.bottom.equalTo(view)
            })
            loadingView.contentView?.alpha = CGFloat(alpha)
        } else {
            view.isUserInteractionEnabled = true
            view.subviews.forEach { (v) in
                if v.tag == 333 {
                    v.removeFromSuperview()
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
}
