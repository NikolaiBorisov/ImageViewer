//
//  NetworkService.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(urlString: String, completion: @escaping (Result<Data?, AppError>) -> Void)
}

/// Class contains methods for requesting data and creating URLSessionDataTask
final class NetworkService {
    
    // MARK: - Private Methods
    
    /// Method creates Data Task and returns URLSessionDataTask
    private func createDataTask(
        from request: URLRequest,
        completion: @escaping (Result<Data?, AppError>) -> Void
    ) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                guard let data = data, !data.isEmpty else {
                    completion(.failure(AppError.somethingWrongWithUrlSessionData))
                    return
                }
                completion(.success(data))
            }
        }
    }
    
}

// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    
    /// Method requests data using URL
    func request(urlString: String, completion: @escaping (Result<Data?, AppError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(AppError.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
}
