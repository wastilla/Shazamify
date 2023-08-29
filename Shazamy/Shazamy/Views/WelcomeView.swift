//
//  WelcomeView.swift
//  Shazamy
//
//  Created by will astilla on 8/14/23.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    @State private var showLoginWebView: Bool = false
    @ObservedObject private var authViewModel: AuthViewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            Button {
                showLoginWebView.toggle()
            } label: {
                Text("Login")
            }
            Button{
                authViewModel.printUrl()
            } label: {
                Text("Print URL")
            }
            .sheet(isPresented: $showLoginWebView) {
                AuthWebView(url: authViewModel.url)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .preferredColorScheme(.dark)


    }
}
