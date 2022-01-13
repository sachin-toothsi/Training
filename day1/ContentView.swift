//
//  ContentView.swift
//  day1
//
//  Created by AMPA on 11/01/22.
//

import SwiftUI

//class FormViewModel: ObservableObject{
//    @State var name = ""
//    @State var phone = ""
//    @State var gender = ""
//    @State var address = ""
//    @State var dob = Date()
//}

//var ObjectDetails = [FormViewModel]()

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
    
   // @State var viewModel = FormViewModel()
    @State private var showingAlert = false
    
    @State private var name = ""
    @State private var phone = ""
    @State private var gender = ""
    @State private var address = ""
    @State private var dob = Date()
    
    var body: some View{
        VStack{
        Form{
            Section{
                TextField("Name",text: $name)
                TextField("Phone Number",text: $phone)
                HStack {
                           Text("Gender")
                               .font(Font.headline)
                           RadioButtonGroups {
                               selected in
                                     self.gender = selected
                           }
                       }.padding()
                DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
                TextField("Address",text: $address)
            }
            Section{
                Button(action: {
                   // ObjectDetails.append(viewModel);
                    showingAlert = true
                })
                {
                  Text("Save your details")
                }
                .alert(isPresented: $showingAlert){
                    Alert(      title: Text("Your Details are"),
                                message: Text("Your name is \(self.name). Your phone is \(self.phone). Your address is \(self.address) and your date of birth is \(self.dob) and you are \(self.gender)" ))
                }
            }
     }
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
