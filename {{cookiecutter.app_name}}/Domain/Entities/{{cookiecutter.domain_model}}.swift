//
//  {{cookiecutter.domain_model}}.swift
//  Domain
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Foundation

public struct {{cookiecutter.domain_model}}: Codable {
    // Required
    public let id: Int
    public let title: String
    // Optionals
    public private(set) var status: String?

    public init(id: Int, title: String, status: String? = nil) {
        self.id = id
        self.title = title
        self.status = status
    }
}

extension {{cookiecutter.domain_model}}: Hashable {
    public static func == (lhs: {{cookiecutter.domain_model}}, rhs: {{cookiecutter.domain_model}}) -> Bool {
        return lhs.id == rhs.id // For now id comparision is enough
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
