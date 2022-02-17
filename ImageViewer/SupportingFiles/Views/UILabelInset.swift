//
//  UILabelInset.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

/// Adds insets to label content
final class InsetLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 5,
            right: 0))
        )
    }
    
}
