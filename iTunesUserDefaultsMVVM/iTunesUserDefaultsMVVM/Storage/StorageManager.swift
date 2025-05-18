//
//  StorageManager.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 25.01.2025.
//

import Foundation

final class StorageManager: StorageManagerProtocol {
    private let historyKey = "searchHistory"
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func saveAlbums(_ albums: [Album], for searchTerm: String) {
        do {
            let data = try JSONEncoder().encode(albums)
            userDefaults.set(data, forKey: searchTerm)
        } catch {
            print("Failed to encode characters: \(error)")
        }
    }

    func loadAlbums(for searchTerm: String) -> [Album]? {
        guard let data = userDefaults.data(forKey: searchTerm),
              let albums = try? JSONDecoder().decode([Album].self, from: data) else {
            return nil
        }

        return albums
    }

    func saveImage(_ image: Data, key: String) {
        userDefaults.set(image, forKey: key)
    }

    func loadImage(key: String) -> Data? {
        return userDefaults.data(forKey: key)
    }

    func saveSearchTerm(_ term: String) {
        var history = getSearchHistory()
        if !history.contains(term) {
            history.insert(term, at: 0)
            userDefaults.set(history, forKey: historyKey)
        }
    }

    func getSearchHistory() -> [String] {
        return userDefaults.array(forKey: historyKey) as? [String] ?? []
    }
}
