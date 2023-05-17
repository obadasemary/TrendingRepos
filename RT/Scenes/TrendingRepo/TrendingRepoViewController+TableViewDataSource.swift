//
//  TrendingRepoViewController+TableViewDataSource.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 17.05.2023.
//

import UIKit

enum Section {

    case trendingRepositories
}

extension TrendingRepoViewController {

    func configureDataSource() -> UITableViewDiffableDataSource<Section, TrendingRepo> {

        let dataSource = TableViewSkeletonDiffableDataSource(
            tableView: tableView
        ) { tableView, indexPath, _ in

            let cell = tableView.dequeueReusableCell(
                withIdentifier: TrendingRepoTableViewCell.identifier,
                for: indexPath
            ) as? TrendingRepoTableViewCell
            let viewModel = self.viewModel.makeTrendingRepositoriesCellViewModel(at: indexPath.row)
            cell?.configureRepoCell(with: viewModel)

            return cell
        }

        dataSource.defaultRowAnimation = .fade

        return dataSource
    }

    func updateSnapShot(repos: [TrendingRepo]) {

        var snapShot = NSDiffableDataSourceSnapshot<Section, TrendingRepo>()
        snapShot.appendSections([.trendingRepositories])
        snapShot.appendItems(repos)

        dataSource.apply(snapShot)
    }
}
