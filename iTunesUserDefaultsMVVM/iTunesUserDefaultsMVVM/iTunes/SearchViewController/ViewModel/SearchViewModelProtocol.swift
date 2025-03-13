//
//  SearchViewModelProtocol.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import Foundation

protocol SearchViewModelProtocol {
    var albums: Observable<[Album]> { get set }

    func didTypeSearch(_ searchQuery: String)
    func searchButtonClicked(with term: String?)
    func searchFromHistory(with term: String)
    func getAlbumsCount() -> Int
    func getAlbum(at index: Int) -> Album
}
