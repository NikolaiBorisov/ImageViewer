//
//  ImageCachingService.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

protocol ImageCachingServiceProtocol {
    func getImageWith(url: URL, completion: @escaping (UIImage?) -> Void)
}

final class ImageCachingService {
    
    // MARK: - Private Properties
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Private Methods
    
    /// Method creates URLSessionDataTask for getImageWith()
    private func createDataTask(
        from request: URLRequest,
        with url: URL,
        completion: @escaping (UIImage?) -> Void
    ) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  data != nil,
                  let data = data,
                  let image = UIImage(data: data),
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let self = self else { return }
            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
}

// MARK: - ImageCachingServiceProtocol

extension ImageCachingService: ImageCachingServiceProtocol {
    
    /// Method downloads image and checks if our image has been already cached
    func getImageWith(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let task = createDataTask(from: request, with: url, completion: completion)
            task.resume()
        }
    }
    
}
