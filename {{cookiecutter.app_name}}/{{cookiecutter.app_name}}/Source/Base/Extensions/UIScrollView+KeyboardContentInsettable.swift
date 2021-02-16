//
//  UIScrollView+KeyboardContentInsettable.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Combine
import UIKit

protocol KeyboardContentInsettable {
    func registerForKeyboardEvents(with cancellables: inout Set<AnyCancellable>)
}

extension UIScrollView: KeyboardContentInsettable {
    func registerForKeyboardEvents(with cancellables: inout Set<AnyCancellable>) {
        NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillShowNotification
        )
        .compactMap({ $0.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect })
        .map(\.height)
        .map { UIEdgeInsets(top: 0.0, left: 0.0, bottom: $0, right: 0.0)}
        .assign(to: \.contentInset, on: self)
        .store(in: &cancellables)

        NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillHideNotification
        )
        .map({_ in UIEdgeInsets.zero})
        .assign(to: \.contentInset, on: self)
        .store(in: &cancellables)
    }
}
