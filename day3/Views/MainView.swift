//
//  MainView.swift
//  day3
//
//  Created by AMPA on 16/01/22.
//

import Foundation
import SwiftUI


struct MainView : View {
   
    @Binding var showMenu : Bool
    @Binding var selectedTab : String
    var body: some View {
        
        ZStack{
              
            TabView(selection: $selectedTab){
                HomeView(showMenu: $showMenu)
                .tabItem{
                    Image(systemName:"house")
                    Text("Home")
                }.tag("Home")
                
            ListView(showMenu: $showMenu)
                .tabItem{
                    Image(systemName:"list.bullet.rectangle")
                    Text("List")
                }.tag("List")

            EditView(showMenu: $showMenu)
                .tabItem{
                    Image(systemName: "pencil.circle")
                    Text("Edit/Add")
                }.tag("Edit")
        }
            
        }
    }
}


struct MainView_Previews: PreviewProvider {
    @State static var value = false
    @State static var tabvalue = "Home"
    static var previews: some View {
        MainView(showMenu: $value, selectedTab: $tabvalue )
            .environmentObject(Person_Class())
    }
}
