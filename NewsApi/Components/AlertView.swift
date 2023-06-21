//
//  AlertView.swift
//  NewsApi
//
//  Created by mauldy.putra on 21/06/23.
//

import Foundation
import UIKit

public final class AlertView {
    func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        // Present the alert
        viewController.present(alert, animated: true, completion: nil)
    }
}
