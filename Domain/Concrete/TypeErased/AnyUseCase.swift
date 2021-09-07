//
//  AnyUseCase.swift
//  Domain
//
//  Created by Aarif Sumra on 2021/06/29.
//  Copyright © 2021 DWANGO Co., Ltd. All rights reserved.
//

public class AnyUseCase<Parameters, Success>: UseCase {

    private let _execute: (Parameters, ((Result<Success, Error>) -> Void)?) -> Void
    private let _abort: () -> Void

    init<U: UseCase>(_ erasing: U) where U.Parameters == Parameters, U.Success == Success {
        self._execute = erasing.execute
        self._abort = erasing.abort
    }

    public func execute(_ parameters: Parameters, completion: ((Result<Success, Error>) -> Void)?) {
        _execute(parameters, completion)
    }

    public func abort() {
        _abort()
    }
}
