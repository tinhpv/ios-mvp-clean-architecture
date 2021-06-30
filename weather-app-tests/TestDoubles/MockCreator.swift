//
//  MockCreator.swift
//  weather-app-tests
//
//  Created by tinhpv4 on 6/30/21.
//

import Foundation
@testable import weather_app

extension Weather {
    static func generateMockDailyWeatherData(days: Int,
                                             unit: String,
                                             cityName: String) -> [Weather] {
        var dailyWeather: [Weather] = []
        for i in 0..<days {
            let weather: Weather = .init(date: Int.random(in: 1580578..<1680578),
                                         avgTemparature: Int.random(in: 20..<40),
                                         pressure: Int.random(in: 800..<1200),
                                         humidity: Int.random(in: 50..<100),
                                         description: "description. \(i)",
                                         iconUrl: URL(string: "icon \(i)"))
            dailyWeather.append(weather)
        }
        return dailyWeather
    }
}

extension Weather: Equatable {
    public static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.date == rhs.date
    }
}

extension NSError {
    static func createError(withMessage message: String) -> NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}

extension ApiError {
    static func createApiError(message: String) -> ApiError {
        return ApiError(error: NSError.createError(withMessage: message),
                        data: nil,
                        httpUrlResponse: nil)
    }
}
