//
//  ImageLoader.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 12.03.2025.
//

import Foundation
import UIKit.UIImage

final class ImageLoader: ImageLoaderProtocol {
    private var counter = 1

    private let storageManager: StorageManagerProtocol
    private let urlSession: URLSessionProtocol
    private let dispatchQueue: DispatchQueueProtocol

    init(storageManager: StorageManagerProtocol,
         urlSession: URLSessionProtocol = URLSession.shared,
         dispatchQueue: DispatchQueueProtocol = DispatchQueue.main
    ) {
        self.storageManager = storageManager
        self.urlSession = urlSession
        self.dispatchQueue = dispatchQueue
    }

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let key = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? urlString

        if let imageData = storageManager.loadImage(key: key),
           let image = UIImage(data: imageData) {
            completion(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        urlSession.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                self.dispatchQueue.async {
                    completion(nil)
                }
                return
            }

            if let data,
               let image = UIImage(data: data) {
                self.storageManager.saveImage(data, key: key)
                self.dispatchQueue.async {
                    completion(image)
                    print("Load image \(self.counter)")
                    self.counter += 1
                }
            } else {
                self.dispatchQueue.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
