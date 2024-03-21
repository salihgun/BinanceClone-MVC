//
//  UIView+Ext.swift
//  BinanceClone
//
//  Created by Salih Gün on 9.03.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
