//
//  DomainEntityConvertible.swift
//  Platform
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain

protocol DomainEntityConvertible {
    associatedtype DomainEntity: Domain.Entity

    func asDomainEntity() -> DomainEntity
    init(from entity: DomainEntity) 
}
