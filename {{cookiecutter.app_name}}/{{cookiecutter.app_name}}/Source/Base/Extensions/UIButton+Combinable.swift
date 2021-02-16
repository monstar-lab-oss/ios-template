//
//  UIButton+Combinable.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit.UIButton
import Combine

extension Combinable where Self: UIButton {
    /// Returns a publisher that emits events when `.touchUpInside` sent on button.
    ///
    /// - Parameters:
    /// - Returns: A publisher that emits events when action taken on button.
    func tapPublisher() -> AnyPublisher<Void, Never> {
        return publisher(for: .touchUpInside)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
