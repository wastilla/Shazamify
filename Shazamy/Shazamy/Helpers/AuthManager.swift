//
//  AuthManager.swift
//  SpotifyAPI_Testy
//
//  Created by will astilla on 11/18/22.
//

import Combine
import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private let authKey: String = {
        // replace this value with your keys
        // example auth key -> "1A2B3C4D5E:6F7G8H9I10J"
        let clientID = "806bb8fe25d34aa084a29444d21ae0ba"
        let clientSecret = "3c2693a110304029938dc77b67217115"
        let rawKey = "\(clientID):\(clientSecret)"
        let encodedKey = rawKey.data(using: .utf8)?.base64EncodedString() ?? ""
        return "Basic \(encodedKey)"
    }()
    
    
    // Authentication URL
    private let tokenURL: URL? = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "accounts.spotify.com"
        components.path = "/api/token"
        return components.url
    }()
       
    private init() {}
       
    /// Request method for access token.
    func getAccessToken() -> AnyPublisher<String, Error> {
        // strong token url
        guard let url = tokenURL else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        // url request setups
        var urlRequest = URLRequest(url: url)
        // add authKey to "Authorization" for request headers
        urlRequest.allHTTPHeaderFields = ["Authorization": authKey,
                                          "Content-Type": "application/x-www-form-urlencoded"]
        // add query items for request body
        var requestBody = URLComponents()
        requestBody.queryItems = [URLQueryItem(name: "grant_type", value: "client_credentials")]
        urlRequest.httpBody = requestBody.query?.data(using: .utf8)
        urlRequest.httpMethod = HTTPMethods.post.rawValue
        // return dataTaskPublisher for request
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                // throw error when bad server response is received
                guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            // decode the data with AccessToken decodable model
            .decode(type: AccessToken.self, decoder: JSONDecoder())
            // reinforce for decoded data
            .map { accessToken -> String in
                guard let token = accessToken.token else {
                    print("The access token is not fetched.")
                    return ""
                }
                return token
            }
            // main thread transactions
            .receive(on: RunLoop.main)
            // publisher spiral for AnyPublisher<String, Error>
            .eraseToAnyPublisher()
    }
}

