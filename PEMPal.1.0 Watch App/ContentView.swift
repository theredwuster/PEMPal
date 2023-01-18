//
//  ContentView.swift
//  PEMPal.1.0 Watch App
//
//  Created by Tim Wu on 1/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            //Image(systemName: "globe")
            //    .imageScale(.large)
            //  .foregroundColor(.accentColor)
            Text("PEM PAL")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
            Text("Vital based tracking of post-exertional malaise")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
