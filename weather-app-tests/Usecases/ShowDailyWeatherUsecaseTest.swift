//
//  ShowDailyWeatherTest.swift
//  weather-app-tests
//
//  Created by tinhpv4 on 6/30/21.
//

import XCTest
@testable import weather_app

class ShowDailyWeatherUsecaseTest: XCTestCase {
    var showDailyWeatherUsecase: ShowDailyWeatherUseCaseImpl!
    
    // test double
    let weatherGatewaySpy = WeatherGatewaySpy()
    
    override func setUp() {
        super.setUp()
        showDailyWeatherUsecase = ShowDailyWeatherUseCaseImpl(weatherGateway: weatherGatewaySpy)
    }
    
    func test_fetchDailyWeather_Success() {
        // given
        let cityName = "New york"
        let unit = "metric"
        let days = 7
        let mockWeatherDailyData = Weather.generateMockDailyWeatherData(days: days, unit: unit, cityName: cityName)
        let expectedResult = Result.success(mockWeatherDailyData)
        weatherGatewaySpy.returnedDailyWeatherResult = expectedResult
        let fetchWeatherExpectation = expectation(description: "fetch daily weather expectation")
        
        // when
        showDailyWeatherUsecase.showDailyWeather(cityName: cityName, unit: unit, numberOfDays: days) { (result) in
            // then
            XCTAssertTrue(result == expectedResult, "NOT as Expected, Result not the same")
            fetchWeatherExpectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func test_fetchDailyWeather_Failure() {
        // given
        let cityName = "abcyxztest"
        let unit = "metric"
        let days = 7
        let expectedResult: Result<[Weather]> = Result.failure(ApiError.createApiError(message: "Error test"))
        
        weatherGatewaySpy.returnedDailyWeatherResult = expectedResult
        let fetchWeatherExpectation = expectation(description: "fetch daily weather expectation")
        
        // when
        showDailyWeatherUsecase.showDailyWeather(cityName: cityName, unit: unit, numberOfDays: days) { (result) in
            // then
            XCTAssertTrue(result == expectedResult, "NOT as Expected, Result not the same")
            fetchWeatherExpectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    
    
}
