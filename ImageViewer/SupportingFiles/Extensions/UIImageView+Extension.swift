//
//  UIImageView+Extension.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import Foundation

import UIKit

// MARK: - Setup Image for UIImageView

extension UIImageView {
    
    func setupImage(
        for view: UIImageView,
        with service: ImageCachingService,
        url: String,
        completion: @escaping () -> Void
    ) {
        guard let imgURL = URL(string: url) else { return }
        service.getImageWith(url: imgURL) { image in
            view.image = image
            completion()
        }
    }
    
}
