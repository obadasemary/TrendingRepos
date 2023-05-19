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

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lottieErrorView: LottieErrorView!
    let refreshControl = UIRefreshControl()

    // MARK: - Properties

    var viewModel: TrendingRepoViewModelType
    weak var coordinator: Coordinator?
    var isPullToLoading: Bool = false

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

    init(viewModel: TrendingRepoViewModelType = TrendingRepoViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: "TrendingRepoViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationView()
        lottieErrorView.delegate = self
        configureTableView()
        configureRefreshControl()
        fetchRepositories()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = trendingRepoScreenTitle
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        title = ""
    }

    // MARK: - Configuration

    func configureNavigationView() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear.badge"),
            style: .plain,
            target: self,
            action: #selector(didTapOpenSetting)
        )
        navigationItem.rightBarButtonItem?.tintColor = .label
        navigationController?.navigationBar.tintColor = .label
    }

    func configureTableView() {

        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(
            UINib(nibName: trendingRepoTableViewCell, bundle: nil),
            forCellReuseIdentifier: TrendingRepoTableViewCell.identifier
        )
    }

    func configureRefreshControl() {

        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .systemGray
        tableView.refreshControl = refreshControl
    }

    @objc func didTapOpenSetting() {

        viewModel.goToSettings()
    }

    @objc func handleRefresh() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }

            self.isPullToLoading = true
            self.fetchRepositories()
        }
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

        if !isPullToLoading {

            activityIndicator.startAnimating()
        }

        viewModel.fetchTrendingRepositories {  [weak self] result  in
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.hidesWhenStopped = true
            }
            if result == nil {
                DispatchQueue.main.async { [weak self] in
                    self?.lottieErrorView.isHidden = false
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.updateSnapShot(repos: result!)
                    self?.refreshControl.endRefreshing(delay: 0.0)
                }
            }
        }
    }
}

extension TrendingRepoViewController: LottieErrorDelegate {
    func didTapRetryButton() {

        lottieErrorView.isHidden = true
        fetchRepositories()
    }
}
