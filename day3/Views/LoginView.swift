//
//  LoginView.swift
//  day3
//
//  Created by AMPA on 27/01/22.
//

import SwiftUI

struct LoginView: View {

  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel

  var body: some View {
    VStack {
      Spacer()

      // 2

      Text("Welcome!")

      Spacer()
      Spacer()

      // 3
      GoogleSignInButton()
        .padding()
        .onTapGesture {
          viewModel.signIn()
        }
    }
  }
}
