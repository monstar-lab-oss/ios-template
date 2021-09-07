//
//  DomainEntityConvertible.swift
//  Platform
//
//  Created by Hiroshi Oshiro on 2021-04-23.
//  Copyright © 2021 DWANGO Co., Ltd All rights reserved.
//

import Domain

protocol DomainEntityConvertible {
    associatedtype DomainEntity: Domain.Entity

    func asDomainEntity() -> DomainEntity
}
