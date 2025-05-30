//
//  SearchHistoryViewModel.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import Foundation

final class SearchHistoryViewModel: SearchHistoryViewModelProtocol {
    var searchHistory: Observable<[String]> = Observable([])

    private let storageManager: StorageManagerProtocol

    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
        updateSearchHistory()
    }

    func updateSearchHistory() {
        let history = storageManager.getSearchHistory()
        searchHistory.value = history
    }

    func getSearchHistoryCount() -> Int {
        return searchHistory.value.count
    }

    func getSearchHistory(at index: Int) -> String {
        return searchHistory.value[index]
    }
}
