//
//  AccessToken.swift
//  SpotifyAPI_Testy
//
//  Created by will astilla on 11/18/22.
//

import Foundation

struct AccessToken: Decodable {
    let token: String?
    let type: String?
    let expire: Int?
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case type = "token_type"
        case expire = "expires_in"
    }
}
