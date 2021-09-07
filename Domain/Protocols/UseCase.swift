//
//  UseCase.swift
//  Domain
//
//  Created by Hiroshi Oshiro on 2021-04-23.
//  Copyright © 2021 DWANGO Co., Ltd All rights reserved.
//

import Foundation

public protocol UseCase {
    associatedtype Parameters
    associatedtype Success
    func execute(_ parameters: Parameters, completion: ((Result<Success, Error>) -> Void)?)
    func abort()
}

public extension UseCase {

    func abort() {
        fatalError("Abort Method not implemented. To use this method you must implement it first.")
    }

    func eraseToAnyUseCase() -> AnyUseCase<Parameters, Success> {
        AnyUseCase(self)
    }
}
