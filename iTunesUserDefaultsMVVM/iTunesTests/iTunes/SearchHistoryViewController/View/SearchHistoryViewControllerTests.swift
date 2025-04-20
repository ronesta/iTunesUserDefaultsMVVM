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

    func testViewWillAppearUpdatesSearchHistory() {
        viewController.viewWillAppear(false)

        XCTAssertTrue(mockViewModel.updateSearchHistoryCalled)
    }

    func testBindViewModelReloadsTableView() {
        let tableView = viewController.view.subviews.compactMap { $0 as? UITableView }.first!
        
        let exp = expectation(description: "reloadData called")

        mockViewModel.searchHistory.value = ["test"]

        DispatchQueue.main.async {
            XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
}
