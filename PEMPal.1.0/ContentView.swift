//
//  ContentView.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 1/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            logo()
                .offset(y: -10)
                .ignoresSafeArea(edges: .top)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Vital based tracking of post-exertional malaise")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
