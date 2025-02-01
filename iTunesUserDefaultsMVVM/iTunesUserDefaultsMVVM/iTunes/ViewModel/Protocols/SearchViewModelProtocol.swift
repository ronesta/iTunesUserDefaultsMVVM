//
//  SearchViewModelProtocol.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import Foundation

protocol SearchViewModelProtocol {
    var albums: Observable<[Album]> { get set }
    var searchHistory: [String] { get }

    func searchAlbums(with term: String)
    func getAlbumsCount() -> Int
    func getAlbum(at index: Int) -> Album
}
