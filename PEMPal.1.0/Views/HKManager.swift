//
//  HKManager.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 2/7/23.
//

import Foundation
import HealthKit


class HealthStore {
    //Create a store
    //Create the query
    //Execute the query
    //Update the view with the final result
    var healthStore: HKHealthStore?

    init() {
        if HKHealthStore.isHealthDataAvailable(){
            healthStore = HKHealthStore()
        }
    }
}

