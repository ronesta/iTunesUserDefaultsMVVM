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

    private let viewModel: SearchHistoryViewModelProtocol
    private let tableViewDataSource: SearchHistoryDataSourceProtocol

    var onSelect: ((IndexPath) -> Void)?

    init(viewModel: SearchHistoryViewModelProtocol,
         tableViewDataSource: SearchHistoryDataSourceProtocol
    ) {
        self.viewModel = viewModel
        self.tableViewDataSource = tableViewDataSource
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateSearchHistory()
    }

    private func setupNavigationBar() {
        title = "History"
    }

    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = .systemGray6

        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func bindViewModel() {
        viewModel.searchHistory.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(indexPath)
    }
}
