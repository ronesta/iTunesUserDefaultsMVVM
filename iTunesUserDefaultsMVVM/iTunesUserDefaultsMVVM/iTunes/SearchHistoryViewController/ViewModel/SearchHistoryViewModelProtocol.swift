//
//  SearchHistoryViewModelProtocol.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

protocol SearchHistoryViewModelProtocol {
    var searchHistory: Observable<[String]> { get set }

    func updateSearchHistory()
    func getSearchHistoryCount() -> Int
    func getSearchHistory(at index: Int) -> String
}
