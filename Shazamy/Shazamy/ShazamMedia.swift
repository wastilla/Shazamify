//
//  ShazamMedia.swift
//  Shazamy
//
//  Created by will astilla on 11/25/22.
//

import Foundation

struct ShazamMedia: Decodable{
    let title: String?
    let subtitle: String?
    let artistName: String?
    let albumArtURL: URL?
    let genres: [String]
}
