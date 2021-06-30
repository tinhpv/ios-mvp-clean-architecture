//
//  Result.swift
//  weather-app-tests
//
//  Created by tinhpv4 on 6/30/21.
//

import Foundation
@testable import weather_app

public func ==<T>(lhs: Result<T>, rhs: Result<T>) -> Bool {
    return String(describing: lhs) == String(describing: rhs)
}
