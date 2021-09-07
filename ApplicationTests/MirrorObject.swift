//
//  MirrorObject.swift
//  TemplateTests
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

class MirrorObject {
    let mirror: Mirror

    init(subject: Any) {
        self.mirror = Mirror(reflecting: subject)
    }

    func extract<T>(variableName: StaticString = #function) -> T? {
        return mirror.descendant("\(variableName)") as? T
    }
}
