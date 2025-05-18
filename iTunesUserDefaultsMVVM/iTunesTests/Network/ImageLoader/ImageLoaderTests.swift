//
//  ImageLoaderTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 18.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVVM

final class ImageLoaderTests: XCTestCase {
    private var imageLoader: ImageLoader!
    private var mockStorageManager: MockStorageManager!
    private var mockURLSession: MockURLSession!
    private var mockDispatchQueue: MockDispatchQueue!

    override func setUp() {
        super.setUp()
        mockStorageManager = MockStorageManager()
        mockURLSession = MockURLSession()
        mockDispatchQueue = MockDispatchQueue()
        imageLoader = ImageLoader(
            storageManager: mockStorageManager,
            urlSession: mockURLSession,
            dispatchQueue: mockDispatchQueue
        )
    }

    override func tearDown() {
        imageLoader = nil
        mockStorageManager = nil
        mockURLSession = nil
        mockDispatchQueue = nil
        super.tearDown()
    }

    func testGivenImageInStorage_WhenLoadImage_ThenReturnsImageFromStorage() {
        // Given
        let urlString = "https://example.com/test.png"
        let testImage = UIImage(systemName: "star")!
        let imageData = testImage.pngData()!
        let key = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? urlString
        mockStorageManager.saveImage(imageData, key: key)

        // When
        imageLoader.loadImage(from: urlString) { image in
            // Then
            XCTAssertNotNil(image)
        }
    }

    func testGivenImageNotInStorage_WhenLoadImage_ThenLoadsImageFromNetworkAndCachesIt() {
        // Given
        let urlString = "https://example.com/test.png"
        let testImage = UIImage(systemName: "star")!
        let imageData = testImage.pngData()!
        let key = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? urlString
        mockURLSession.data = imageData

        // When
        imageLoader.loadImage(from: urlString) { image in
            // Then
            XCTAssertNotNil(image)
            XCTAssertEqual(self.mockStorageManager.images[key], imageData)
        }
    }

    func testGivenInvalidURL_WhenLoadImage_ThenReturnsNil() {
        // Given
        let urlString = "not-a url"

        // When
        imageLoader.loadImage(from: urlString) { image in
            // Then
            XCTAssertNil(image)
        }
    }

    func testGivenNetworkError_WhenLoadImage_ThenReturnsNil() {
        // Given
        let urlString = "http://example.com/test3.png"
        mockURLSession.error = NSError(domain: "test", code: 1)

        // When
        imageLoader.loadImage(from: urlString) { image in
            // Then
            XCTAssertNil(image)
        }
    }

    func testGivenInvalidImageData_WhenLoadImage_ThenReturnsNil() {
        // Given
        let urlString = "http://example.com/test4.png"
        mockURLSession.data = Data()

        // When
        imageLoader.loadImage(from: urlString) { image in
            // Then
            XCTAssertNil(image)
        }
    }
}
