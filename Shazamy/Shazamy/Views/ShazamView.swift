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
            ZStack {
                AsyncImage(url: viewModel.currentItem?.artworkURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 10, opaque: true)
                        .opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                } placeholder: {
                    Color.black
                        .ignoresSafeArea()
                }
                VStack(alignment: .center) {
                   
                    AsyncImage(url: viewModel.currentItem?.artworkURL) { image in
                        image
                            .resizable()
                            .frame(width: 300, height: 300)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("SpotifyGreen").opacity(1))
                            .frame(width: 300, height: 300)
                            .cornerRadius(10)
                            .redacted(reason: .privacy)
                    }
                    .padding(.top, 150)
                    VStack(alignment: .center) {
                        Text(viewModel.currentItem?.title ?? "Press the Button below to Shazam")
                            .font(.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        Text(viewModel.currentItem?.artist ?? "")
                            .font(.title2)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                    }.padding()
                     
                    Spacer()

                    if viewModel.shazaming == true {
                        Button {
                            viewModel.stopRecognition()
                        } label: {
                            Text("Stop Recognition")
                                .padding()
                                .bold()
                        }
                        .foregroundColor(.white)
                        .background(.red)
                        .cornerRadius(15)

                    } else {
                        HStack {
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
                            if viewModel.currentItem?.artist != nil, !viewModel.shazaming {
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
                            }
                        }
                        .toolbar {
                            ToolbarItem() {
                                Image("ShazamifyLogo")
                                    .resizable()
                                    .scaledToFill()
                                    .padding(.top, 80)
                            }
                            
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
