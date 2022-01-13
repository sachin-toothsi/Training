//
//  ContentView.swift
//  day2
//
//  Created by AMPA on 13/01/22.
//

import SwiftUI
import SimpleToast

//MARK:- Single Radio Button Field
struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 20,
        color: Color = Color.black,
        textSize: CGFloat = 14,
        isMarked: Bool = false,
        callback: @escaping (String)->()
    ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}


//MARK:- Group of Radio Buttons
enum Gender: String {
    case male = "Male"
    case female = "Female"
}

struct RadioButtonGroups: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View {
        HStack {
            radioMaleMajority
            radioFemaleMajority
        }
    }
    
    var radioMaleMajority: some View {
        RadioButtonField(
            id: Gender.male.rawValue,
            label: Gender.male.rawValue,
            isMarked: selectedId == Gender.male.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioFemaleMajority: some View {
        RadioButtonField(
            id: Gender.female.rawValue,
            label: Gender.female.rawValue,
            isMarked: selectedId == Gender.female.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}



struct ContentView: View {
    
    @State private var showingToast = false
    
    let coreDM = CoreDataManager()
    
    
    @State private var person_name = ""
    @State private var person_phone = ""
    @State private var person_gender = ""
    @State private var person_address = ""
    @State private var person_dob = Date()
    
   // @State private var persons: [Person] = [Person]()
    
    private let toastOptions = SimpleToastOptions(
        alignment: .top, hideAfter: 2, backdropColor: Color.black.opacity(0.2), animation: .default, modifierType: .slide
    )
    
    var body: some View{
        VStack{
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
                
                HStack{
                    Button(action: {})
                    {
                        Text("Save your details")
                    }
                    .onTapGesture {
                        coreDM.savePerson(name : person_name,address : person_address,dob: person_dob,phone: person_phone,gender: person_gender)
                        
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
                    
//                    List(persons,id: \.self){
//                        person in Text(person.name ?? "")
//                    }
                }
            }
        }.simpleToast(isPresented: $showingToast, options: toastOptions){
            Text("data stored sucessfully")
//                .onAppear(perform: {
//                    persons = coreDM.getAllPerson()
//                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

