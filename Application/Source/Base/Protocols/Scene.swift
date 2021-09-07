//
//  Scene.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

public protocol Scene {
    associatedtype Route
    associatedtype View: ViewType
    associatedtype Dependencies
    var view: View { get }
    init(dependencies: Dependencies)
}
