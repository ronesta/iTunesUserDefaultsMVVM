//
//  MockSearchHistoryViewModel.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 20.04.2025.
//

import UIKit
@testable import iTunesUserDefaultsMVVM

final class MockSearchHistoryViewModel: SearchHistoryViewModelProtocol {
    var searchHistory: Observable<[String]> = Observable([])
    var updateSearchHistoryCalled = false

    func updateSearchHistory() {
        updateSearchHistoryCalled = true
    }

    func getSearchHistoryCount() -> Int {
        searchHistory.value.count
    }

    func getSearchHistory(at index: Int) -> String {
        searchHistory.value[index]
    }
}
