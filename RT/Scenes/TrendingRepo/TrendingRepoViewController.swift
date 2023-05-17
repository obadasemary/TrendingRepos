//
//  TrendingRepoViewController.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 15.05.2023.
//

import UIKit

private let trendingRepoTableViewCell = "TrendingRepoTableViewCell"
private let trendingRepoScreenTitle = "Trending"

class TrendingRepoViewController: UIViewController {

    // MARK: - @IBOutlet

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    lazy var dataSource = configureDataSource()
    var viewModel: TrendingRepoViewModelProtocol

    // MARK: - Init

    init(viewModel: TrendingRepoViewModelProtocol = TrendingRepoViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: "TrendingRepoViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = trendingRepoScreenTitle

        configureTableView()
        fetchRepositories()
    }

    // MARK: - Configuration

    func configureTableView() {

        tableView.register(
            UINib(nibName: trendingRepoTableViewCell, bundle: nil),
            forCellReuseIdentifier: TrendingRepoTableViewCell.identifier
        )
        tableView.dataSource = dataSource
        tableView.delegate = self
    }

    // MARK: - API Perfom

    private func fetchRepositories() {

        viewModel.fetchTrendingRepositories {  [weak self] result, error  in
            guard let self = self else { return }

            if result == nil {
                DispatchQueue.main.async { [weak self] in
                    print("Error with \(error)")
                }
            } else {
                print("Result \(result?[2])")
                self.updateSnapShot(repos: result!)
            }
        }
    }
}
