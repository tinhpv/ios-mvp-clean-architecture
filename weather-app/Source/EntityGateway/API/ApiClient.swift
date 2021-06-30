//
//  ApiClient.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import Foundation

typealias Result<T> = Swift.Result<T, ApiError>

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol ApiRequest {
    var urlRequest: URLRequest { get }
}

protocol ApiClient {
    func execute<T>(request: ApiRequest,
                    completion: @escaping (_ result: Result<ApiResponse<T>>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class ApiClientImpl: ApiClient {
    
    let urlSession: URLSessionProtocol
    
    init(urlSessionConfiguration: URLSessionConfiguration,
         completionHandlerQueue: OperationQueue) {
        urlSession = URLSession(configuration: urlSessionConfiguration,
                                delegate: nil,
                                delegateQueue: completionHandlerQueue)
    }
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func execute<T>(request: ApiRequest,
                    completion: @escaping (Result<ApiResponse<T>>) -> Void) where T : Decodable {
        let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completion(.failure(ApiError(error: error, data: nil, httpUrlResponse: nil)))
                return
            }
           
            switch httpUrlResponse.statusCode {
            case 200..<300:
                do {
                    let response = try ApiResponse<T>(data: data,
                                                      httpUrlResponse: httpUrlResponse)
                    completion(.success(response))
                } catch {
                    completion(.failure(ApiError(error: error,
                                                 data: nil,
                                                 httpUrlResponse: httpUrlResponse)))
                }
            default:
                completion(.failure(ApiError(error: error,
                                             data: data,
                                             httpUrlResponse: httpUrlResponse)))
            }
        }
        dataTask.resume()
    }
}
