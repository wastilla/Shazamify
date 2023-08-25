//
//  AuthViewModel.swift
//  Shazamy
//
//  Created by will astilla on 8/18/23.
//

import Foundation

class AuthViewModel: ObservableObject {
    public let url = AuthManager.shared.getSignInURL()
    
    func printUrl(){
        print(url)
    }
    
//    func fetchCode(code: String) -> String{
//        return AuthManager.shared.exchangeCodeForToken(code: code)
//    }
}
