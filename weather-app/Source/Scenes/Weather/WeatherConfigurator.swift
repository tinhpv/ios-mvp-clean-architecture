//
//  WeatherConfigurator.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import Foundation

protocol WeatherConfigurator {
    func configure(weatherController: WeatherController)
}

class WeatherConfiguratorImpl: WeatherConfigurator {
    func configure(weatherController: WeatherController) {
        let apiClient = ApiClientImpl(urlSessionConfiguration: .default, completionHandlerQueue: .main)
        let apiWeatherGateway = ApiWeatherGateway(apiClient: apiClient)
        let showDailyWeatherUsecase = ShowDailyWeatherUseCaseImpl(weatherGateway: apiWeatherGateway)
        let presenter = WeatherPresenterImpl(view: weatherController,
                                             showDailyWeatherUseCase: showDailyWeatherUsecase)
        weatherController.presenter = presenter
    }
}
