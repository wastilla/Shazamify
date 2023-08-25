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
    
    public let signInURL: URL? = {
        let clientID = "806bb8fe25d34aa084a29444d21ae0ba"
        let clientSecret = "3c2693a110304029938dc77b67217115"
        let scopes = "user-read-private"
        let redirectURI = "https://www.google.com/"
        let baseURL = "https://accounts.spotify.com/authorize/"
        let fullURL = "\(baseURL)?response_type=code&client_id=\(clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)"
        return URL(string: fullURL)
        
    }()
       
    private init() {}
    
    func getSignInURL() -> URL{
        return signInURL!
    }
       
    /// Request method for access token for client credentials.
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
    
    func exchangeCodeForToken(code: String) -> AnyPublisher<String, Error>{
        guard let url = tokenURL else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        // url request setups
        var urlRequest = URLRequest(url: url)
        
        urlRequest.allHTTPHeaderFields = [
            "Authorization": authKey,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        // add query items for request body
        var requestBody = URLComponents()
        requestBody.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://www.google.com/")
        ]
        
        urlRequest.httpBody = requestBody.query?.data(using: .utf8)
        urlRequest.httpMethod = HTTPMethods.post.rawValue
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                // throw error when bad server response is received
                print(data)
                print(response)
                guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            // decode the data with AccessToken decodable model
            .decode(type: AuthResponse.self, decoder: JSONDecoder())
            // reinforce for decoded data
            .map { accessToken -> String in
                print("Auth Manager AccessToken: \(accessToken)")
                guard let token = accessToken.access_token else {
                    print("The access token is not fetched.")
                    return ""
                }

                guard let refreshToken = accessToken.refresh_token else {
                    print("The refresh token is not fetched.")
                    return ""
                }
//                print("T: \(refreshToken)")
                return token
            }
            // main thread transactions
            .receive(on: RunLoop.main)
            // publisher spiral for AnyPublisher<String, Error>
            .eraseToAnyPublisher()
    }
}

