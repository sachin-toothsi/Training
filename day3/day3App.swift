//
//  day3App.swift
//  day3
//
//  Created by AMPA on 14/01/22.
//

import SwiftUI
import Firebase

@main
struct day3App: App {
    
    @StateObject var viewModel = AuthenticationViewModel()
    
    init() {
        setupAuthentication()
      }
    
    var body: some Scene {
        WindowGroup {
            DummyContentView()
                .environmentObject(viewModel)
        }
    }
}
extension day3App{
    
    private func setupAuthentication() {
       FirebaseApp.configure()
     }
}
