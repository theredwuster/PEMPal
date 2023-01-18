//
//  logo.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 1/11/23.
//

import SwiftUI

struct logo: View {
    var body: some View {
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}

struct logo_Previews: PreviewProvider {
    static var previews: some View {
        logo()
    }
}
