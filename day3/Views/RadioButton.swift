//
//  RadioButton.swift
//  day3
//
//  Created by AMPA on 19/01/22.
//

import Foundation
import SwiftUI
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
//            self.callback(self.id)
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
        .onTapGesture {
            self.callback(self.id)
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


//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    
//    let manager = CLLocationManager()
//
//    @Published var location: CLLocationCoordinate2D?
//
//    override init() {
//        super.init()
//        manager.delegate = self
//    }
// 
//    func requestLocation() {
//        manager.requestLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//             print("error:: \(error.localizedDescription)")
//        }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.first?.coordinate
//    }
//}




