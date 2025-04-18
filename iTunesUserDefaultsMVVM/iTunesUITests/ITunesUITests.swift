//
//  iTunesUITests.swift
//  iTunesUITests
//
//  Created by Ибрагим Габибли on 18.04.2025.
//

import XCTest

final class ITunesUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: - SearchViewController
    func testSearchBarExistsAndWorks() {
        let searchBar = app.searchFields["Search Albums"]

        XCTAssertTrue(searchBar.exists)

        searchBar.tap()
        searchBar.typeText("Test Album")

        let keyboardPredicate = NSPredicate(format: "exists == false")

        expectation(for: keyboardPredicate, evaluatedWith: app.keyboards.element, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertFalse(app.keyboards.element.exists)
    }

    func testCollectionViewExists() throws {
        let collectionView = app.collectionViews.firstMatch

        XCTAssertTrue(collectionView.exists)
    }

    func testCollectionViewDisplaysResults() {
        performSearch(with: "Album")

        let collectionView = app.collectionViews.element

        waitForCellsToAppear(in: collectionView)

        XCTAssertTrue(collectionView.cells.count > 0)
    }

    func testCollectionViewCellExists() {
        performSearch(with: "Sample Album")

        let firstCell = app.collectionViews.cells.element(boundBy: 0)

        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))

        let albumImageView = firstCell.images["albumImageView"]
        let albumNameLabel = firstCell.staticTexts["albumNameLabel"]
        let artistNameLabel = firstCell.staticTexts["artistNameLabel"]

        XCTAssertTrue(albumImageView.exists)
        XCTAssertTrue(albumNameLabel.exists)
        XCTAssertTrue(artistNameLabel.exists)
    }

    // MARK: - AlbumViewController
    func testAlbumDetailsAreDisplayedCorrectly() throws {
        performSearch(with: "Sample Album")

        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        firstCell.tap()

        let albumImageView = app.images["albumImageView"]
        let albumNameLabel = app.staticTexts["albumNameLabel"]
        let artistNameLabel = app.staticTexts["artistNameLabel"]
        let collectionPriceLabel = app.staticTexts["collectionPriceLabel"]

        XCTAssertTrue(albumImageView.exists)
        XCTAssertTrue(albumNameLabel.exists)
        XCTAssertTrue(artistNameLabel.exists)
        XCTAssertTrue(collectionPriceLabel.exists)
    }

    // MARK: - SearchHistoryViewController
    func testSearchHistoryAreDisplayedCorrectly() {
        let tabBar = app.tabBars.firstMatch
        let historyTabButton = tabBar.buttons["History"]

        XCTAssertTrue(historyTabButton.exists)

        historyTabButton.tap()

        let tableView = app.tables.element(matching: .table, identifier: "searchHistoryTableView")

        XCTAssertTrue(tableView.exists)
    }

    func testSelectingHistoryItemDisplaysResults() {
        let tabBar = app.tabBars.firstMatch
        let historyTabButton = tabBar.buttons["History"]

        historyTabButton.tap()

        let tableView = app.tables.element(matching: .table, identifier: "searchHistoryTableView")
        let firstCell = tableView.cells.element(boundBy: 0)

        XCTAssertTrue(firstCell.exists)
        firstCell.tap()

        let collectionView = app.collectionViews.firstMatch

        XCTAssertTrue(collectionView.exists)
    }

    // MARK: - Support functions
    private func performSearch(with text: String) {
        let searchBar = app.searchFields["Search Albums"]

        searchBar.tap()
        searchBar.typeText("\(text)")
    }

    private func waitForCellsToAppear(in collectionView: XCUIElement) {
        let cellsPredicate = NSPredicate(format: "cells.count > 0")

        expectation(for: cellsPredicate, evaluatedWith: collectionView, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }

    override func tearDownWithError() throws {
        app = nil
    }
}
