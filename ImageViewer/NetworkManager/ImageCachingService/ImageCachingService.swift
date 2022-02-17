//
//  ImageCachingService.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

protocol ImageCachingServiceProtocol {
    func getImageWith(url: URL, indexPath: IndexPath, completion: @escaping (UIImage?) -> Void)
}

final class ImageCachingService {
    
    // MARK: - Private Properties
    
    private var imageCache = NSCache<NSIndexPath, UIImage>()
    
    // MARK: - Private Methods
    
    /// Method creates URLSessionDataTask for getImageWith()
    private func createDataTask(
        from request: URLRequest,
        with url: URL,
        for indexPath: IndexPath,
        completion: @escaping (UIImage?) -> Void
    ) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let data = data,
                  let image = UIImage(data: data),
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let self = self else { return }
            self.imageCache.setObject(image, forKey: indexPath as NSIndexPath)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
}

// MARK: - ImageCachingServiceProtocol

extension ImageCachingService: ImageCachingServiceProtocol {
    
    /// Method downloads image and checks if our image has been already cached
    func getImageWith(url: URL, indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: indexPath as NSIndexPath) {
            completion(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let task = createDataTask(from: request, with: url, for: indexPath, completion: completion)
            task.resume()
        }
    }
    
}
