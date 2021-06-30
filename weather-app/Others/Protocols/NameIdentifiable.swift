//
//  NameIdentifiable.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import Foundation

protocol NameIdentifiable {
    static var identifier: String { get }
}

extension NameIdentifiable {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
