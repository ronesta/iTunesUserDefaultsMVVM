//
//  SearchHistoryViewControllerSnapshotTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 20.04.2025.
//

import XCTest
import SnapshotTesting
@testable import iTunesUserDefaultsMVVM

final class SearchHistoryViewControllerSnapshotTests: XCTestCase {
    private var mockViewModel: MockSearchHistoryViewModel!
    private var mockDataSource: MockSearchHistoryDataSource!
    private var viewController: SearchHistoryViewController!

    override func setUp() {
        super.setUp()
        mockViewModel = MockSearchHistoryViewModel()
        mockDataSource = MockSearchHistoryDataSource(viewModel: mockViewModel)
        viewController = SearchHistoryViewController(
            viewModel: mockViewModel,
            tableViewDataSource: mockDataSource
        )
    }

    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        mockDataSource = nil
        super.tearDown()
    }

    func test_GivenEmptySearchHistory_WhenViewLoaded_ThenViewControllerAppearanceMatchesSnapshot() {
        // Given
        let navigationController = UINavigationController(rootViewController: viewController)

        // When
        viewController.loadViewIfNeeded()

        // Then
        assertSnapshot(of: navigationController, as: .image)
    }

    func test_GivenSearchHistory_WhenUpdatingData_ThenShowsUpdatedAppearance() {
        // Given
        let searchHistory = ["Search1", "Search2"]
        let navigationController = UINavigationController(rootViewController: viewController)

        // When
        mockViewModel.searchHistory.value = searchHistory

        // Then
        assertSnapshot(of: navigationController, as: .image)
    }
}
