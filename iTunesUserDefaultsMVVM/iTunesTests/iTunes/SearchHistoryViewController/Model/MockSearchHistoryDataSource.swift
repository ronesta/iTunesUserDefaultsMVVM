//
//  MockSearchHistoryDataSource.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 20.04.2025.
//

import UIKit
@testable import iTunesUserDefaultsMVVM

final class MockSearchHistoryDataSource: NSObject, SearchHistoryDataSourceProtocol, UITableViewDataSource {
    private let viewModel: SearchHistoryViewModelProtocol

    init(viewModel: SearchHistoryViewModelProtocol) {
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getSearchHistoryCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getSearchHistory(at: indexPath.row)
        return cell
    }
}
