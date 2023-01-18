//
//  ContentView.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 1/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .top) {
            logo()
                .offset(y: -300)
                .ignoresSafeArea(edges: .top)
            
            VStack(alignment: .leading) {
                Text("Vital based tracking of post-exertional malaise")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .padding()

                Text("Let's start with some basic information about you:")
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                
                Button {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/

                } label: {
                    Text("Button")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10.0)
                        .padding(.vertical, 6.0)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
