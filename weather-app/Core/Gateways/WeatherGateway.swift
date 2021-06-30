//
//  WeatherGateway.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import Foundation

typealias WeatherResponse = (_ weatherDays: Result<[Weather]>) -> Void

protocol WeatherGateway {
    func fetchDailyWeather(cityName: String, unit: String, numberOfDays: Int, completion: @escaping WeatherResponse)
}
