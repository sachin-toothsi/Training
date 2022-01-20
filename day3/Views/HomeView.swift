//
//  HomeView.swift
//  day3
//
//  Created by AMPA on 16/01/22.
//

import Foundation

import SwiftUI

struct HomeView: View{
    
    @Binding var showMenu : Bool
    @EnvironmentObject var person_list : Person_Class
    
     //let coreDM = CoreDataManager()
     
    var body: some View{
        NavigationView{
            VStack{
                Text("The Number of Entries are - \(person_list.person_array.count)")
                    .onTapGesture {
                        debugPrint("person array in menu \(person_list.person_array.description)")
                    }
                
               .navigationBarItems(leading: HStack{Image(systemName: "line.3.horizontal")
                                    .onTapGesture {
                     //showMenu toggle
                   debugPrint("show menu tapped")           
                   showMenu.toggle()}
                   Text("Home")
                       .bold()
               })
            }
        }
        .onAppear(perform: {
            person_list.person_array = person_list.coreDM.getAllPerson()
         })
    }
}

struct HomeView_Previews: PreviewProvider {
    
    @State static var value = false
    
    static var previews: some View {
     HomeView(showMenu: $value)
            .environmentObject(Person_Class())
    }
}
