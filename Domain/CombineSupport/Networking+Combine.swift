//
//  Networking+Combine.swift
//  Platform
//
//  Created by Aarif Sumra on 2021/06/03.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

#if canImport(Combine)
import Combine

extension Networking {
    /// Returns a publisher that wraps a  network requestl.
    ///
    /// The publisher publishes data when the task completes, or terminates if the task fails with an error.
    /// - Parameter request: The URL request for which to send network request
    /// - Returns: A type erased publisher that wraps data result
    func sendRequestPublisher(_ request: URLRequest) -> AnyPublisher<Result<Data, NetworkingError>, Never> {
        Future { promise in
            self.send(request) { result in
                promise(.success(result))
            }
        }.eraseToAnyPublisher()
    }
}
#endif
