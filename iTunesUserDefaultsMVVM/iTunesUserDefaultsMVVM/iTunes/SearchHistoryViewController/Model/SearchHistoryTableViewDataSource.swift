//
//  SearchHistoryTableViewDataSource.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import Foundation
import UIKit

final class SearchHistoryTableViewDataSource: NSObject, SearchHistoryDataSourceProtocol {
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
