//
//  UIView+Extension.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

// MARK: - Identifier

/// Provides class name as cell Identifier. Use it in register cell method
extension UIView {
    
    static var identifier: String {
        String(describing: self)
    }
    
}

// MARK: - RoundView

extension UIView {
    
    func roundViewWith(cornerRadius: CGFloat = 0, borderColor: UIColor? = nil, borderWidth: CGFloat = 0) {
        if #available(iOS 13.0, *) {
            self.layer.cornerCurve = .continuous
        }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth
    }
    
}
