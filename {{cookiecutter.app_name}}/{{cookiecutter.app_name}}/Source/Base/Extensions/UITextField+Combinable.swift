//
//  UITextField+Combinable.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit
import Combine

extension Combinable where Self: UITextField {
    /// Returns a publisher that emits events when `.allEditingEvents` sent on UITextField.
    ///
    /// - Parameters:
    /// - Returns: A publisher that emits events when action taken on control.
    func textPublisher() -> AnyPublisher<String?, Never> {
        return publisher(for: .allEditingEvents)
            .map { control in (control as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}
