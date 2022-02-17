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
    public var downloadDate = Date()
    
    public var showDate: String {
        Date.getFormattedDate(from: downloadDate)
    }
    
}
