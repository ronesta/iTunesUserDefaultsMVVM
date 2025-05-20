//
//  MockSearchViewModel.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 19.04.2025.
//

import Foundation
@testable import iTunesUserDefaultsMVVM

final class MockSearchViewModel: SearchViewModelProtocol {
    private(set) var didTypeSearchCallCount = 0
    private(set) var didTypeSearchArgsTexts = [String]()

    private(set) var searchButtonClickedCallCount = 0
    private(set) var searchButtonClickedArgsTerms = [String?]()

    private(set) var searchFromHistoryCallCount = 0
    private(set) var searchFromHistoryArgsTerms = [String]()

    var albums: Observable<[Album]> = Observable([])
    var errorMessage: Observable<String?> = Observable(nil)

    func didTypeSearch(_ text: String) {
        didTypeSearchCallCount += 1
        didTypeSearchArgsTexts.append(text)
    }

    func searchButtonClicked(with text: String?) {
        searchButtonClickedCallCount += 1
        searchButtonClickedArgsTerms.append(text)
    }

    func searchFromHistory(with term: String) {
        searchFromHistoryCallCount += 1
        searchFromHistoryArgsTerms.append(term)
    }

    func getAlbumsCount() -> Int {
        albums.value.count
    }

    func getAlbum(at index: Int) -> Album {
        albums.value[index]
    }
}
