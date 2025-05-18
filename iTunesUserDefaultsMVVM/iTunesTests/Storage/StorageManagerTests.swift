//
//  StorageManagerTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 18.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVVM

final class StorageManagerTests: XCTestCase {
    private var storageManager: StorageManager!
    private var mockUserDefaults: MockUserDefaults!
    private let testSearchTerm = "Eminem"
    private let testImageKey = "testImageKey"
    private let testHistoryKey = "searchHistory"

    override func setUp() {
        super.setUp()
        mockUserDefaults = MockUserDefaults()
        storageManager = StorageManager(userDefaults: mockUserDefaults)
    }

    override func tearDown() {
        storageManager = nil
        mockUserDefaults = nil
        super.tearDown()
    }


    private func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: testSearchTerm)
        UserDefaults.standard.removeObject(forKey: testImageKey)
        UserDefaults.standard.removeObject(forKey: testHistoryKey)
    }

    func test_GivenAlbums_WhenSaveAndLoad_ThenReturnsSameAlbums() throws {
        // Given
        let albums = [
            Album(artistId: 111051,
                  artistName: "Eminem",
                  collectionName: "The Eminem Show",
                  artworkUrl100: "url_to_image",
                  collectionPrice: 10.99
                 ),
            Album(artistId: 20044,
                  artistName: "Eminem",
                  collectionName: "Levitating",
                  artworkUrl100: "url_to_image",
                  collectionPrice: 9.99
                 )
        ]

        // When
        storageManager.saveAlbums(albums, for: testSearchTerm)
        let loadedAlbums = storageManager.loadAlbums(for: testSearchTerm)

        // Then
        XCTAssertNotNil(loadedAlbums)
        XCTAssertEqual(albums, loadedAlbums)
    }

    func testGivenNotExistFile_WhenLoadAlbums_ThenReturnsNil() {
        // Given
        let nonExistentKey = "Timati"

        // When
        let loaded = storageManager.loadAlbums(for: nonExistentKey)

        // Then
        XCTAssertNil(loaded)
    }

    func testGivenImageData_WhenSaveImage_ThenReturnsSameImageData() throws {
        // Given
        let imageData = "TestImage".data(using: .utf8)!
        let imageKey = "testImageKey"

        // When
        storageManager.saveImage(imageData, key: imageKey)
        let loadedImageData = storageManager.loadImage(key: imageKey)

        // Then
        XCTAssertNotNil(loadedImageData)
        XCTAssertEqual(imageData, loadedImageData)
    }

    func testGivenNonExistImageKey_WhenLoadImage_ThenReturnsNil() {
        // Given
        let nonExistentKey = "nonExistentKey"

        // When
        let loadedImageData = storageManager.loadImage(key: nonExistentKey)

        // Then
        XCTAssertNil(loadedImageData)
    }

    func test_GivenSavedTerms_WhenGetSearchHistory_ThenMostRecentIsFirst() {
        // Given
        storageManager.saveSearchTerm("term1")
        storageManager.saveSearchTerm("term2")

        // When
        let history = storageManager.getSearchHistory()

        // Then
        XCTAssertEqual(history.count, 2)
        XCTAssertEqual(history.first, "term2")
    }

    func test_GivenDuplicateTerm_WhenSaveSearchTerm_ThenNoDuplicatesInHistory() {
        // Given
        storageManager.saveSearchTerm("term1")
        storageManager.saveSearchTerm("term2")
        storageManager.saveSearchTerm("term1")

        // When
        let history = storageManager.getSearchHistory()

        // Then
        XCTAssertEqual(history, ["term2", "term1"])
    }

    func test_GivenNoHistory_WhenGetSearchHistory_ThenHistoryIsEmpty() {
        // Given
        // No setup required

        // When
        let history = storageManager.getSearchHistory()

        // Then
        XCTAssertTrue(history.isEmpty)

    }
}
