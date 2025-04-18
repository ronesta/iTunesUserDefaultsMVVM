//
//  MockStorageManager.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 18.04.2025.
//

import Foundation
@testable import iTunesUserDefaultsMVVM

final class MockStorageManager: StorageManagerProtocol {
    private(set) var albums = [String: [Album]]()
    private(set) var images = [String: Data]()
    private(set) var searchHistory = [String]()

    func saveAlbums(_ albums: [Album], for searchTerm: String) {
        self.albums[searchTerm] = albums
    }

    func loadAlbums(for searchTerm: String) -> [Album]? {
        return albums[searchTerm]
    }

    func saveImage(_ image: Data, key: String) {
        images[key] = image
    }

    func loadImage(key: String) -> Data? {
        return images[key]
    }

    func saveSearchTerm(_ term: String) {
        if !searchHistory.contains(term) {
            searchHistory.append(term)
        }
    }

    func getSearchHistory() -> [String] {
        return searchHistory
    }
}
