//
//  RefreshControlFactory.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

final class RefreshControlFactory {
    
    static func generate(with color: UIColor? = .systemRed) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = color
        return refreshControl
    }
    
}
