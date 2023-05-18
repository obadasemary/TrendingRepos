//
//  RefreshControl+Ex.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 19.05.2023.
//

import UIKit

extension UIRefreshControl {

    func endRefreshing(delay: TimeInterval) {

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }

            self.endRefreshing()
        }
    }
}
