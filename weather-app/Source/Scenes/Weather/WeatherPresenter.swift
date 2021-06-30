//
//  WeatherPresenter.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import Foundation

protocol WeatherView: class {
    func onSuccessFetchWeather()
    func onFailure(message: String)
    func showLoadingView()
    func hideLoadingView()
}

protocol WeatherPresenter {
    var numberOfDays: Int { get }
    func fetchDailyWeather(for cityName: String, within days: Int, unit: String)
    func weather(on day: Int) -> Weather
}

class WeatherPresenterImpl: WeatherPresenter {
    private weak var view: WeatherView?
    private let showDailyWeatherUseCase: ShowDailyWeatherUseCase
    
    var dailyWeather: [Weather] = []
    var numberOfDays: Int {
        return dailyWeather.count
    }
    
    init(view: WeatherView,
         showDailyWeatherUseCase: ShowDailyWeatherUseCase) {
        self.view = view
        self.showDailyWeatherUseCase = showDailyWeatherUseCase
    }
    
    func fetchDailyWeather(for cityName: String, within days: Int = 7, unit: String = "metric") {
        guard !cityName.isEmpty, cityName.count > 3 else {
            self.view?.onFailure(message: .invalidLengthError)
            return
        }
        
        view?.showLoadingView()
        self.showDailyWeatherUseCase.showDailyWeather(cityName: cityName, unit: unit, numberOfDays: days) { [weak self] (result) in
            self?.view?.hideLoadingView()
            switch result {
            case let .failure(error):
                self?.view?.onFailure(message: error.localizedMessage)
            case let .success(dailyWeather):
                self?.dailyWeather = dailyWeather
                self?.view?.onSuccessFetchWeather()
            }
        }
    }
    
    func weather(on day: Int) -> Weather {
        return self.dailyWeather[day]
    }
}
