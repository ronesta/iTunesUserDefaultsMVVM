//
//  SceneDelegate.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 25.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let storageManager = StorageManager()
        let networkManager = NetworkManager(storageManager: storageManager)

        let searchViewController = SearchViewController()
        let searchCollectionViewDataSource = SearchCollectionViewDataSource()
        let searchViewModel = SearchViewModel(networkManager: networkManager,
                                              storageManager: storageManager)

        searchViewController.viewModel = searchViewModel
        searchViewController.storageManager = storageManager
        searchViewController.collectionViewDataSource = searchCollectionViewDataSource

        searchCollectionViewDataSource.viewModel = searchViewModel
        searchCollectionViewDataSource.networkManager = networkManager

        let searchHistoryViewController = SearchHistoryViewController()
        let earchHistoryTableViewDataSource = SearchHistoryTableViewDataSource()
        let searchHistoryModel = SearchHistoryViewModel(storageManager: storageManager)

        searchHistoryViewController.viewModel = searchHistoryModel
        searchHistoryViewController.tableViewDataSource = earchHistoryTableViewDataSource

        earchHistoryTableViewDataSource.viewModel = searchHistoryModel

        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        let searchTabBarItem = UITabBarItem(title: "Search",
                                            image: UIImage(systemName: "magnifyingglass"),
                                            tag: 0)
        searchTabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        searchNavigationController.tabBarItem = searchTabBarItem

        let historyViewController = SearchHistoryViewController()
        let historyNavigationController = UINavigationController(rootViewController: historyViewController)
        let historyTabBarItem = UITabBarItem(title: "History",
                                             image: UIImage(systemName: "clock"),
                                             tag: 1)
        historyTabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        historyNavigationController.tabBarItem = historyTabBarItem

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [searchNavigationController,
                                            historyNavigationController]

        tabBarController.tabBar.barTintColor = .white

        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}
