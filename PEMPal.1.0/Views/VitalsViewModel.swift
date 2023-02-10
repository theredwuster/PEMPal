//
//  VitalsViewModel.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 2/7/23.
//

import Foundation

class GlobalModel: ObservableObject {
    @Published var userName = ""
    @Published var userAge = 0
    @Published var userBMI = 0
    @Published var hRValue = 0
    @Published var rRValue = 0
    @Published var bPSys = 0
    @Published var bPDias = 0
    
}


//struct vitalsViewModel: View {
//}
