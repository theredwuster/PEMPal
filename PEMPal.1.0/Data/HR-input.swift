//
//  HeartRate data collection.swift
//  PEMPal.1.0
//
//  Created by Ian Hall on 1/25/23.
//
import Foundation
import SwiftUI
import HealthKit

// Create an instance of HKHealthStore
let healthStore = HKHealthStore()
var heartRateData: Double = 0

func fetchHeartRateData() {
    // Define the heart rate type and anchor date
    let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
    let anchorDate = Date(timeIntervalSinceNow: -3600) // Retrieve data added or modified in the last hour
    
    // Create the query
    let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, newAnchor, error) in
        guard samples is [HKQuantitySample] else {
            print("Error retrieving heart rate data: \(error?.localizedDescription ?? "")")
            return
        }
        
        // process the samples here
    }
    query.updateHandler = {(query, samples, deletedObjects, newAnchor, error) in
        guard samples is [HKQuantitySample] else {
            print("Error retrieving heart rate data: \(error?.localizedDescription ?? "")")
            return
        }
        
        // process the samples here
    }
}
