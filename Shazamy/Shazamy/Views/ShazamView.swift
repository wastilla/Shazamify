//
//  ShazamView.swift
//  Shazamy
//
//  Created by will astilla on 11/10/22.
//

import Foundation
import SwiftUI

struct ShazamView: View {
    @StateObject private var viewModel = ViewModel()
    
    @State private var change: Bool = false
    @State private var scale: Double = 0.5
    @State private var isAnimating: Bool = true
    
    var body: some View {
        NavigationView {
            if viewModel.shazaming == false && viewModel.currentItem?.artist == nil {
                
                ZStack () {
                        ZStack (alignment: .center) {
                            Image("dancing")
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                                .grayscale(0.99)
                                .edgesIgnoringSafeArea(.all)
                                .clipped()
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(LinearGradient(gradient: Gradient(colors: [Color("SpotifyGreen"), .black]), startPoint: .top, endPoint: .bottom)
                                    .opacity(0.5))
                        }
                    VStack (alignment: .center){
                        Button {
                            viewModel.startRecognition()
                        } label: {
                            Text("Start Shazaming")
                                .padding()
                                .bold()
                        }
                        .foregroundColor(.white)
                        .background(Color("SpotifyGreen").opacity(1))
                        .cornerRadius(15)
                        .frame(alignment: .center)
                    }.padding(.top, 600)
                }.toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("SHAZAMIFY")
                            .font(
                                .system(size : 54)
                                .weight(.heavy))
                            .foregroundColor(.white)
                            .bold()
                        .padding(.top, 60)}}
                .ignoresSafeArea()
            }
            else if viewModel.shazaming == true && viewModel.currentItem?.artist == nil {
                ZStack (alignment: .center) {
                        ZStack (alignment: .center) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(LinearGradient(gradient: Gradient(colors: [Color("SpotifyGreen"), .black]), startPoint: .top, endPoint: .bottom)
                                    .opacity(0.5))
                            Image(systemName: "waveform.circle.fill").font(.system(size : 256)).symbolRenderingMode(.hierarchical)
                                .foregroundStyle(Color.green)
                        }
                    VStack (alignment: .center){
                        Button {
                            viewModel.stopRecognition()
                        } label: {
                            Text("Stop Recognition")
                                .padding()
                                .bold()
                        }
                        .foregroundColor(.white)
                        .background(.red)
                        .opacity(1)
                        .cornerRadius(15)
                    }.padding(.top, 600)
                }.toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("SHAZAMIFY")
                            .font(
                                .system(size : 54)
                                .weight(.heavy))
                            .foregroundColor(.white)
                            .bold()
                        .padding(.top, 60)}}
                .ignoresSafeArea()
                
            }
            
            else {
                ZStack (alignment: .center) {
                    AsyncImage(url: viewModel.currentItem?.artworkURL) { image in
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
                        AsyncImage(url: viewModel.currentItem?.artworkURL) { image in
                            image
                                .resizable()
                                .frame(width: 300, height: 300)
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                        } placeholder: {
                        }
                        .padding(.top, 200)
                        VStack(alignment: .center) {
                            Text(viewModel.currentItem?.artist ?? "")
                                .font(.title2)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                        }.padding(.top, 500)
                    }
                    
                    HStack(alignment: .center){
                        Button {
                            viewModel.startRecognition()
                        } label: {
                            Text("Start Shazaming")
                                .foregroundColor(.white)
                                .padding()
                                .bold()
                        }
                        .background(Color("SpotifyGreen").opacity(1))
                        .cornerRadius(15)
                        // .buttonStyle(.borderedProminent)
                        let query = ((viewModel.currentItem?.title ?? "") + " " + (viewModel.currentItem?.artist ?? ""))
                        NavigationLink(destination: PlaylistView(query: query)) {
                            Text("Shazamify")
                                .padding([.leading, .trailing], 22)
                                .bold()
                                .padding()
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                    }.padding(.top, 600)
                }.toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("SHAZAMIFY")
                            .font(
                                .system(size : 54)
                                .weight(.heavy))
                            .foregroundColor(.white)
                            .bold()
                        .padding(.top, 60)}}
                .ignoresSafeArea()
            }
        }
    }
}

struct ShazamView_Previews: PreviewProvider {
    static var previews: some View {
        ShazamView()
            .preferredColorScheme(.dark)
    }
}
