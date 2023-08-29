//
//  ContentView.swift
//  Shazamy
//
//  Created by will astilla on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HomeView()
                .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            
       
    }
}
