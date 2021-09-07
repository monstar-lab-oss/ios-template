//
//  UseCase+Combine.swift
//  Domain
//
//  Created by Aarif Sumra on 2021/06/05.
//  Copyright © 2021 DWANGO Co., Ltd All rights reserved.
//

#if canImport(Combine)
import Combine

public extension UseCase {

    func executePublisher(_ parameters: Parameters) -> AnyPublisher<Success, Error> {
        Future { promise in
            self.execute(parameters) { result in
                promise(result)
            }
        }.eraseToAnyPublisher()
    }
}

#endif
