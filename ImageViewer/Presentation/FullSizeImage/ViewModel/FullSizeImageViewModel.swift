//
//  FullSizeImageViewModel.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

final class FullSizeImageViewModel {
    
    // MARK: - Public Properties
    
    public var singleImage = UIImage()
    public var vcTitle = ""
    public lazy var mainView = FullSizeImageView()
    public var downloadDate = Date()
    
    // MARK: - Public Methods
    
    public func setupFullSizeImage() {
        mainView.fullSizeImageView.image = singleImage
    }
    
    public func setupDownloadDate() {
        mainView.downloadDateLabel.text = Date.getFormattedDate(from: downloadDate)
    }
    
}
