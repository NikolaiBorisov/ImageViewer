//
//  DataFetcherService.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import Foundation

protocol DataFetcherServiceProtocol {
    var networkDataFetcher: NetworkDataFetcherProtocol { get }
    
    func fetchImages(completion: @escaping (Result<MarsImageDTO?, AppError>) -> Void)
}

/// Class fetches data from data Model
final class DataFetcherService {
    
    var networkDataFetcher: NetworkDataFetcherProtocol
    
    // MARK: - Initializers
    
    init(dataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()) {
        self.networkDataFetcher = dataFetcher
    }
    
}

// MARK: - DataFetcherServiceProtocol

extension DataFetcherService: DataFetcherServiceProtocol {
    
    func fetchImages(completion: @escaping (Result<MarsImageDTO?, AppError>) -> Void) {
        let urlString = AppURL.marsPhotoURL
        networkDataFetcher.fetchJSONData(urlString: urlString, completion: completion)
    }
    
}
