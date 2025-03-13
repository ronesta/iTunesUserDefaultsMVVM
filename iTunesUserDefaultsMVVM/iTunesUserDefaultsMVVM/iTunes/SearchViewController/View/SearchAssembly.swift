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

        let viewController = SearchViewController(viewModel: viewModel,
                                                        storageManager: storageManager,
                                                        collectionViewDataSource: collectionViewDataSource
        )

        let navigationController = UINavigationController(rootViewController: viewController)
        let coordinator = SearchCoordinator(viewController: viewController)

        configureOnSelect(for: viewController, with: viewModel, coordinator: coordinator)

        let tabBarItem = UITabBarItem(title: "Search",
                                            image: UIImage(systemName: "magnifyingglass"),
                                            tag: 0)
        tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        navigationController.tabBarItem = tabBarItem

        return navigationController
    }

    private func configureOnSelect(for viewController: SearchViewController,
                                   with viewModel: SearchViewModelProtocol,
                                   coordinator: SearchCoordinatorProtocol
    ) {
        viewController.onSelect = { indexPath in
            let album = viewModel.getAlbum(at: indexPath.item)

            coordinator.didSelect(album: album)
        }
    }
}
