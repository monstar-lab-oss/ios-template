//
//  AnyCoordinator.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import UIKit.UIViewController

struct AnyCoordinator {

    private let base: CoordinatorType

    init(_ base: CoordinatorType) {
        self.base = base
    }

    func removeChild(_ coordinator: CoordinatorType) {
        base.removeChild(coordinator)
    }
}
