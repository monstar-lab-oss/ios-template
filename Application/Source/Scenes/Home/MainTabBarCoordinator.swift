//
//  MainTabBarCoordinator.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain

import class UIKit.UINavigationController
import class UIKit.UITabBarItem
import class UIKit.UIImage

final class MainTabBarCoordinator: TabBarCoordinator {
    
    private let useCaseProvider: UseCaseProvider
        
    init(useCaseProvider provider: UseCaseProvider) {
        self.useCaseProvider = provider
        super.init()
    }
    
    enum Tab {
        case postList
    }

    override func start() {
        [.postList].forEach(createTab)
        let viewControllers = childCoordinators.compactMap {
            $0.viewController
        }
        tabBarController.setViewControllers(viewControllers, animated: false)
    }

    private func createTab(_ tab: Tab) {
        let coordinator = makeCooordinator(forTab: tab)
        addChild(coordinator)
        coordinator.start()
        coordinator.viewController.tabBarItem = tab.tabBarItem
    }
    
    private func makeCooordinator(forTab tab: Tab) -> Coordinator<UINavigationController> {
        switch tab {
        case .postList:
            return PostListCoordinator(useCaseProvider: useCaseProvider)
        }
    }
}

extension MainTabBarCoordinator.Tab {

    var tabBarItem: UITabBarItem {
        switch self {
        case .postList:
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
