//
//  SongRecommendations.swift
//  SpotifyAPI_Testy
//
//  Created by will astilla on 11/18/22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let songRecommendations = try? newJSONDecoder().decode(SongRecommendations.self, from: jsonData)


// MARK: - SongRecommendations
struct SongRecommendations: Decodable, Hashable {
    let seeds: [Seed]?
    let tracks: [Track]?
}

// MARK: - Seed
struct Seed: Decodable, Hashable, Identifiable {
    let id: String?
    let afterFilteringSize, afterRelinkingSize: Int?
    let href: String?
    let initialPoolSize: Int?
    let type: String?
}

// MARK: - Track
struct Track: Decodable, Hashable, Identifiable {
    let id: String?
    let artists: [LinkedFrom]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalUrls: ExternalUrls?
    let href: String?
    let isPlayable: Bool?
    let linkedFrom: LinkedFrom?
    let restrictions: Restrictions?
    let name, previewURL: String?
    let trackNumber: Int?
    let type, uri: String?
    let isLocal: Bool?

    enum CodingKeys: String, CodingKey {
        case artists
        case availableMarkets
        case discNumber
        case durationMS
        case explicit
        case externalUrls
        case href, id
        case isPlayable
        case linkedFrom
        case restrictions, name
        case previewURL
        case trackNumber
        case type, uri
        case isLocal
    }
}

// MARK: - LinkedFrom
struct LinkedFrom: Decodable, Hashable {
    let externalUrls: ExternalUrls?
    let href, id, name, type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls
        case href, id, name, type, uri
    }
}

// MARK: - ExternalUrls
/*struct ExternalUrls: Codable {
    let spotify: String?
}*/

// MARK: - Restrictions
struct Restrictions: Decodable, Hashable {
    let reason: String?
}
