//
//  AppCoordinator.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import UIKit
import Platform

final class AppCoordinator: CoordinatorType {

    let window: UIWindow

    var viewController: UIViewController {
        guard let rootVC = window.rootViewController else {
            fatalError("Window's `rootViewController` must be set first by calling `start` method")
        }
        return rootVC
    }

    private(set) var childCoordinators: [CoordinatorType]

    init(window: UIWindow) {
        self.window = window
        self.childCoordinators = []
    }

    func start() {
        App.Style.setup()
        let coordinator = MainTabBarCoordinator(
            useCaseProvider: Platform.UseCaseProvider(
                baseURL: App.Server.baseURL
            )
        )
        addChild(coordinator)
        coordinator.parentCoordinator = self.eraseToAnyCoordinator()
        coordinator.start()
        let rootVC = coordinator.viewController
        self.window.rootViewController = rootVC
        self.window.makeKeyAndVisible()
    }

    func addChild(_ coordinator: CoordinatorType) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: CoordinatorType) {
        guard let index = childCoordinators.firstIndex(where: { $0 === coordinator }) else { return }
        childCoordinators.remove(at: index)
    }
}
