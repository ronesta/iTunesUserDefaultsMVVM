//
//  SearchViewModel.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import Foundation

final class SearchViewModel {
    var albums: Observable<[Album]> = Observable([])
    
    private let networkManager = NetworkManager()
    private let storageManager = StorageManager()

    var searchHistory: [String] {
        return storageManager.getSearchHistory()
    }

    func searchAlbums(with term: String) {
        if let savedAlbums = storageManager.loadAlbums(for: term) {
            albums.value = savedAlbums
            return
        }

        networkManager.fetchAlbums(albumName: term) { [weak self] result in
            switch result {
            case .success(let albums):
                DispatchQueue.main.async {
                    self?.albums.value = albums.sorted { $0.collectionName < $1.collectionName }
                    self?.storageManager.saveAlbums(albums, for: term)
                    print("Successfully loaded \(albums.count) albums.")
                }
            case .failure(let error):
                print("Failed to load images with error: \(error.localizedDescription)")
            }
        }
    }

    func getAlbumsCount() -> Int {
        return albums.value.count
    }

    func getAlbum(at index: Int) -> Album {
        return albums.value[index]
    }
}
