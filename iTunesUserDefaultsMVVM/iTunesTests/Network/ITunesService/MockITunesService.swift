//
//  MockITunesService.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 18.04.2025.
//

import Foundation
@testable import iTunesUserDefaultsMVVM

final class MockITunesService: ITunesServiceProtocol {
    private(set) var albumName: String?
    var result: Result<[Album], Error>?
    
    func loadAlbums(albumName: String, completion: @escaping (Result<[Album], Error>) -> Void) {
        self.albumName = albumName
        if let result = result {
            completion(result)
        }
    }

    func loadAlbumsWithInvalidJSON(albumName: String, completion: @escaping (Result<[Album], Error>) -> Void) {
        let invalidJSON = "".data(using: .utf8)!

        do {
            let _ = try JSONDecoder().decode(PostAlbums.self, from: invalidJSON)
            completion(.success([]))
        } catch {
            completion(.failure(error))
        }
    }
}
