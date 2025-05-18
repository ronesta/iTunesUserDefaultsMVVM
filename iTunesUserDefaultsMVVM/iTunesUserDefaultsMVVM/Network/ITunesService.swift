//
//  NetworkManager.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 25.01.2025.
//

import Foundation

final class ITunesService: ITunesServiceProtocol {
    private var counter = 1

    private let urlSession: URLSessionProtocol
    private let dispatchQueue: DispatchQueueProtocol

    init(urlSession: URLSessionProtocol = URLSession.shared,
         dispatchQueue: DispatchQueueProtocol = DispatchQueue.main
    ) {
        self.urlSession = urlSession
        self.dispatchQueue = dispatchQueue
    }

    func loadAlbums(albumName: String, completion: @escaping (Result<[Album], Error>) -> Void) {
        let baseURL = "https://itunes.apple.com/search"
        let term = albumName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?term=\(term)&entity=album&attribute=albumTerm"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        urlSession.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                self.dispatchQueue.async  {
                    completion(.failure(error))
                }
                return
            }

            guard let data else {
                print("No data")
                self.dispatchQueue.async  {
                    completion(.failure(NetworkError.noData))
                }
                return
            }

            do {
                let albums = try JSONDecoder().decode(PostAlbums.self, from: data).results
                self.dispatchQueue.async  {
                    completion(.success(albums))
                    print("Load data \(self.counter)")
                    self.counter += 1
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                self.dispatchQueue.async  {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
