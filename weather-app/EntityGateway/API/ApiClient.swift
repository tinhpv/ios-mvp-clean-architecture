//
//  ApiClient.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import Foundation

typealias Result<T> = Swift.Result<T, Error>

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
                completion(.failure(NetworkRequestError(error: error)))
                return
            }
            
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                do {
                    let response = try ApiResponse<T>(data: data,
                                                      httpUrlResponse: httpUrlResponse)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(ApiError(data: data,
                                             httpUrlResponse: httpUrlResponse)))
            }
        }
        dataTask.resume()
    }
}
