//
//  InitializeView.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 1/11/23.
//

import SwiftUI

struct InitializeView: View {
    @ObservedObject var globalModel: GlobalModel
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
                                TextField("Name", text: $globalModel.userName)
                                    .keyboardType(.webSearch)
                                TextField("Age", value: $globalModel.userAge, format: .number)
                            }
                            
                            Section(header: Text("Personal Information")){
                                TextField("Weight (kg)", value: $globalModel.userWeight, format: .number)
                                    .keyboardType(.numberPad)
                                TextField("Height (cm)", value: $globalModel.userHeight, format: .number)
                                TextField("Gender (M/F/Other)", text: $globalModel.userGender)
                                TextField("Days since last PEM", text: $globalModel.lastPEM)
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
                        globalModel.userCOVIDLength = COVIDpos;
                        globalModel.userSymptomSeverity = COVIDsev;
                        
                    }){NavigationLink(destination: tabithas(globalModel: globalModel).navigationBarBackButtonHidden(true)) {
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
        InitializeView(globalModel: GlobalModel())
            
    }
}
