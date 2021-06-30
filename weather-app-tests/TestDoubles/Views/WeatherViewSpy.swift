//
//  WeatherViewSpy.swift
//  weather-app-tests
//
//  Created by tinhpv4 on 6/30/21.
//

import Foundation
@testable import weather_app

class WeatherViewSpy: WeatherView {
    var failureMsg: String?
    var didSuccessFetchWeatherCalled: Bool = false
    var didShowLoadingView: Bool = false
    var didHideLoadingView: Bool = false
    
    func onSuccessFetchWeather() {
        self.didSuccessFetchWeatherCalled = true
    }
    
    func onFailure(message: String) {
        self.failureMsg = message
    }
    
    func showLoadingView() {
        self.didShowLoadingView = true
    }
    
    func hideLoadingView() {
        self.didHideLoadingView = true
    }
}
