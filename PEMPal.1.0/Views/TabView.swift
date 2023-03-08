//
//  TabView.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 1/28/23.
//

import Foundation
import Foundation
import SwiftUI

struct tabithas: View {
    @ObservedObject var globalModel: GlobalModel
    
    var body: some View {
        TabView{
            HomePageView(globalModel: globalModel)
                .tabItem(){
                    Image(systemName: "house")
                        .font(.largeTitle)
                        .imageScale(.large)
                }
            Help()
                .tabItem(){
                    Image(systemName: "questionmark.circle")
                        .font(.largeTitle)
                }
            UpdateProfile()
                .tabItem(){
                    Image(systemName: "mail")
                        .font(.largeTitle)
                }
        }
        .onAppear{
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}
    

struct tabithas_previewer: PreviewProvider {
    static var previews: some View {
        tabithas(globalModel: GlobalModel())
    }
}

