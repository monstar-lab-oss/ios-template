//
//  DomainEntityConvertible.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Foundation

protocol DomainEntityConvertible {
    associatedtype DomainEntity

    func asDomainEntity() -> DomainEntity
}
