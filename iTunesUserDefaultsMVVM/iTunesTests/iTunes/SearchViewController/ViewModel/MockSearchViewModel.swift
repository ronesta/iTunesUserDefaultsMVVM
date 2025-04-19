//
//  MockSearchViewModel.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 19.04.2025.
//

import Foundation
@testable import iTunesUserDefaultsMVVM

final class MockSearchViewModel: SearchViewModelProtocol {
    var albums: Observable<[Album]> = Observable([])
    var errorMessage: Observable<String?> = Observable(nil)
    
    var searchButtonClickedTerm: String?
    var didTypeSearchText: String?
    var searchFromHistoryTerm: String?

    func didTypeSearch(_ text: String) {
        didTypeSearchText = text
    }

    func searchButtonClicked(with text: String?) {
        searchButtonClickedTerm = text
    }
    
    func searchFromHistory(with term: String) {
        searchFromHistoryTerm = term
    }

    func getAlbumsCount() -> Int {
        albums.value.count
    }

    func getAlbum(at index: Int) -> Album {
        albums.value[index]
    }

}
