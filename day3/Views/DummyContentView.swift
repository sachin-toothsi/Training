//
//  DummyContentView.swift
//  day3
//
//  Created by AMPA on 27/01/22.
//

import SwiftUI

struct DummyContentView: View {
    
      @EnvironmentObject var viewModel: AuthenticationViewModel
      
      var body: some View {
        switch viewModel.state {
          case .signedIn: ContentView()
          case .signedOut: LoginView()
        }
      }
    }

struct DummyContentView_Previews: PreviewProvider {
    static var previews: some View {
        DummyContentView()
    }
}
