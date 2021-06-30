//
//  ApiResponse.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import Foundation

struct ApiResponse<T: Decodable> {
    let entity: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.entity = try JSONDecoder().decode(T.self, from: data ?? Data())
            self.httpUrlResponse = httpUrlResponse
            self.data = data
        } catch {
            throw ApiError(error: error, data: data, httpUrlResponse: httpUrlResponse)
        }
    }
}
