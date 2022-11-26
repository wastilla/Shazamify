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
    var body: some View {
        VStack(alignment: .center) {
            Text(songTitle)
                .bold()
                .font(.title2)
            Text(artistName)
        }
        
        .frame(width: 300)
        .padding()
        .background(Color(UIColor.systemGray4).opacity(0.5))
        .cornerRadius(15)
       
    }
}

struct PlaylistItemView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistItemView(songTitle: "Danielle (smile on my face)", artistName: "Fred again..")
            .preferredColorScheme(.dark)
    }
}
