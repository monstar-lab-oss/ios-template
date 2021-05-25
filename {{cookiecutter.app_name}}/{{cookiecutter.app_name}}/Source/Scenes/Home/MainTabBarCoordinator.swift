//
//  MainTabBarCoordinator.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit
import Combine

final class MainTabBarCoordinator: TabBarCoordinator {
    enum Tab {
        case search
        case PostList
    }

    override func start() {
        [.search, .PostList].forEach(createTab)
        let viewControllers = childCoordinators.compactMap {
            $0.viewController
        }
        tabBarController.setViewControllers(viewControllers, animated: false)
    }

    func createTab(_ tab: Tab) {
        switch tab {
        case .search:
            let coordinator = LoginCoordinator()
            addChild(coordinator)
            coordinator.start()
            coordinator.viewController.tabBarItem = tab.tabBarItem
        case .PostList:
            let coordinator = PostListCoordinator()
            addChild(coordinator)
            coordinator.start()
            coordinator.parentCoordinator = self.eraseToAnyCoordinator()
            coordinator.viewController.tabBarItem = tab.tabBarItem
        }
    }
}

extension MainTabBarCoordinator.Tab {

    var tabBarItem: UITabBarItem {
        switch self {
        case .search:
            return UITabBarItem(title: "Search", systemName: "magnifyingglass", tag: 0)
        case .PostList:
            return UITabBarItem(title: "POSTs", systemName: "rectangle.grid.2x2.fill", tag: 1)
        }
    }
}

private extension UITabBarItem {
    convenience init(title: String, systemName: String, tag: Int) {
        self.init(
            title: title,
            image: UIImage(
                systemName: systemName,
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 20,
                    weight: .medium
                )
            )!,
            tag: tag
        )
    }
}
