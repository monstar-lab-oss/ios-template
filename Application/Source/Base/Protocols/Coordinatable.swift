//
//  Coordinatable.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

protocol Coordinatable: class {
    associatedtype Route
    func coordinate(to route: Route)
}

extension Coordinatable {
    func eraseToAnyCoordinatable() -> AnyCoordinatable<Route> {
        AnyCoordinatable(self)
    }
}
