//
//  ArtistAlbums.swift
//  SpotifyAPI_Testy
//
//  Created by will astilla on 11/18/22.
//

import Foundation

struct ArtistAlbums: Decodable, Hashable {
    let items: [Item]?
}

struct Item: Decodable, Identifiable, Hashable {
    let id = UUID()
    let albumType: String?
    let name: String?
    let releaseDate: String?
    let artists: [ArtistTwo]?
    let images: [AlbumImage]?
    let externalUrls: ExternalUrls?
    let totalTracks: Int?

    enum CodingKeys: String, CodingKey {
        case artists, images, name
        case albumType = "album_type"
        case releaseDate = "release_date"
        case externalUrls = "external_urls"
        case totalTracks = "total_tracks"
    }
}

struct ExternalUrls: Decodable, Hashable {
    let spotify: String?
    
    enum CodingKeys: String, CodingKey {
        case spotify
    }
}

struct ArtistTwo: Decodable, Hashable {
    let name, type: String?

    enum CodingKeys: String, CodingKey {
        case name, type
    }
}

struct AlbumImage: Decodable, Hashable {
    let height: Int?
    let url: String?
    let width: Int?
}
