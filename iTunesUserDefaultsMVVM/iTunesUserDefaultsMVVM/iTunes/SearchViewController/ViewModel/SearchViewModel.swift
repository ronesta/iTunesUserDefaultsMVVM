//
//  SearchViewModel.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import Foundation

final class SearchViewModel: SearchViewModelProtocol {
    var albums: Observable<[Album]> = Observable([])

    private let iTunesService: ITunesServiceProtocol
    private let storageManager: StorageManagerProtocol

    init(iTunesService: ITunesServiceProtocol,
         storageManager: StorageManagerProtocol
    ) {
        self.iTunesService = iTunesService
        self.storageManager = storageManager
    }

    private func saveSearchTerm(_ term: String) {
        storageManager.saveSearchTerm(term)
    }

    func didTypeSearch(_ searchQuery: String) {
        guard !searchQuery.isEmpty else {
            return
        }

        searchAlbums(with: searchQuery)
    }

    func searchButtonClicked(with term: String?) {
        guard let term, !term.isEmpty else {
            return
        }

        saveSearchTerm(term)
        searchAlbums(with: term)
    }

    func searchFromHistory(with term: String) {
        searchAlbums(with: term)
    }

    func searchAlbums(with term: String) {
        if let savedAlbums = storageManager.loadAlbums(for: term) {
            albums.value = savedAlbums
            return
        }

        iTunesService.loadAlbums(albumName: term) { [weak self] result in
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
