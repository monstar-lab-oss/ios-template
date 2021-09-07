//
//  CoordinatorType.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Combine
import UIKit.UIViewController

protocol ChildCoordinatorType {
    var parentCoordinator: AnyCoordinator? { get }
}

protocol CoordinatorType: class {
    var childCoordinators: [CoordinatorType] { get }
    var viewController: UIViewController { get }
    func start()
    func addChild(_ coordinator: CoordinatorType)
    func removeChild(_ coordinator: CoordinatorType)
}

extension CoordinatorType {
    func eraseToAnyCoordinator() -> AnyCoordinator {
        AnyCoordinator(self)
    }
}
