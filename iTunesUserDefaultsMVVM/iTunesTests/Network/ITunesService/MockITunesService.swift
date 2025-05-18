//
//  MockITunesServiceForViewModel.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 18.04.2025.
//

import Foundation
@testable import iTunesUserDefaultsMVVM

final class MockITunesService: ITunesServiceProtocol {
    private(set) var loadAlbumsCallCount = 0
    private(set) var loadLabumsCompletions = [(Result<[Album], Error>) -> Void]()
    private(set) var loadAlbumsArgsTerms = [String]()

    var stubbedAlbumsResult: Result<[Album], Error>?

    func loadAlbums(albumName: String, completion: @escaping (Result<[Album], Error>) -> Void) {
        loadAlbumsCallCount += 1
        loadLabumsCompletions.append(completion)
        loadAlbumsArgsTerms.append(albumName)

        if let result = stubbedAlbumsResult {
            completion(result)
        }
    }
}
