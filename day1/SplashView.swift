//
//  SplashView.swift
//  day1
//
//  Created by AMPA on 11/01/22.
//

import SwiftUI


struct SplashView: View{
    
    @State var isActive:Bool = false
        
        var body: some View {
            VStack {
                
                if self.isActive {
                   
                    ContentView()
                } else {
                    Image("logo")
                }
            }
            
            .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
}
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
