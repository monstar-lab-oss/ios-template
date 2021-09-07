//
//  App+Style.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
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
