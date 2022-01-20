//
//  MenuView.swift
//  day3
//
//  Created by AMPA on 16/01/22.
//

import Foundation
import SwiftUI

struct MenuView: View {
    
    @State var value = false
    
    @Binding var showMenu : Bool
    @Binding var selectedTab : String
    @EnvironmentObject var person_list : Person_Class
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Image(systemName: "house")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Home")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .onTapGesture {
                        debugPrint("home tapped")
                        
                        selectedTab="Home"
                        showMenu.toggle()
                    }
              }
            .padding(.top, 100)
        
            
            HStack {
                Image(systemName: "list.bullet.rectangle")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("List")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .onTapGesture {
                        debugPrint("List tapped")
                        
                        selectedTab="List"
                        showMenu.toggle()
                    }
            }
            .padding(.top, 30)
            
            
            HStack {
                Image(systemName: "pencil.circle")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Edit")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .onTapGesture {
                        debugPrint("Edit Tapped")
                        
                        selectedTab="Edit"
                        showMenu.toggle()
                    }
            }
            .padding(.top, 30)
            
            Spacer()
        }
        .padding()
         .frame(maxWidth: .infinity, alignment: .leading)
        .edgesIgnoringSafeArea(.all)
       }
    
}

struct MenuView_Previews: PreviewProvider {
    @State static var value = true
    @State static var tabvalue = "Home"
    static var previews: some View {
        MenuView(showMenu: $value, selectedTab: $tabvalue)
    }
}
