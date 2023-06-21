//
//  UIViewExtension.swift
//  NewsApi
//
//  Created by mauldy.putra on 20/06/23.
//

import UIKit

extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    /* BORDER RADIUS */
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            
            if layer.masksToBounds {
                layer.shouldRasterize = true
                layer.rasterizationScale = UIScreen.main.scale
            } else {
                layer.shouldRasterize = false
            }
        }
        get {
            return layer.cornerRadius
        }
    }
    
    static func nib<T: UIView>(withType type: T.Type, name: String? = nil) -> T {
        let _name = name ?? String(describing: type)
        return Bundle.main.loadNibNamed(_name, owner: self, options: nil)?.first as! T
    }
}
