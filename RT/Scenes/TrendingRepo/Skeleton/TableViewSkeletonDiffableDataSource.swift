//
//  TableViewSkeletonDiffableDataSource.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 17.05.2023.
//

import UIKit
import SkeletonView

class TableViewSkeletonDiffableDataSource: UITableViewDiffableDataSource<Section, TrendingRepo>,
SkeletonTableViewDataSource {
    
    var cellIdentifier = TrendingRepoTableViewCell.identifier
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UITableView.automaticNumberOfSkeletonRows
    }
    
    func collectionSkeletonView(
        _ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        return cellIdentifier
    }
    
    func collectionSkeletonView(
        _ skeletonView: UITableView, prepareCellForSkeleton cell: UITableViewCell, at indexPath: IndexPath
    ) {}
}
