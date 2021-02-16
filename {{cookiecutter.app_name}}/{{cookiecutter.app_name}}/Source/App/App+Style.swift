//
//  App+Style.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit

extension App {
    enum Style {}
}

extension App.Style {
    enum Color {
        static let primary = UIColor(red: 155.0/255.0, green: 100.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        static let secondary = UIColor(red: 200.0/255.0, green: 150.0/255.0, blue: 124.0/255.0, alpha: 1.0)
    }
    enum Font {

    }

    static func setup() {
        UITabBar.appearance().barStyle = .default
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
    }
}
