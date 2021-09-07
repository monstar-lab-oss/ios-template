//
//  HTTPMethod.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//
import Foundation

/**
 A helper struct used for modelling HTTPMethods. The concept is stolen from
 https://davedelong.com/blog/2020/06/27/http-in-swift-part-1/
 and the reason we're not limiting the options with an `enum` is that, as the article above says:
 > In reality, the HTTP spec itself does not place a limit on the value of the request method,
  which allows for specs like WebDAV (which powers CalDAV and CardDAV)
  to add their own methods like COPY, LOCK, PROPFIND, and so on.
 So, we define a list of commonly used values (get, post and so on) but allows extension
 */

public struct HTTPMethod: Hashable {
    public static let get = HTTPMethod(rawValue: "GET")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let put = HTTPMethod(rawValue: "PUT")
    public static let patch = HTTPMethod(rawValue: "PATCH")
    public static let delete = HTTPMethod(rawValue: "DELETE")

    public let rawValue: String
}
