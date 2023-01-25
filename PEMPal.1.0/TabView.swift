//
//  TabView.swift
//  PEMPal.1.0
//
//  Created by Ian Hall on 1/24/23.
//

import Foundation
import Foundation
import SwiftUI

struct tabithas: View {
    var body: some View {TabView{
        HomePageView().tabItem(){Image(systemName: "house")
                .font(.largeTitle)
                .imageScale(.large)
        }
        Help().tabItem(){
            Image(systemName: "questionmark.circle")
                .font(.largeTitle)
        }
        UpdateProfile().tabItem(){
            Image(systemName: "mail")
                .font(.largeTitle)
        }
        }
    }
}
    

struct tabithas_previewer: PreviewProvider {
    static var previews: some View {
        tabithas()
    }
}
