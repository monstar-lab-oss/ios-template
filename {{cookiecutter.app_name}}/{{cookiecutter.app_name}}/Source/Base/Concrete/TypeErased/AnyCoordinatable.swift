//
//  AnyCoordinatable.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

/// A coordinatable that performs type erasure by wrapping another coordinatable.
///
/// ``AnyCoordinatable`` is a concrete implementation of ``Coordinatable`` that has no significant
///  properties of its own, and passes through all events to wrapped coordinatable.
///
/// Use ``AnyCoordinatable`` to wrap a coordinator whose type has details you don’t want to expose
///  across API boundaries, such as different modules. Wrapping a ``CoordinatorType`` with
///   ``AnyCoordinatable`` also prevents callers from accessing its ``Coordinator.start()`` method.
///
/// You can use ``Coordinatable/eraseToAnyCoordinatable()`` operator to wrap a publisher with ``AnyCoordinatable``.

class AnyCoordinatable<Route>: Coordinatable {

    private let _navigationBlock: (Route) -> Void

    init<N: Coordinatable>(_ base: N) where N.Route  == Route {
        _navigationBlock = base.coordinate
    }

    func coordinate(to route: Route) {
        _navigationBlock(route)
    }
}
