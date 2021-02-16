//
//  MirrorObject.swift
//  {{cookiecutter.app_name}}Tests
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
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
