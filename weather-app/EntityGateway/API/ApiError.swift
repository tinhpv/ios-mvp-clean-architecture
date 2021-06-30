//
//  ApiError.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import Foundation

struct NetworkRequestError: Error {
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error - no other information"
    }
}

struct ApiError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

struct ApiParseError: Error {
    static let code = 999
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}
