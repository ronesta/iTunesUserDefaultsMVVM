//
//  ImageLoaderTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 18.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVVM

final class ImageLoaderTests: XCTestCase {
    private var imageLoader: MockImageLoader!

    override func setUp() {
        super.setUp()
        imageLoader = MockImageLoader()
    }

    override func tearDown() {
        imageLoader = nil
        super.tearDown()
    }

    func testLoadImageSuccess() {
        let testImage = UIImage(systemName: "person.fill")!
        imageLoader.mockImage = testImage
        imageLoader.shouldReturnError = false

        imageLoader.loadImage(from: "test_url") { image in
            XCTAssertNotNil(image)
            XCTAssertEqual(image, testImage)
        }
    }

    func testLoadImageFailure() {
        imageLoader.shouldReturnError = true

        imageLoader.loadImage(from: "test_url") { image in
            XCTAssertNil(image)
        }
    }

    func testLoadImageInvalidURL() {
        imageLoader.loadImage(from: "") { image in
            XCTAssertNil(image)
        }
    }
}
