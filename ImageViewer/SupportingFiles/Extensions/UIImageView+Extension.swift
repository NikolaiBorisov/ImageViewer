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
        with service: ImageCachingService?,
        url: String,
        indexPath: IndexPath,
        completion: @escaping () -> Void
    ) {
        guard let imgURL = URL(string: url) else { return }
        service?.getImageWith(url: imgURL, indexPath: indexPath) { [weak self] image in
            self?.image = image
            completion()
        }
    }
    
}
