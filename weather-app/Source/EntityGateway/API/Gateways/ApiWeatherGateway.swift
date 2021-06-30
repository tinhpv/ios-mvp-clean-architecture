//
//  ApiWeatherGateway.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import Foundation

class ApiWeatherGateway: WeatherGateway {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchDailyWeather(cityName: String,
                           unit: String,
                           numberOfDays: Int,
                           completion: @escaping (Result<[Weather]>) -> Void) {
        let weatherApiRequest = WeatherDailyRequest(days: numberOfDays,
                                                    cityName: cityName,
                                                    unit: unit)
        apiClient.execute(request: weatherApiRequest) { (result: Result<ApiResponse<ApiDailyWeather>>) in
            switch result {
            case let .success(response):
                let dailyWeather = response.entity.list.map { $0.weather }
                completion(.success(dailyWeather))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
