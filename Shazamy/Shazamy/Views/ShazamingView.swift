//
//  ShazamingView.swift
//  Shazamy
//
//  Created by Daniel F on 8/24/23.
//

import Foundation
import SwiftUI

struct ShazamingView: View {
    @StateObject private var viewModel = ShazamViewModel()
    
    @State private var change: Bool = false
    @State private var scale: Double = 0.5
    @State private var isAnimating: Bool = true
    
    @Environment(\.dismiss) var dismiss
    
    @ViewBuilder
    var body: some View {
        NavigationStack {
            if !viewModel.found{
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
                        Spacer()
                        Button()
                        {
                            dismiss()
                            viewModel.stopRecognition()
                        } label: {
                            Text("Stop Shazaming")
                                .padding()
                                .bold()
                                .foregroundColor(.white)
                                .background(.red.opacity(1))
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
                .onAppear(){
                    viewModel.startRecognition()
                }
            }
            else if viewModel.found {
                SongView(currentItem: viewModel.currentItem!)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

//struct ShazamingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShazamingView(isShowing: false)
//            .preferredColorScheme(.dark)
//    }
//}
