//
//  APIManager.swift
//  SpotifyAPI_Testy
//
//  Created by will astilla on 11/18/22.
//

import Foundation
import Combine

// singleton class with generic type (T is Decodable)
class APIManager<T: Decodable> {
    // request model for request
    struct RequestModel {
        let url: URL?
        let method: HTTPMethods
    }
    
    // shared instance
    static var shared: APIManager<T> {
        return APIManager<T>()
    }
    
    enum Response {
        case success
        case failure
    }
    
    private init() {}
    
    /// Request the API data with parameters.
    /// - Parameters:
    ///   - model: Data that can be helpful for the request model.
    func request(with model: RequestModel) -> AnyPublisher<T, Error> {
        // get access token value with tokenPublisher
        let tokenPublisher = AuthManager.shared.getAccessToken()
        return tokenPublisher
            .flatMap { tokenKey -> AnyPublisher<T, Error> in
                // flatMap completes the chain request task
                guard let url = model.url else {
                    return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
                }
                // request model setups
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = model.method.rawValue
                print(model.method)
                switch model.method {
                case .get:
                    // add 'Bearer ' to the token key for request headers
                    urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenKey)"]
                    break
                case .post:
                    urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenKey)"]
                    break
                default:
                    break
                }
                return URLSession.shared
                    .dataTaskPublisher(for: urlRequest)
                    .tryMap({ data, response in
                        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                            throw URLError(.badServerResponse)
                        }
                        return data
                    })
                    .decode(type: T.self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func requestWithCode(with model: RequestModel, code: String) -> AnyPublisher<T, Error> {
        // get access token value with tokenPublisher
        let tokenPublisher =
        AuthManager.shared.exchangeCodeForToken(code: code)
//
        return tokenPublisher
            .flatMap { tokenKey -> AnyPublisher<T, Error> in
                // flatMap completes the chain request task
                print("Token Key in API Manager: \(tokenKey)")
                guard let url = model.url else {
                    return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
                }
                // request model setups
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = model.method.rawValue
                print(model.method)
                switch model.method {
                case .get:
                    // add 'Bearer ' to the token key for request headers
                    urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenKey)"]
                    break
                case .post:
                    urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(tokenKey)"]
                    break
                default:
                    break
                }
                return URLSession.shared
                    .dataTaskPublisher(for: urlRequest)
                    .tryMap({ data, response in
                        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                            
                            throw URLError(.badServerResponse)
                        }
                        return data
                    })
                    .decode(type: T.self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func queueRequest(with model: RequestModel) -> AnyPublisher<T, Error> {
        guard let url = model.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        // request model setups
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = model.method.rawValue
        switch model.method{
        case .get:
            // add 'Bearer ' to the token key for request headers
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(AuthManager.shared.token)"]
            break
        case .post:
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(AuthManager.shared.token)"]
            break
        default:
            break
        }
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap({ data, response in
                print(data)
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    print(response)
                    throw URLError(.badServerResponse)
                }
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
