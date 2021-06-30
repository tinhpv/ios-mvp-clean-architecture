//
//  WeatherPresenterTest.swift
//  weather-app-tests
//
//  Created by tinhpv4 on 6/30/21.
//

import XCTest
@testable import weather_app

class WeatherPresenterTest: XCTestCase {
    var weatherPresenter: WeatherPresenterImpl!
    
    // testing double
    let weatherViewSpy = WeatherViewSpy()
    let showDailyWeatherUseCaseStub = ShowDailyWeatherUseCaseStub()
    
    override func setUp() {
        super.setUp()
        weatherPresenter = WeatherPresenterImpl(view: weatherViewSpy,
                                                showDailyWeatherUseCase: showDailyWeatherUseCaseStub)
    }
    
    func test_FetchSuccess_onSuccessFetchWeather_Called() {
        // Given
        let cityName = "New york"
        let withindays = 7
        let unit = "metric"
        let returnedDailyWeather = Weather.generateMockDailyWeatherData(days: withindays, unit: unit, cityName: cityName)
        showDailyWeatherUseCaseStub.result = .success(returnedDailyWeather)
        
        // When
        weatherPresenter.fetchDailyWeather(for: cityName, within: withindays, unit: unit)
        
        // Then
        XCTAssertTrue(weatherViewSpy.didSuccessFetchWeatherCalled, "onSuccessFetchWeather() not called!")
    }
    
    func test_FetchSuccess_numberOfDays() {
        // Given
        let expectedDays = 7
        let returnedDailyWeather = Weather.generateMockDailyWeatherData(days: expectedDays, unit: "metric", cityName: "New york")
        showDailyWeatherUseCaseStub.result = .success(returnedDailyWeather)
        
        // When
        weatherPresenter.fetchDailyWeather(for: "New york", within: expectedDays)
        
        // Then
        XCTAssertEqual(expectedDays, weatherPresenter.numberOfDays, "Number of days NOT equal")
    }
    
    func test_FetchSuccess_getWeather_forOneDay() {
        // Given
        let expectedDayToGetWeather = 3
        let returnedDailyWeather = Weather.generateMockDailyWeatherData(days: 7, unit: "metric", cityName: "New york")
        showDailyWeatherUseCaseStub.result = .success(returnedDailyWeather)
        
        // When
        weatherPresenter.fetchDailyWeather(for: "New york", within: 7, unit: "metrics")
        
        // Then
        XCTAssertEqual(returnedDailyWeather[expectedDayToGetWeather], weatherPresenter.weather(on: expectedDayToGetWeather), "Weather return NOT match")
    }
    
    
    func test_FetchFailure_searchTextLength_lessThan3() {
        // Given
        let expectedMessage = "City's name must be at greater than 3 characters"
        let lessThan3CharactersCityName = "AB"
        
        // When
        weatherPresenter.fetchDailyWeather(for: lessThan3CharactersCityName, within: 7, unit: "metric")
        
        // Then
        XCTAssertEqual(expectedMessage, weatherViewSpy.failureMsg ?? "", "Length Error message NOT matched!")
    }
    
    func test_FetchFailure_onFailure_triggeredWithMsg() {
        // Given
        let expectedMessage = "Test error message"
        let expectedError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: expectedMessage])
        showDailyWeatherUseCaseStub.result = .failure(expectedError)
        
        // When
        weatherPresenter.fetchDailyWeather(for: "New york", within: 7, unit: "")
        
        // Then
        XCTAssertEqual(expectedMessage, weatherViewSpy.failureMsg ?? "", "Error message NOT matched!")
    }
}
