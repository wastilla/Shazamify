//
//  SongView.swift
//  Shazamy
//
//  Created by Daniel F on 8/24/23.
//

import Foundation
import SwiftUI

import ShazamKit

struct SongView: View {
    @ObservedObject private var viewModel = ShazamViewModel()
    
    @State private var change: Bool = false
    @State private var scale: Double = 0.5
    @State private var isAnimating: Bool = true
    
    @Environment(\.dismiss) var dismiss
    
    let currentItem: SHMediaItem?
    
    init(currentItem: SHMediaItem){
        self.currentItem = currentItem
    }
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .center) {
                AsyncImage(url: currentItem?.artworkURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .blur(radius: 8, opaque: true)
                        .opacity(0.6)
                        .edgesIgnoringSafeArea(.all)
                        .clipped()
                } placeholder: {
                }
                VStack(alignment: .center) {
                    AsyncImage(url: currentItem?.artworkURL) { image in
                        image
                            .resizable()
                            .frame(width: 300, height: 300)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                    }
                    
                    Text(currentItem?.title ?? "")
                        .font(.title)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                    Text(currentItem?.artist ?? "")
                        .font(.title2)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                }
                VStack{
                    Spacer()
                    HStack(alignment: .center){
                        Button()
                        {
                            viewModel.resetSong()
                            dismiss()
                        } label: {
                            Text("Return Home")
                                .padding()
                                .bold()
                                .foregroundColor(.white)
                                .background(Color("SpotifyGreen").opacity(1))
                                .cornerRadius(15)
                                .frame(alignment: .center)
                        }
                        // .buttonStyle(.borderedProminent)
                        let query = ((currentItem?.title ?? "") + " " + (currentItem?.artist ?? ""))
                        NavigationLink(destination: PlaylistView(query: query)) {
                            Text("Shazamify")
                                .padding([.leading, .trailing], 22)
                                .bold()
                                .padding()
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                    }
                }.padding([.bottom], 50)
            }.toolbar {
                ToolbarItem(placement: .principal) {
                    Text("SHAZAMIFY")
                        .font(
                            .system(size : 48)
                            .weight(.heavy))
                        .foregroundColor(.white)
                        .bold()}}
            .ignoresSafeArea()
            .onAppear(){
                viewModel.stopRecognition()
            }
        }.navigationBarBackButtonHidden(true)
    }
}
