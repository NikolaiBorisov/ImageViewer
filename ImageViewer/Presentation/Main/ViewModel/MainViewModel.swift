//
//  MainViewModel.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit
import CoreData

final class MainViewModel {
    
    // MARK: - Public Properties
    
    public var vcTitle = ""
    public var savedImages = [Images]()
    public let insetForSection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    public var downloadDate = Date()
    
    // MARK: - Private Properties
    
    private var dataFetcherService = DataFetcherService()
    private var dataManager = DataManager.shared
    private var images = [Photo]()
    
    // MARK: - Public Methods
    
    public func getImages(
        completion: @escaping (AppError) -> Void?,
        callbackReload: @escaping () -> Void?
    ) {
        dataFetcherService.fetchImages { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                completion(error)
                print(error)
            case .success(let images):
                guard let images = images?.photos else { return }
                
                if #available(iOS 15, *) {
                    self.downloadDate = .now
                } else {
                    self.downloadDate = Date()
                }
                
                self.images = images
                self.dataManager.loadData(using: self.images) { self.savedImages = $0 }
                callbackReload()
            }
        }
    }
    
}
