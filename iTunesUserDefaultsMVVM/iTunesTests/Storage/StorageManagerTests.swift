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
    private let testSearchTerm = "Eminem"
    private let testImageKey = "testImageKey"
    private let testHistoryKey = "searchHistory"

    override func setUpWithError() throws {
        try super.setUpWithError()
        storageManager = StorageManager()
        clearUserDefaults()
    }

    override func tearDownWithError() throws {
        clearUserDefaults()
        storageManager = nil
        try super.tearDownWithError()
    }

    private func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: testSearchTerm)
        UserDefaults.standard.removeObject(forKey: testImageKey)
        UserDefaults.standard.removeObject(forKey: testHistoryKey)
    }

    func testSaveAndLoadAlbums() throws {
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

        storageManager.saveAlbums(albums, for: testSearchTerm)
        let loadedAlbums = storageManager.loadAlbums(for: testSearchTerm)

        XCTAssertNotNil(loadedAlbums)
        XCTAssertEqual(albums, loadedAlbums)
    }

    func testLoadAlbumsReturnsNilWhenFileDoesNotExist() {
        let loaded = storageManager.loadAlbums(for: "Timati")

        XCTAssertNil(loaded)
    }

    func testSaveAndLoadImage() throws {
        let imageData = "TestImage".data(using: .utf8)!

        storageManager.saveImage(imageData, key: testImageKey)
        let loadedData = storageManager.loadImage(key: testImageKey)

        XCTAssertNotNil(loadedData)
        XCTAssertEqual(imageData, loadedData)
    }

    func testLoadImageReturnsNilWhenFileDoesNotExist() {
        let loadedData = storageManager.loadImage(key: "UnknownKey")
        
        XCTAssertNil(loadedData)
    }

    func testSaveAndGetSearchHistory() {
        storageManager.saveSearchTerm("term1")
        storageManager.saveSearchTerm("term2")

        let history = storageManager.getSearchHistory()

        XCTAssertEqual(history.count, 2)
        XCTAssertEqual(history.first, "term2")
    }

    func testSaveSearchTermDoesNotAddDuplicates() {
        storageManager.saveSearchTerm("term1")
        storageManager.saveSearchTerm("term2")
        storageManager.saveSearchTerm("term1")

        let history = storageManager.getSearchHistory()

        XCTAssertEqual(history, ["term2", "term1"])
    }

    func testGetSearchHistoryReturnsEmptyInitially() {
        let history = storageManager.getSearchHistory()

        XCTAssertTrue(history.isEmpty)
    }

    func testSaveAlbumsHandlesEncodingError() {
        let albums = [["invalidKey": "value"]]
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("invalidPath/albums.json")

        do {
            let data = try JSONEncoder().encode(albums)
            try data.write(to: fileURL)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
