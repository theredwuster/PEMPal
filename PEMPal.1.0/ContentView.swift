//
//  ContentView.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 1/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var userName = ""
    @State var userAge = ""
    @State var userWeight = ""
    @State var userHeight = ""
    @State var userGender = ""
    @State var userCOVIDLength = 0
    @State var userSymptomLength = 0
    @State private var isEditing = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                logo()
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                
                
                Text("Vital based tracking of post-exertional malaise")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)

                Text("Let's start with some basic information about you:")
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
            
                Form{
                    ScrollView{
                        Section{
                            TextField("Full name", text: $userName)
                            TextField("Age", text: $userAge)
                        }
                        
                        Section(header: Text("Personal Information")){
                            TextField("Weight (kg)", text: $userWeight)
                                .keyboardType(.numberPad)
                            TextField("Height (cm)", text: $userHeight)
                            TextField("Gender (M/F/Other)", text: $userGender)
                        }
                        
                        Section(header: Text("COVID Information")){
                           
                            Menu{
                                Button(action: {}, label: {
                                    Text("< 1 week")
                                })
                                Button(action: {}, label: {
                                    Text("1-2 weeks")
                                })
                                Button(action: {}, label: {
                                    Text("> 2 weeks")
                                })
                            } label: {
                            title: do {Text("Length of COVID Infection")}
                            }
                        }
                    }
                }
                
                Button (action: {

                }, label: {
                    Text("Continue")
                        .frame(width: 200, height: 25, alignment: .center)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10.0)
                        .padding(.vertical, 6.0)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(8)
                })
                .buttonStyle(.plain)
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
