//
//  ShazamView.swift
//  Shazamy
//
//  Created by will astilla on 11/10/22.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = ShazamViewModel()
    
    @State private var change: Bool = false
    @State private var scale: Double = 0.5
    @State private var isAnimating: Bool = true
    
    var body: some View {
        NavigationStack {
                ZStack{
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
                        Spacer()
                        NavigationLink(destination: ShazamingView())
                            {
                                Text("Start Shazaming")
                                    .padding()
                                    .bold()
                                    .foregroundColor(.white)
                                    .background(Color("SpotifyGreen").opacity(1))
                                    .cornerRadius(15)
                                    .frame(alignment: .center)
                            }
                    }.padding(50)
                }.toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("SHAZAMIFY")
                            .font(
                                .system(size : 48)
                                .weight(.heavy))
                            .foregroundColor(.white)
                            .bold()}}
                .ignoresSafeArea()
        }.navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
