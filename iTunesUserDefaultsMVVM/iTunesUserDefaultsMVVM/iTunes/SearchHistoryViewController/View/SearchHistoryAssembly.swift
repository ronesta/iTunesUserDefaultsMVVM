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

        let searchHistoryViewController = SearchHistoryViewController(
            viewModel: viewModel,
            tableViewDataSource: tableViewDataSource
        )

        let historyNavigationController = UINavigationController(rootViewController: searchHistoryViewController)
        let historyTabBarItem = UITabBarItem(title: "History",
                                             image: UIImage(systemName: "clock"),
                                             tag: 1)
        historyTabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        historyNavigationController.tabBarItem = historyTabBarItem

        return historyNavigationController
    }
}
