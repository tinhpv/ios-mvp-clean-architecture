//
//  ShowDailyWeatherStub.swift
//  weather-app-tests
//
//  Created by tinhpv4 on 6/30/21.
//

import Foundation
@testable import weather_app

class ShowDailyWeatherUseCaseStub: ShowDailyWeatherUseCase {
    var result: Result<[Weather]>!
    func showDailyWeather(cityName: String,
                          unit: String,
                          numberOfDays: Int,
                          completion: @escaping ShowDailyWeatherCompletion) {
        completion(result)
    }
    
    
}
