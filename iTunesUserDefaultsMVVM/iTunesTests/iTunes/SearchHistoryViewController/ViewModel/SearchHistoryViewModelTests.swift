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

    func test_GivenSavedSearchTerms_WhenUpdateSearchHistory_ThenViewModelLoadsSearchHistory() {
        // Given
        let searchHistory = ["Search1", "Search2"]
        searchHistory.forEach { term in
            mockStorageManager.saveSearchTerm(term)
        }

        // When
        viewModel.updateSearchHistory()

        // Then
        XCTAssertEqual(viewModel.searchHistory.value, searchHistory)
    }

    func test_GivenSavedSearchTerms_WhenGetSearchHistoryCount_ThenReturnsCorrectValue() {
        // Given
        let searchHistory = ["Search1", "Search2"]
        searchHistory.forEach { term in
            mockStorageManager.saveSearchTerm(term)
        }
        viewModel.updateSearchHistory()

        // When
        let count = viewModel.getSearchHistoryCount()

        // Then
        XCTAssertEqual(count, 2)
    }

    func test_GivenSavedSearchTerms_WhenGetSearchHistoryAtIndex_ThenReturnsCorrectElement() {
        // Given
        let searchHistory = ["Search1", "Search2"]
        searchHistory.forEach { term in
            mockStorageManager.saveSearchTerm(term)
        }
        viewModel.updateSearchHistory()

        // When
        let element = viewModel.getSearchHistory(at: 1)

        // Then
        XCTAssertEqual(element, "Search2")
    }
}
