//
//  MockUserDefaults.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 04.05.2025.
//

import Foundation
@testable import iTunesUserDefaultsMVVM

final class MockUserDefaults: UserDefaults {
    private(set) var storage = [String: Any]()

    override func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }

    override func data(forKey defaultName: String) -> Data? {
        return storage[defaultName] as? Data
    }

    override func array(forKey defaultName: String) -> [Any]? {
        return storage[defaultName] as? [Any]
    }

    override func object(forKey defaultName: String) -> Any? {
        return storage[defaultName]
    }
}
