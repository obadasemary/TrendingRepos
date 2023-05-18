//
//  TrendingRepoViewController.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 15.05.2023.
//

import UIKit

private let trendingRepoTableViewCell = "TrendingRepoTableViewCell"
private let trendingRepoScreenTitle = "Trending"

enum Section {

    case trendingRepositories
}

typealias TableDataSource = UITableViewDiffableDataSource<Section, TrendingRepo>

class TrendingRepoViewController: UIViewController {

    // MARK: - @IBOutlet

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    var viewModel: TrendingRepoViewModelProtocol

    lazy var dataSource: TableDataSource = {

        let dataSource = TableDataSource(
            tableView: tableView
        ) { tableView, indexPath, _ in

            let cell = tableView.dequeueReusableCell(
                withIdentifier: TrendingRepoTableViewCell.identifier,
                for: indexPath
            ) as? TrendingRepoTableViewCell
            cell?.hideAnimation()
            let viewModel = self.viewModel.makeTrendingRepositoriesCellViewModel(at: indexPath.row)
            cell?.configureRepoCell(with: viewModel)

            return cell
        }

        dataSource.defaultRowAnimation = .fade

        return dataSource
    }()

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

        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(
            UINib(nibName: trendingRepoTableViewCell, bundle: nil),
            forCellReuseIdentifier: TrendingRepoTableViewCell.identifier
        )
        tableView.delegate = self
    }

    // MARK: - Update SnapShot

    func updateSnapShot(repos: [TrendingRepo]) {

        var snapShot = NSDiffableDataSourceSnapshot<Section, TrendingRepo>()
        snapShot.appendSections([.trendingRepositories])
        snapShot.appendItems(repos)

        dataSource.apply(snapShot)
    }

    // MARK: - API Perfom

    private func fetchRepositories() {

        viewModel.fetchTrendingRepositories {  [weak self] result  in
            guard let self = self else { return }

            if result == nil {

            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.updateSnapShot(repos: result!)
                }
            }
        }
    }
}
