//
//  StoryboardInstantiatable.swift
//  BoxOffice
//
//  Created by Aarif Sumra on 2021/07/16.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Foundation

public protocol StoryboardInstantiatable: class {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String? { get }
    static var storyboardBundle: Bundle? { get }
}

extension StoryboardInstantiatable {
    static var storyboardIdentifier: String? { return nil }
    static var storyboardBundle: Bundle? { return nil }
}
