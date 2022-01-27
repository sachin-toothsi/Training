//
//  ListView.swift
//  day3
//
//  Created by AMPA on 16/01/22.
//

import Foundation
import SwiftUI


struct ListView: View{
    @Binding var showMenu : Bool
    @EnvironmentObject var person_list : Person_Class
    @State var person_array : [Person] = [Person]()
    @State var needsRefresh : Bool = false
    //var person_array =  person_list.coreDM.getAllPerson()
    
    var body: some View{
        NavigationView{
            VStack{
                Text("ListView it is")

                List{
                    ForEach(person_list.person_array,id: \.self){
                        person in
                        NavigationLink(
                            destination: UpdateView(person: person,needsRefresh: $needsRefresh),
                            label: {Text(person.name ?? "") })
                    }
                }.accentColor(needsRefresh ? .black : .black)
                    .navigationBarItems(leading: HStack{Image(systemName: "line.3.horizontal")
                                         .onTapGesture {
                          //showMenu toggle
                        debugPrint("show menu tapped")
                        showMenu.toggle()
                                         }
                        Text("List")
                            .bold()
                    })
            }
        }
        .onAppear(perform: {
            person_list.person_array = person_list.coreDM.getAllPerson()
           // person_list.person_array = person_list.coreDM.getAllPerson()
         })
    }
    
}

struct ListView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        ListView(showMenu: $value)
            .environmentObject(Person_Class())
    }
}
