//
//  ContentView.swift
//  day3
//
//  Created by AMPA on 14/01/22.
//

import SwiftUI

class Person_Class : ObservableObject {
    @Published var person_array : [Person] = [Person]()
    @Published var coreDM : CoreDataManager = CoreDataManager()
    
}

struct ContentView: View {
    @State var showMenu = false
    @State var selectedTab = "Home"
    @ObservedObject private var person_list : Person_Class = Person_Class()
    
    @EnvironmentObject var viewModel : AuthenticationViewModel
   
    
    var body: some View{
        
        VStack{
            
        if(self.showMenu)
        {
            MenuView(showMenu: $showMenu, selectedTab : $selectedTab)
        }
        else
        {
            MainView(showMenu: $showMenu, selectedTab : $selectedTab)
        }
            
        }.environmentObject(person_list)
            
        
        
        
//        ZStack(alignment: .leading) {
//                 MainView(showMenu: $showMenu)
//                                if self.showMenu {
//                                    MenuView(showMenu: $showMenu)
//                                }
//                        }

        //  MainView(showMenu: self.$showMenu)
         // ZStack(alignment: .leading) {
         // GeometryReader { geometry in
         //          MainView(showMenu: $showMenu)
       //               .frame(width: geometry.size.width, height: geometry.size.height)
         //                         if self.showMenu {
         //                             MenuView(showMenu: $showMenu)
           //                           frame(width: geometry.size.width/2)
           //                       }
           //               }
          //        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthenticationViewModel())
    }
}
