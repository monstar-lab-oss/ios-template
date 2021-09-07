//
//  NavigationCoordinator.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import UIKit.UINavigationController

class NavigationCoordinator: Coordinator<UINavigationController> {

    override init(viewController: UINavigationController = .init(), childCoordinators: [CoordinatorType] = .init()) {
        super.init(viewController: viewController, childCoordinators: childCoordinators)
    }

    override func start() {
        navigationController.delegate = self
    }

    override func removeChild(_ coordinator: CoordinatorType) {
        if coordinator is UINavigationControllerDelegate {
            navigationController.delegate = self
        }
        super.removeChild(coordinator)
    }
}

extension NavigationCoordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let childViewControllers = navigationController.viewControllers
        let transitionCoordinator = navigationController.transitionCoordinator
        let fromViewController = transitionCoordinator?.viewController(forKey: .from)
        guard let poppedViewController = fromViewController, !childViewControllers.contains(poppedViewController) else {
            return
        }
        removeFromParent()
    }
}
