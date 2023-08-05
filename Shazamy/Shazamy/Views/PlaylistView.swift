

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
    @ObservedObject var viewModel: PlaylistViewModel
    @ObservedObject var searchViewModel: SongSearchViewModel
  
    @State var scale = 0.5
    
    let query: String
    
    init(query: String) {
        self.query = query
        self.searchViewModel = SongSearchViewModel(query: query)
        self.viewModel = PlaylistViewModel()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                let song = self.searchViewModel.songs
                VStack {
                    ForEach(Array(song), id: \.self) { track in
                        Text(track.name ?? "")
                            .bold()
                            .font(.system(.title2, design: .rounded))
                        Text(track.artists?[0].name ?? "")
                            .font(.system(.subheadline, design: .rounded))
                    }
                    .foregroundColor(.white)
                   
                    let recs = viewModel.songRecs
                    let baseAnimation = Animation.easeInOut(duration: 1)
                    ScrollView {
                        ForEach(Array(recs), id: \.self) { track in
                            if let name = track.name, let artist = track.artists?[0].name, let url = track.id {
                                PlaylistItemView(songTitle: name, artistName: artist, songURL: "https://open.spotify.com/track/" + url)
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

                }
         
            }
            .navigationBarHidden(true)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(query: "Autumn! Still the same")
    }
}
