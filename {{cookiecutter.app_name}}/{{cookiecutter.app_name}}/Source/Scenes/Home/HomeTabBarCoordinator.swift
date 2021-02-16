//
//  HomeTabBarCoordinator.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit
import Combine

final class HomeTabBarCoordinator: TabBarCoordinator {
    enum Tab {
        case search
        case {{cookiecutter.domain_model}}List
    }

    override func start() {
        [.search, .{{cookiecutter.domain_model}}List].forEach(createTab)
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
        case .{{cookiecutter.domain_model}}List:
            let coordinator = {{cookiecutter.domain_model}}ListCoordinator()
            addChild(coordinator)
            coordinator.start()
            coordinator.parentCoordinator = self.eraseToAnyCoordinator()
            coordinator.viewController.tabBarItem = tab.tabBarItem
        }
    }
}

extension HomeTabBarCoordinator.Tab {

    var tabBarItem: UITabBarItem {
        switch self {
        case .search:
            return UITabBarItem(title: "Search", systemName: "magnifyingglass", tag: 0)
        case .{{cookiecutter.domain_model}}List:
            return UITabBarItem(title: "{{cookiecutter.domain_model|upper}}s", systemName: "rectangle.grid.2x2.fill", tag: 1)
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
