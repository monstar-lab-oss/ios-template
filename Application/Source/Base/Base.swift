//
//  Base.swift
//  Template
//
//  Created by Aarif Sumra on 2021/09/02.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain
import UIKit

protocol HasReuseIdentifier {
    static var reuseIdentifier: String { get }
}

protocol ItemConfigurable {
    associatedtype Item
    func configure(forItem: Item)
}

typealias HashableEntity = Hashable & Entity
