//
//  ShazamView.swift
//  Shazamy
//
//  Created by will astilla on 11/10/22.
//

import Foundation
import SwiftUI

struct ShazamView: View {
    @StateObject private var viewModel = ShazamViewModelTwo()
    @State private var change: Bool = false
    
   
 
    var body: some View {
     
        NavigationView {
            ZStack {
                AsyncImage(url: viewModel.shazamMedia.albumArtURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 10, opaque: true)
                        .opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                } placeholder: {
                    EmptyView()
                }
                VStack(alignment: .center) {
                    Spacer()
                    AsyncImage(url: viewModel.shazamMedia.albumArtURL) { image in
                        image
                            .resizable()
                            .frame(width: 300, height: 300)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.purple.opacity(0.5))
                            .frame(width: 300, height: 300)
                            .cornerRadius(10)
                            .redacted(reason: .privacy)
                    }
                    VStack(alignment: .center) {
                        Text(viewModel.shazamMedia.title ?? "Title")
                            .font(.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        Text(viewModel.shazamMedia.artistName ?? "Artist Name")
                            .font(.title2)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                    }.padding()
                    Spacer()
                    Button(action: { viewModel.startOrEndListening() }) {
                        Text(viewModel.isRecording ? "Listening..." : "Start Shazaming")
                            .frame(width: 300)
                    }.buttonStyle(.bordered)
                        .controlSize(.large)
                        .shadow(radius: 4)
                    if(viewModel.shazamMedia.title != "Title..." && !viewModel.isRecording){
                        let query = ((viewModel.shazamMedia.title ?? "") + " " + (viewModel.shazamMedia.artistName ?? "" ))
                        NavigationLink(destination: PlaylistView(query: query)) {
                            Text("Press")
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ShazamView_Previews: PreviewProvider {
    static var previews: some View {
        ShazamView()
            .preferredColorScheme(.dark)
    }
}
