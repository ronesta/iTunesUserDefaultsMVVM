//
//  SearchHistoryViewControllerTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 20.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVVM

final class SearchHistoryViewControllerTests: XCTestCase {
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

    func test_GivenViewController_WhenViewWillAppear_ThenUpdatesSearchHistory() {
        // Given viewController

        // When
        viewController.viewWillAppear(false)

        // Then
        XCTAssertTrue(mockViewModel.updateSearchHistoryCalled)
    }

    func test_GivenSearchHistoryChange_WhenBindingViewModel_ThenReloadsTableView() {
        // Given
        let tableView = viewController.view.subviews.compactMap { $0 as? UITableView }.first!
        let expectation = expectation(description: "reloadData called")

        // When
        mockViewModel.searchHistory.value = ["test"]

        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
}
