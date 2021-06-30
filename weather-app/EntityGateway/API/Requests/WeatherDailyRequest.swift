//
//  WeatherDailyRequest.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import Foundation

struct WeatherDailyRequest: ApiRequest {
    let days: Int
    let cityName: String
    let unit: String
    
    var urlRequest: URLRequest {
        let queryCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url: URL! = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily?" +
                                "q=\(queryCityName)&" +
                                "cnt=\(days)&" +
                                "appid=60c6fbeb4b93ac653c492ba806fc346d&" +
                                "units=\(unit)")
            
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
