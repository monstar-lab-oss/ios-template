//
//  Network.swift
//  Platform
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//
import Domain

class Network: Networking {

    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    static let `default` = {
        Network(session: URLSession.shared)
    }()

    func send(_ request: URLRequest, completion: @escaping (Result<Data, NetworkingError>) -> Void) {
        debugPrint(request.curlString)
        let task = session.dataTask(with: request) { data, response, error in
            switch (data, response, error) {
            case (_, _, .some(let error)):
                completion(.failure(.underlyingError(error)))
            case (.none, .some(let response), .none):
                if let httpResponse = response as? HTTPURLResponse {
                    completion(.failure(.abnormalResponse(httpResponse)))
                }
            case (.none, .none, .none):
                completion(.failure(.emptyResponse))
            case (.some(let data), _, _):
                completion(.success(data))
            }
        }
        task.resume()
    }
}

// https://gist.github.com/shaps80/ba6a1e2d477af0383e8f19b87f53661d
private extension URLRequest {

    /**
     Returns a cURL command representation of this URL request.
     */
    var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#

        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var command = [baseCommand]

        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }

        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
    }

}
