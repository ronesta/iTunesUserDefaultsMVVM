//
//  StorageManager.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 25.01.2025.
//

import Foundation
import UIKit

final class StorageManager: StorageManagerProtocol {
    private let historyKey = "searchHistory"

    func saveAlbums(_ albums: [Album], for searchTerm: String) {
        do {
            let data = try JSONEncoder().encode(albums)
            UserDefaults.standard.set(data, forKey: searchTerm)
        } catch {
            print("Failed to encode characters: \(error)")
        }
    }

    func loadAlbums(for searchTerm: String) -> [Album]? {
        guard let data = UserDefaults.standard.data(forKey: searchTerm),
              let albums = try? JSONDecoder().decode([Album].self, from: data) else {
            return nil
        }

        return albums
    }

    func saveImage(_ image: Data, key: String) {
        UserDefaults.standard.set(image, forKey: key)
    }

    func loadImage(key: String) -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }

    func saveSearchTerm(_ term: String) {
        var history = getSearchHistory()
        if !history.contains(term) {
            history.insert(term, at: 0)
            UserDefaults.standard.set(history, forKey: historyKey)
        }
    }

    func getSearchHistory() -> [String] {
        return UserDefaults.standard.array(forKey: historyKey) as? [String] ?? []
    }

    func clearAlbums() {
        let history = getSearchHistory()
        for term in history {
            UserDefaults.standard.removeObject(forKey: term)
        }
        clearHistory()
    }

    func clearImage(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }

    func clearHistory() {
        UserDefaults.standard.removeObject(forKey: historyKey)
    }
}
