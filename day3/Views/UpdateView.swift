//
//  UpdateView.swift
//  day3
//
//  Created by AMPA on 25/01/22.
//

import Foundation
import SwiftUI
import SimpleToast
import CoreLocationUI

struct UpdateView: View {
    
        let person: Person
   
    
        @State private var showingToast = false
        
        @StateObject var locationManager = LocationManager()
        
        @EnvironmentObject var person_list : Person_Class;
        
        @State private var isShowingPhotoPicker = false
       
        @Binding var needsRefresh : Bool
    
        @State private var avatarImage = UIImage(named: "logo")!

        
        
        @State private var person_name =  ""
        @State private var person_phone = ""
        @State private var person_gender = ""
        @State private var person_address = ""
        @State private var person_dob = Date()
        @State private var person_latitude = 0.0
        @State private var person_longitude = 0.0
        
        
        private let toastOptions = SimpleToastOptions(
            alignment: .top, hideAfter: 2, backdropColor: Color.black.opacity(0.2), animation: .default, modifierType: .slide
        )
        
        
        var body: some View{
                VStack{
                    Image(uiImage: avatarImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 158, height: 158)
                        .clipShape(Circle())
                        
                    Form{
                        TextField("\(person.name ?? "Name")",text: $person_name)
                        TextField("\(person.phone ?? "Phone Number")",text: $person_phone)
                                HStack {
                                    Text("Gender")
                                        .font(Font.headline)
                                    RadioButtonGroups {
                                        selected in
                                        self.person_gender = selected
                                    }
                                }.padding()
                                
                                
                                DatePicker("Date of Birth", selection: $person_dob, displayedComponents: .date)
                               
                                
                        TextField("\(person.address ?? "Address")",text: $person_address)
                                
                                if let location = locationManager.location {
                                    
                                    Text("Your location: \(location.latitude), \(location.longitude)")
                                 
                                     }
                                
                                HStack{
                                    LocationButton {
                                                    locationManager.requestLocation()
                                                }
                                                .frame(height: 44)
                                                .padding()
                                    
                                    Spacer()

                                    Button(action: {})
                                    {
                                        Text("Upload Image")
                                    }
                                    .onTapGesture {
                                        self.isShowingPhotoPicker = true
                                    }
                                   
                                }
                                
                                HStack{
                                    Spacer()
                                    Button(action: {})
                                    {
                                        Text("Update your details")
                                    }
                                    .onTapGesture {
                                        
                                        person.name = person_name
                                        person.address = person_address
                                        person.dob = person_dob
                                        person.phone = person_phone
                                        person.gender = person_gender
                                        person.latitude = locationManager.location?.latitude ?? 37.332331
                                        person.longitude = locationManager.location?.longitude ?? -122.031219
                                        
                                        person_list.coreDM.updatePerson()
                                        
                                        needsRefresh.toggle()
                                        showingToast.toggle()}
                                    
                                    Spacer()
           
                                }
                            }
                    Spacer()
                }
                .simpleToast(isPresented: $showingToast, options: toastOptions){
                            Text("data updated sucessfully")
//                                .onAppear(perform: {
//    //                     person_list.person_array = coreDM.getAllPerson()
//                                })
                        }
                       
                        .sheet(isPresented: $isShowingPhotoPicker, content: {
                            PhotoPicker(avatarImage: $avatarImage)
                        })
                
               .onAppear(perform: {
//                    person_list.person_array = coreDM.getAllPerson()
                })
        }
    }

        
        


struct UpdateView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        UpdateView(person: Person(),needsRefresh: .constant(false))
        
    }
}
