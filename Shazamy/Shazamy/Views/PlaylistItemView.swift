//
//  SongItemView.swift
//  Shazamy
//
//  Created by will astilla on 11/25/22.
//

import Foundation
import SwiftUI

struct PlaylistItemView: View {
    let songTitle: String
    let artistName: String
    let songURL: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(songTitle)
                    .bold()
                    .font(.title3)
                    .foregroundColor(.white)
                Text(artistName)
                    .foregroundColor(.gray)
                
            }
            Spacer()
            Link(destination: URL(string: songURL)!) {
                Image(systemName: "play.fill")
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color("SpotifyGreen"))
                    .clipShape(Circle())
                
                    
            }
        }

        .frame(width: 300)
        .padding()
        .background(Color(UIColor.systemGray4).opacity(0.3))
        .cornerRadius(15)
    }
}

struct PlaylistItemView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistItemView(songTitle: "Danielle (smile on my face)", artistName: "Fred again..", songURL: "http://open.spotify.com/track/6rqhFgbbKwnb9MLmUQDhG6")
            .preferredColorScheme(.dark)
    }
}
