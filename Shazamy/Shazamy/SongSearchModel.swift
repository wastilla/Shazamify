//
//  SongSearchModel.swift
//  SpotifyAPI_Testy
//
//  Created by will astilla on 11/22/22.
//

import Foundation

struct SongSearch: Decodable, Hashable {
    let tracks: Tracks?
}

// MARK: - Tracks
struct Tracks: Decodable, Hashable {
    let href: String?
    let items: [Items]?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: JSONNull?
    let total: Int?
}

// MARK: - Items (name Item already defined)
struct Items: Decodable, Hashable {
    let album: Album?
    let artists: [Artist]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrls?
    let href: String?
    let id, name: String?
    let popularity: Int?
    let previewURL: String?
    let trackNumber: Int?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets
        case discNumber
        case durationMS
        case explicit
        case externalIDS
        case externalUrls
        case href, id, name, popularity
        case previewURL
        case trackNumber
        case type, uri
    }
}

// MARK: - Album
struct Album: Decodable, Hashable {
    let albumType: String?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [SongImage]?
    let name, type, uri: String?

    enum CodingKeys: String, CodingKey {
        case albumType
        case availableMarkets
        case externalUrls
        case href, id, images, name, type, uri
    }
}

// MARK: - ExternalUrls

// MARK: - Image
struct SongImage: Decodable, Hashable {
    let height: Int?
    let url: String?
    let width: Int?
}

// MARK: - Artist
struct Artist: Decodable, Hashable {
    let externalUrls: ExternalUrls?
    let href: String?
    let id, name, type, uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls
        case href, id, name, type, uri
    }
}

// MARK: - ExternalIDS
struct ExternalIDS: Decodable, Hashable {
    let isrc: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
