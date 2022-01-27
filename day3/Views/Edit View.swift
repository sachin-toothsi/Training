//
//  Edit View.swift
//  day3
//
//  Created by AMPA on 16/01/22.
//

import Foundation
import SwiftUI
import SimpleToast
import CoreLocationUI


struct EditView: View{
    
    @State private var showingToast = false
    
    @StateObject var locationManager = LocationManager()
    
    @EnvironmentObject var person_list : Person_Class;
    
    @State private var isShowingPhotoPicker = false
   
    @State private var avatarImage = UIImage(named: "logo")!

    
    let coreDM = CoreDataManager()
    

    @Binding var showMenu : Bool
    
    @State private var person_name = ""
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
        NavigationView{
            VStack{
                Image(uiImage: avatarImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 158, height: 158)
                    .clipShape(Circle())
                    
                Form{
                            TextField("Name",text: $person_name)
                            TextField("Phone Number",text: $person_phone)
                            HStack {
                                Text("Gender")
                                    .font(Font.headline)
                                RadioButtonGroups {
                                    selected in
                                    self.person_gender = selected
                                }
                            }.padding()
                            
                            
                            DatePicker("Date of Birth", selection: $person_dob, displayedComponents: .date)
                           
                            
                            TextField("Address",text: $person_address)
                            
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
                                
                                Button(action: {})
                                {
                                    Text("Save your details")
                                }
                                .onTapGesture {
                                    person_list.coreDM.savePerson(name : person_name,address : person_address,dob: person_dob,phone: person_phone,gender: person_gender,latitude: locationManager.location?.latitude ?? 37.332331  , longitude: locationManager.location?.longitude ?? -122.031219)
                                       
//                                    coreDM.savePerson(name : person_name,address : person_address,dob: person_dob,phone: person_phone,gender: person_gender)
                                    
                                    showingToast.toggle()}
                                
                                
                                Spacer()
                                
                                
                                Button(action: {})
                                {
                                    Text("Reset Form")}
                                .onTapGesture {
                                    person_name = ""
                                    person_dob = Date()
                                    person_phone = ""
                                    person_address = ""
                                    person_gender = ""
                                }
                                
                                
                            }
                            
                            
                        }
            }
            .simpleToast(isPresented: $showingToast, options: toastOptions){
                        Text("data stored sucessfully")
                            .onAppear(perform: {
//                     person_list.person_array = coreDM.getAllPerson()
                            })
                    }
                    .navigationBarItems(leading:HStack{Image(systemName: "line.3.horizontal")
                                       .onTapGesture {
                          //showMenu toggle
                                          debugPrint("show menu tapped")
                                            showMenu.toggle()
                                                        }
                                            Text("Edit")
                                                .bold()
                                                })
                     
                    .sheet(isPresented: $isShowingPhotoPicker, content: {
                        PhotoPicker(avatarImage: $avatarImage)
                    })
            
            
           }
           .onAppear(perform: {
                person_list.person_array = coreDM.getAllPerson()
            })
    }
}

struct EditView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        EditView(showMenu: $value)
            .environmentObject(Person_Class())
    }
}
