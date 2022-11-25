

//
//  TestView.swift
//  SpotifyAPI_Testy
//
//  Created by will astilla on 11/18/22.
//
import Foundation
import SwiftUI

struct PlaylistView: View {
    // get shared data async from view model
    @ObservedObject var viewModel: AlbumListViewModel
    @ObservedObject var searchViewModel: SongSearchViewModel
    
    let query: String
    
    init(query: String) {
        self.query = query
        self.searchViewModel = SongSearchViewModel(query: query)
        self.viewModel = AlbumListViewModel()
    }
    
    var body: some View {
        NavigationStack {
            let song = searchViewModel.getSong()
            VStack {
                List(Array(song), id: \.self) { track in
                    // let artist = track.artists.name
                    if let name = track.name, let artist = track.artists?[0].name {
                        HStack {
                            Text(artist)
                            Text(name).font(.headline)
                        }
                    }
                }
                VStack {
                    let recs = viewModel.getSongList()
                    
                    List(Array(recs), id: \.self) { track in
                        // let artist = track.artists.name
                        if let name = track.name, let artist = track.artists?[0].name, let url = track.externalUrls?.spotify ?? "none" {
                            HStack {
                                Text(artist)
                                Text(name).font(.headline)
                                Text(url)
                            }
                        }
                    }
                    Button("Press") {
                        viewModel.makePlaylist(artistID: song.first?.artists?[0].id ?? "", songID: song.first?.id ?? "")
                    }
                
                    .onAppear {
                        // fire the data transactions
                        viewModel.getData()
                    }
                }
            }
            .onAppear {
                searchViewModel.getData()
                searchViewModel.makeSearch(query: self.query)
            }
           
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(query: "Autumn! Still the same")
    }
}
