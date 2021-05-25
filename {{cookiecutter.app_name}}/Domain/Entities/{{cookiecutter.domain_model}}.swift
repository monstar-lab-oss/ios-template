//
//  {{cookiecutter.domain_model}}.swift
//  Domain
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Foundation

public protocol {{cookiecutter.domain_model}}Entity: Entity {
    // Required
    var id: String { get }
    var title: String { get }
    // `Optional`s
    var body: String? { get }
}

// Conformance to codable done here because it can not be done as extension. Proper place would be in the Platform module
public struct {{cookiecutter.domain_model}}: Codable {
    // Required
    public let id: Int
    public let title: String
    // `Optional`s
    public private(set) var body: String? = nil
}

extension {{cookiecutter.domain_model}}: Hashable {
    public static func == (lhs: {{cookiecutter.domain_model}}, rhs: {{cookiecutter.domain_model}}) -> Bool {
        return lhs.id == rhs.id // For now id comparision is enough
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
