//
//  NetworkDataFetcher.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import Foundation

protocol NetworkDataFetcherProtocol {
    var decoder: JSONDecoder { get }
    var networking: NetworkServiceProtocol { get }
    var internetAvailabilityService: InternetAvailabilityService { get }
    
    func fetchJSONData<T: Codable>(urlString: String, completion: @escaping (Result<T?, AppError>) -> Void)
}

/// Class decodes and fetches JSONData
final class NetworkDataFetcher {
    
    var networking: NetworkServiceProtocol
    var internetAvailabilityService = InternetAvailabilityService()
    lazy var decoder = JSONDecoder()
    
    // MARK: - Initializers
    
    init(networking: NetworkServiceProtocol = NetworkService()) {
        self.networking = networking
    }
    
    // MARK: - Private Properties
    
    /// Method decodes JSON file
    private func decodeJSON<T: Codable>(type: T.Type, from: Data?, completion: @escaping (Result<T?, AppError>) -> Void) -> T? {
        guard let data = from else {
            completion(.failure(AppError.noData))
            return nil
        }
        do {
            let objects = try decoder.decode(type.self, from: data)
            completion(.success(objects))
            return objects
        } catch let jsonError {
            print(AppError.badURL, jsonError)
            completion(.failure(AppError.failedParsingJSON))
            return nil
        }
    }
    
}

// MARK: - NetworkDataFetcherProtocol

extension NetworkDataFetcher: NetworkDataFetcherProtocol {
    
    /// Method fetches JSONData
    func fetchJSONData<T: Codable>(urlString: String, completion: @escaping (Result<T?, AppError>) -> Void) {
        guard internetAvailabilityService.isInternetAvailable() else {
            completion(.failure(AppError.noInternetConnection))
            return
        }
        networking.request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                let decoded = self.decodeJSON(type: T.self, from: data, completion: completion)
                completion(.success(decoded))
            case .failure(_):
                completion(.failure(AppError.badURL))
            }
        }
    }
    
}
