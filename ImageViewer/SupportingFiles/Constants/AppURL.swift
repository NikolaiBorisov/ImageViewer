//
//  AppURL.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import Foundation

enum AppURL {
    
    // MARK: - NASA APIKey
    
    static let myAPIKey = "YDLcthwpCgRrHtlq98X6VBX8MGAKjcYY7AMMVyim"
    
    // MARK: - MarsPhotoURL
    
    static let marsPhotoURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=\(myAPIKey)"
    
}
