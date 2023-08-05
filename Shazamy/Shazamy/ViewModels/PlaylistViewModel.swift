//
//  ViewModel.swift
//  SpotifyAPI_Testy
//
//  Created by will astilla on 11/18/22.
//

import Foundation
import Combine

class PlaylistViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    // async publishable data.
    @Published var albumList: Array<Item> = []
    @Published var albumImageUrls: Array<URL> = []
    
    @Published var songRecs: Array<Track> = []
    
    init() {
        // set artist id for request
        //artistID: 3qiHUAX7zY4Qnjx8TNUzVx
        //songID: 7BbaIYAdi3pg4MGl6PHwPv
        //seed genres:
        self.getData()
       
    }
    
    func getData() {
        // subscribe
        DataProvider.shared.songRecsSubject
            .sink(receiveValue: { [weak self] items in
                guard let self = self else { return }
                // set data to albumList object
                self.songRecs = items
                //self.setAlbumImageUrls(with: items)
            }).store(in: &cancellables)
    }
    
    func makePlaylist(artistID: String, songID: String){
        DataProvider.shared.getSongRecommendations(artistID: artistID, songID: songID )
    }
    
    // return albumList to view
    func getAlbumList() -> Array<Item> {
        return albumList
    }
    
    func getSongList() -> Array<Track>{
        return songRecs
    }
    
    // some collection type transactions
    private func setAlbumImageUrls(with albums: [Item]) {
        for album in albums {
            if let firstImageUrl = album.images?.first?.url,
               let imageUrl = URL(string: firstImageUrl) {
                albumImageUrls.append(imageUrl)
            }
        }
    }
    
    // return albumImageList to view
    func getAlbumImageUrls() -> Array<URL> {
        return albumImageUrls
    }
}

