//
//  App.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Foundation
import UIKit.UIDevice

enum Environment {
    case develop
    case staging
    case production
}

enum App {

    static let enivornment: Environment = {
        #if DEBUG
        return .develop
        #elseif STAGING
        return .staging
        #elseif RELEASE
        return .production
        #endif
    }()

    enum Server {

        static let scheme = "https"

        static let hostname: String = {
            switch App.enivornment {
            case .develop:
                return "jsonplaceholder.typicode.com"
            case .staging:
                return "jsonplaceholder.typicode.com"
            case .production:
                return "api.example.com"
            }
        }()

        static let apiKey = "YOUR_API_KEY"

        static var baseURL: URL {
            var urlComponents = URLComponents()
            urlComponents.scheme = Server.scheme
            urlComponents.host = Server.hostname
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: Server.apiKey)
            ]
            guard let url = urlComponents.url else {
                fatalError("Invalid API URL...")
            }
            return url
        }

        static var metaHeaders: [String: String] {
            var appendString = "ios;"
            let environment: String = "\(App.enivornment)"
            appendString.append("\(environment);")
            appendString.append("\(Bundle.main.releaseVersionNumber ?? "");")
            appendString.append("\(UIDevice.current.systemVersion);")
            appendString.append("\(UIDevice.current.modelName)")
            return ["N-Meta": appendString]
        }
    }
}
