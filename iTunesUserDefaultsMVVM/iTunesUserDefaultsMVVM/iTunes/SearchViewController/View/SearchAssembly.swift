//
//  SearchAssembly.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 01.02.2025.
//

import Foundation
import UIKit

final class SearchAssembly {
    func build() -> UIViewController {
        let storageManager = StorageManager()
        let iTunesService = ITunesService()
        let imageLoader = ImageLoader(storageManager: storageManager)

        let viewModel = SearchViewModel(
            iTunesService: iTunesService,
            storageManager: storageManager
        )

        let collectionViewDataSource = SearchCollectionViewDataSource(
            viewModel: viewModel,
            imageLoader: imageLoader
        )

        let searchViewController = SearchViewController(viewModel: viewModel,
                                                        storageManager: storageManager,
                                                        collectionViewDataSource: collectionViewDataSource
        )

        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        let searchTabBarItem = UITabBarItem(title: "Search",
                                            image: UIImage(systemName: "magnifyingglass"),
                                            tag: 0)
        searchTabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        searchNavigationController.tabBarItem = searchTabBarItem

        return searchNavigationController
    }
}
