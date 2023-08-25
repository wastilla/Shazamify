//
//  DataProvider.swift
//  SpotifyAPI_Testy
//
//  Created by will astilla on 11/18/22.
//

import Combine
import Foundation


class DataProvider {
    static let shared = DataProvider()
    
    private var cancellables = Set<AnyCancellable>()
    
    
    // Subscribers
    var artistAlbumsSubject = PassthroughSubject<[Item], Never>()
    
    var songRecsSubject = PassthroughSubject<[Track], Never>()
    
    var songSearchSubject = PassthroughSubject<[Items], Never>()
    
    var addToQueueSubject =  PassthroughSubject<Bool, Never>()
    
    private init() {}
}

// MARK: - Artist Albums Data Transactions

extension DataProvider {
    func getArtistsAlbums(id: String) {
        // request url
        let url = URL(string: "https://api.spotify.com/v1/artists/\(id)/albums")
        // request model with decodable ArtistAlbums model and http method
        let model = APIManager<ArtistAlbums>.RequestModel(url: url, method: .get)
        // init request
        APIManager.shared.request(with: model)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { albums in
                // successful request
                guard let items = albums.items else { return }
                // publish the data
                self.artistAlbumsSubject.send(items)
            }).store(in: &self.cancellables)
    }
    
    func getSongRecommendations(artistID: String, songID: String) {
        // request url
        let url = URL(string: "https://api.spotify.com/v1/recommendations?seed_artists=\(artistID)&seed_tracks=\(songID)")
        
        // request model with decodable ArtistAlbums model and http method
        let model = APIManager<SongRecommendations>.RequestModel(url: url, method: .get)
        // init request
        APIManager.shared.request(with: model)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { songs in
                // successful request
                guard let items = songs.tracks else { return }
                // publish the data
                self.songRecsSubject.send(items)
            }).store(in: &self.cancellables)
    }
    
    func findSong(Query: String) {
        let newQuery = Query.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://api.spotify.com/v1/search?q=\(newQuery)&type=track&limit=1")
        
        let model = APIManager<SongSearch>.RequestModel(url: url, method: .get)
        
        APIManager.shared.request(with: model)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { results in
                // successful request
                guard let items = results.tracks?.items else { return }
                // publish the data
                self.songSearchSubject.send(items)
            }).store(in: &self.cancellables)
    }
    
    func addtoQueue(code: String) {
        //queue?uri=spotify:track:4iV5W9uYEdYUVa79Axb7Rh"
        let url = URL(string: "https://api.spotify.com/v1/me/player/queue?uri=spotify%3Atrack%3A4iV5W9uYEdYUVa79Axb7Rh")
        
        let model = APIManager<AddToQueueModel>.RequestModel(url: url, method: .post)
        
        APIManager.shared.requestWithCode(with: model, code: code )
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("HERERERLEJL")
                    print(error)
                }
            }, receiveValue: { results in
                // successful request
               // guard let items = results else { return }
                // publish the data
                print("DONE")
                self.addToQueueSubject.send(true)
            }).store(in: &self.cancellables)
    }
}
