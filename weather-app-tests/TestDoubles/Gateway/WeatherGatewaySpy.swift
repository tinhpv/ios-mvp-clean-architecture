//
//  WeatherGatewaySpy.swift
//  weather-app-tests
//
//  Created by tinhpv4 on 6/30/21.
//

import Foundation
@testable import weather_app

class WeatherGatewaySpy: WeatherGateway {
    var returnedDailyWeatherResult: Result<[Weather]>!
    func fetchDailyWeather(cityName: String,
                           unit: String,
                           numberOfDays: Int,
                           completion: @escaping WeatherResponse) {
        completion(returnedDailyWeatherResult)
    }
}
