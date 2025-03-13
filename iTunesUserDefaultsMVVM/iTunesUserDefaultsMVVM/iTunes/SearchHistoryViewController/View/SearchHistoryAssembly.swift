//
//  SearchHistoryAssembly.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 01.02.2025.
//

import Foundation
import UIKit

final class SearchHistoryAssembly {
    func build() -> UIViewController {
        let storageManager = StorageManager()

        let viewModel = SearchHistoryViewModel(storageManager: storageManager)

        let tableViewDataSource = SearchHistoryTableViewDataSource(viewModel: viewModel)

        let viewController = SearchHistoryViewController(
            viewModel: viewModel,
            tableViewDataSource: tableViewDataSource
        )

        let navigationController = UINavigationController(rootViewController: viewController)
        let coordinator = SearchHistoryCoordinator(navigationController: navigationController)

        configureOnSelect(for: viewController, with: viewModel, coordinator: coordinator)

        let tabBarItem = UITabBarItem(title: "History",
                                             image: UIImage(systemName: "clock"),
                                             tag: 1)
        tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        navigationController.tabBarItem = tabBarItem

        return navigationController
    }

    private func configureOnSelect(for viewController: SearchHistoryViewController,
                                   with viewModel: SearchHistoryViewModelProtocol,
                                   coordinator: SearchHistoryCoordinatorProtocol
    ) {
        viewController.onSelect = { indexPath in
            let selectedTerm = viewModel.getSearchHistory(at: indexPath.row)
            coordinator.didSelectSearchQuery(with: selectedTerm)
        }
    }
}
