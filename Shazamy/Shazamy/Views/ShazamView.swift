//
//  ShazamView.swift
//  Shazamy
//
//  Created by will astilla on 11/10/22.
//

import Foundation
import SwiftUI


struct ShazamView: View{
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                Spacer()
                AsyncImage(url: viewModel.currentItem?.artworkURL) { image in
                    image.image?.resizable().scaledToFit()
                }
                    .frame(width: 200, height: 200, alignment: .center)

                Text(viewModel.currentItem?.title ?? "Press the Button below to Shazam")
                    .font(.title3.bold())
                    

                Text(viewModel.currentItem?.artist ?? "")
                    .font(.body)
                Spacer()
                Spacer()
                if viewModel.shazaming == true {
                    Button("Stop Shazaming") {
                        viewModel.stopRecognition()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                } else {
                    Button("Start Shazaming") {
                        viewModel.startRecognition()
                    }
                    .tint(Color("SpotifyGreen"))
                    .buttonStyle(.borderedProminent)
                    
                }
            }
            .padding()
            .navigationTitle("Shazam")
        }
    }
}


struct ShazamView_Previews: PreviewProvider {
    static var previews: some View {
        ShazamView()
            .preferredColorScheme(.dark)
       
    }
}

