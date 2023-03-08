//
//  PEMPal_1_0App.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 1/11/23.
//

import SwiftUI
import HealthKit

@main
struct PEMPal_1_0App: App {
    
    @ObservedObject var globalModel = GlobalModel()
    
    var body: some Scene {
        WindowGroup {
            InitializeView(globalModel: globalModel)
        }
    }
}
