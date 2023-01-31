//
//  InitializeView.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 1/11/23.
//

import SwiftUI

struct InitializeView: View {
    @State var userName = ""
    @State var userAge = ""
    @State var userWeight = ""
    @State var userHeight = ""
    @State var userGender = ""
    @State var userCOVIDLength = 0
    @State var userSymptomLength = 0
    @State private var isEditing = false
    
    @State var COVIDpos = "How long were you positive for COVID?"
    @State var COVIDsympt = "How long did symptoms persist after testing negative?"
    @State var COVIDsev = "How severe was your COVID infection?"
    
    var body: some View {
        NavigationStack{
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
                                    Button(action: {
                                        COVIDpos = "<1 week"
                                    }, label: {
                                        Text("< 1 week")
                                    })
                                    Button(action: {
                                        COVIDpos = "1-2 weeks"
                                    }, label: {
                                        Text("1-2 weeks")
                                    })
                                    Button(action: {
                                        COVIDpos = "> 2 weeks"
                                    }, label: {
                                        Text("> 2 weeks")
                                    })
                                } label: {
                                title: do {Text("COVID Infection: \(COVIDpos)")}
                                }
                                .padding(.bottom, 3)
                                
                                Menu{
                                    Button(action: {
                                        COVIDsympt = "< 1 week"
                                    }, label: {
                                        Text("< 1 week")
                                    })
                                    Button(action: {
                                        COVIDsympt = "1-4 weeks"
                                    }, label: {
                                        Text("1-4 weeks")
                                    })
                                    Button(action: {
                                        COVIDsev = "> 1 month"
                                    }, label: {
                                        Text("> 1 month")
                                    })
                                } label: {
                                title: do {Text("Persistent Symptoms: \(COVIDsympt)")}
                                }
                                .padding(.bottom, 3)
                                
                                Menu{
                                    Button(action: {
                                        COVIDsev = "Mild (Self-recovery)"
                                    }, label: {
                                        Text("Mild (Self-recovery)")
                                    })
                                    Button(action: {
                                        COVIDsev = "Moderate (Saw a doctor)"
                                    }, label: {
                                        Text("Moderate (Saw a doctor)")
                                    })
                                    Button(action: {
                                        COVIDsev = "Severe (Hospitalized)"
                                    }, label: {
                                        Text("Severe (Hospitalized)")
                                    })
                                } label: {
                                title: do {Text("Infection Severity: \(COVIDsev)")}
                                }
                                .padding(.bottom, 3)
                            }
                        }
                    }
                    
                    Button (action: {
                    }){NavigationLink(destination: tabithas().navigationBarBackButtonHidden(true)) {
                        Text("Continue")
                            .frame(width: 200, height: 25, alignment: .center)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 10.0)
                            .padding(.vertical, 6.0)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(8)
                    }
                    .padding()
                    }
                }
            }
        }
    }
}

struct InitializeView_Previews: PreviewProvider {
    static var previews: some View {
        InitializeView()
            
    }
}
