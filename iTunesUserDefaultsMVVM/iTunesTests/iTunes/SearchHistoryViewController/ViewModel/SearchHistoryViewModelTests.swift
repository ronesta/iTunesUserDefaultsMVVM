//
//  SearchHistoryViewModelTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 20.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVVM

final class SearchHistoryViewModelTests: XCTestCase {
    private var mockStorageManager: MockStorageManager!
    private var viewModel: SearchHistoryViewModel!

    override func setUp() {
        super.setUp()
        mockStorageManager = MockStorageManager()
        viewModel = SearchHistoryViewModel(storageManager: mockStorageManager)
    }

    override func tearDown() {
        viewModel = nil
        mockStorageManager = nil
        super.tearDown()
    }

    func testInitialSearchHistoryIsLoaded() {
        let searchHistory = ["Search1", "Search2"]

        searchHistory.forEach { term in
            mockStorageManager.saveSearchTerm(term)
        }

        viewModel.updateSearchHistory()

        XCTAssertEqual(viewModel.searchHistory.value, searchHistory)
    }

    func testGetSearchHistoryCountReturnsCorrectValue() {
        let searchHistory = ["Search1", "Search2"]

        searchHistory.forEach { term in
            mockStorageManager.saveSearchTerm(term)
        }
        
        viewModel.updateSearchHistory()

        let count = viewModel.getSearchHistoryCount()
        XCTAssertEqual(count, 2)
    }

    func testGetSearchHistoryAtIndexReturnsCorrectElement() {
        let searchHistory = ["Search1", "Search2"]

        searchHistory.forEach { term in
            mockStorageManager.saveSearchTerm(term)
        }

        viewModel.updateSearchHistory()

        let element = viewModel.getSearchHistory(at: 1)
        XCTAssertEqual(element, "Search2")
    }

    func testUpdateSearchHistoryUpdatesObservableValue() {
        let searchTerm1 = "Search1"
        mockStorageManager.saveSearchTerm(searchTerm1)

        viewModel.updateSearchHistory()
        XCTAssertEqual(viewModel.searchHistory.value, ["Search1"])

        let searchTerm2 = "Search2"
        mockStorageManager.saveSearchTerm(searchTerm2)

        viewModel.updateSearchHistory()

        XCTAssertEqual(viewModel.searchHistory.value, ["Search1", "Search2"])
    }
}
