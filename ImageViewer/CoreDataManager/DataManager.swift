//
//  DataManager.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import Foundation
import CoreData

final class DataManager {
    
    // MARK: - Public Properties
    
    static let shared = DataManager()
    
    // MARK: - Private Properties
    
    private var coreDataManager = CoreDataManagerImpl.shared
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public Methods
    
    public func loadData(using model: [Photo], completion: (([Images]) -> Void)? = nil) {
        let images = coreDataManager.fetchData(for: Images.self)
        if images.count > 0 {
            completion?(images)
        } else {
            for image in model {
                let context = coreDataManager.getContext()
                let imageObject = coreDataManager.createObject(from: Images.self)
                imageObject.id = Int64(image.id)
                imageObject.takenDate = image.earthDate
                imageObject.image = image.imgSrc
                coreDataManager.save(context: context)
            }
        }
    }
    
}
