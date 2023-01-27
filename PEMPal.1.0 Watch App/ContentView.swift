//
//  ContentView.swift
//  PEMPal.1.0 Watch App
//
//  Created by Tim Wu on 1/11/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Image("logo")
            .resizable()
            .frame(width: 100, height: 20)
        
        PEMstatus()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PEMstatus: View{
    @State var PEMrisk = "Low Risk"
    
    var body: some View{
        ScrollView{
            Text("Status:")
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .foregroundColor(.red)
                .padding(.top)
            Text(PEMrisk)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .foregroundColor(.red)
            
            Button{
                self.PEMrisk = "High Risk"
            } label: {
                Text ("Report PEM")
                    .frame(width: 150, height:30, alignment: .center)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10.0)
                    .padding(.vertical, 1.0)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(50)
            }
            .buttonStyle(BorderedButtonStyle(tint: Color.blue.opacity(255)))
        }
    }
}
