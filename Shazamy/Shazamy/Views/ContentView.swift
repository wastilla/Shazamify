//
//  ContentView.swift
//  Shazamy
//
//  Created by will astilla on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("userCode") var code: String = ""
    
    var body: some View {
        VStack {
            if(code == ""){
                WelcomeView()
                    .ignoresSafeArea()
            } else {
                ShazamView()
            }
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            
       
    }
}
