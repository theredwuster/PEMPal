//
//  Update Profile page.swift
//  PEMPal.1.0
//
//  Created by Ian Hall on 1/19/23.
//

import Foundation
import SwiftUI

struct UpdateProfile: View {
    @ObservedObject var globalModel: GlobalModel

    var body: some View {
        VStack(spacing: 30){
            HStack{
                Spacer()
                Image("logo")
                    .resizable(capInsets: EdgeInsets())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, alignment: .top)
            }.padding(.trailing,20)
            Text("Update Profile").font(.largeTitle).foregroundColor(Color(red: 0.4, green: 0.7, blue: 1))
                .multilineTextAlignment(.center)
                .bold().italic().underline()
            HStack{
                VStack{
                    Text("Age").bold().font(.title2).padding(.trailing, 20).padding(.leading, 70)
                    Text("Weight").bold().font(.title2).padding(.leading, 70)
                    Text("Height").bold().font(.title2).padding(.leading, 70)
                    Text("Gender").bold().font(.title2).padding(.leading, 70)
                }.padding(.trailing, 30)
                
                VStack{
                    TextField("Age", value: $globalModel.userAge, format: .number)
                        .keyboardType(.numberPad)
                    TextField("Weight (kg)", value: $globalModel.userWeight, format: .number)
                        .keyboardType(.numberPad)
                    TextField("Height (cm)", value: $globalModel.userHeight, format: .number)
                        .keyboardType(.numberPad)
                    TextField("Gender (M/F/Other)", text: $globalModel.userGender)
                }
            }
            Button("Save"){}
                .frame(width: 150, height: 25, alignment: .center).font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal, 10.0)
                .padding(.vertical, 6.0)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(8)
                .buttonStyle(.plain)
                .padding()
        }.frame(minWidth: 30, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                }
           
    }
struct profile_Preview: PreviewProvider {
    static var previews: some View {
        UpdateProfile(globalModel: GlobalModel())
    }
    
}
