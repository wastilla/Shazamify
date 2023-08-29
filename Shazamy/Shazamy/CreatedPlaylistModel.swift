//
//  CreatedPlaylistModel.swift
//  Shazamy
//
//  Created by will astilla on 8/28/23.
//

import Foundation

// MARK: - CreatedPlaylist
struct CreatedPlaylistModel: Codable {
    let collaborative: Bool
    let description: String?
    let externalUrls: PlaylistExternalUrls
    let followers: Followers
    let href, id: String?
    let images: [PlaylistImage]
    let name: String
    let owner: Owner
    let createdPlaylistPublic: Bool
    let snapshotID: String
    let tracks: PlaylistTracks
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case collaborative, description
        case externalUrls = "external_urls"
        case followers, href, id, images, name, owner
        case createdPlaylistPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - ExternalUrls
struct PlaylistExternalUrls: Codable {
    let spotify: String
}

// MARK: - Followers
struct Followers: Codable {
    let href: String
    let total: Int
}

// MARK: - Image
struct PlaylistImage: Codable {
    let url: String
    let height, width: Int
}

// MARK: - Owner
struct Owner: Codable {
    let externalUrls: PlaylistExternalUrls
    let followers: Followers?
    let href, id, type, uri: String
    let displayName, name: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, href, id, type, uri
        case displayName = "display_name"
        case name
    }
}

// MARK: - Tracks
struct PlaylistTracks: Codable {
    let href: String
    let limit: Int
    let next: String
    let offset: Int
    let previous: String
    let total: Int
    let items: [PlaylistItem]
}

// MARK: - Item
struct PlaylistItem: Codable {
    let addedAt: String
    let addedBy: Owner
    let isLocal: Bool
    let track: PlaylistTrack

    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case addedBy = "added_by"
        case isLocal = "is_local"
        case track
    }
}

// MARK: - Track
struct PlaylistTrack: Codable {
    let album: PlaylistAlbum
    let artists: [PlaylistArtist]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalIDS: PlaylistExternalIDS
    let externalUrls: PlaylistExternalUrls
    let href, id: String
    let isPlayable: Bool
    let linkedFrom: PlaylistLinkedFrom
    let restrictions: PlaylistRestrictions
    let name: String
    let popularity: Int
    let previewURL: String
    let trackNumber: Int
    let type, uri: String
    let isLocal: Bool

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isPlayable = "is_playable"
        case linkedFrom = "linked_from"
        case restrictions, name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
        case isLocal = "is_local"
    }
}

// MARK: - Album
struct PlaylistAlbum: Codable {
    let albumType: String
    let totalTracks: Int
    let availableMarkets: [String]
    let externalUrls: PlaylistExternalUrls
    let href, id: String
    let images: [PlaylistImage]
    let name, releaseDate, releaseDatePrecision: String
    let restrictions: PlaylistRestrictions
    let type, uri: String
    let copyrights: [Copyright]
    let externalIDS: PlaylistExternalIDS
    let genres: [String]
    let label: String
    let popularity: Int
    let albumGroup: String
    let artists: [Owner]

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case restrictions, type, uri, copyrights
        case externalIDS = "external_ids"
        case genres, label, popularity
        case albumGroup = "album_group"
        case artists
    }
}

// MARK: - Copyright
struct Copyright: Codable {
    let text, type: String
}

// MARK: - ExternalIDS
struct PlaylistExternalIDS: Codable {
    let isrc, ean, upc: String
}

// MARK: - Restrictions
struct PlaylistRestrictions: Codable {
    let reason: String
}

// MARK: - Artist
struct PlaylistArtist: Codable {
    let externalUrls: PlaylistExternalUrls
    let followers: Followers
    let genres: [String]
    let href, id: String
    let images: [PlaylistImage]
    let name: String
    let popularity: Int
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}

// MARK: - LinkedFrom
struct PlaylistLinkedFrom: Codable {
}
