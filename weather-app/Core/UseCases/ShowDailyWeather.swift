//
//  ShowDailyWeather.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import Foundation

typealias ShowDailyWeatherCompletion = (_ dailyWeather: Result<[Weather]>) -> Void

protocol ShowDailyWeatherUseCase {
    func showDailyWeather(cityName: String,
                          unit: String,
                          numberOfDays: Int,
                          completion: @escaping ShowDailyWeatherCompletion)
}

class ShowDailyWeatherUseCaseImpl: ShowDailyWeatherUseCase {
    let weatherGateway: WeatherGateway
    
    init(weatherGateway: WeatherGateway) {
        self.weatherGateway = weatherGateway
    }
    
    func showDailyWeather(cityName: String,
                          unit: String = "metric",
                          numberOfDays: Int = 7,
                          completion: @escaping ShowDailyWeatherCompletion) {
        self.weatherGateway.fetchDailyWeather(cityName: cityName,
                                              unit: unit,
                                              numberOfDays: numberOfDays) { (result) in
            completion(result)
        }
    }
}
