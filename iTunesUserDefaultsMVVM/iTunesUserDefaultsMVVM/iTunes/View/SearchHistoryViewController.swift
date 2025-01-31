//
//  SearchHistoryViewController.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 25.01.2025.
//

import UIKit

final class SearchHistoryViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .singleLine
        return tableView
    }()

    private let id = "cell"

    var viewModel: SearchHistoryViewModelProtocol?
    var tableViewDataSource: SearchHistoryDataSourceProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.updateSearchHistory()
    }

    private func setupNavigationBar() {
        title = "History"
    }

    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = .systemGray6

        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: id)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func bindViewModel() {
        viewModel?.searchHistory.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let selectedTerm = viewModel?.getSearchHistory(at: indexPath.row) {
            performSearch(for: selectedTerm)
        }
    }

    func performSearch(for term: String) {
        let searchViewModel = SearchViewModel()
        let searchViewController = SearchViewController()
        searchViewController.viewModel = searchViewModel
        searchViewModel.searchAlbums(with: term)
        searchViewController.searchBar.isHidden = true
        navigationController?.pushViewController(searchViewController, animated: true)
    }
}
