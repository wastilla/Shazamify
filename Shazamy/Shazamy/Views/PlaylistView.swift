

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
  
    @State var scale = 0.5
    
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
                ForEach(Array(song), id: \.self) { track in
                    Text(track.artists?[0].name ?? "")
                    Text(track.name ?? "")
                }
               
                let recs = viewModel.getSongList()
                let baseAnimation = Animation.easeInOut(duration: 1)
                ScrollView {
                    ForEach(Array(recs), id: \.self) { track in
                        if let name = track.name, let artist = track.artists?[0].name {
                            PlaylistItemView(songTitle: name, artistName: artist)
                                .scaleEffect(scale)
                                .onAppear {
                                    withAnimation(baseAnimation) {
                                        scale = 1.0
                                    }
                                }
                        }
                    }
                }
                
                Button("Generate Playlist") {
                    viewModel.makePlaylist(artistID: song.first?.artists?[0].id ?? "", songID: song.first?.id ?? "")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color("SpotifyGreen").opacity(0.9))
                .bold()
                .cornerRadius(15)
                
                .onAppear {
                    // fire the data transactions
                    viewModel.getData()
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
