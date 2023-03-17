//
//  globalModel.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 2/7/23.
//

import Foundation
import HealthKit

class GlobalModel: ObservableObject {
    @Published var userName: String = ""
    @Published var userAge: Int? = nil
    @Published var userWeight: Int? = nil
    @Published var userHeight: Int? = nil
    @Published var userGender: String = ""
    @Published var userCOVIDLength = ""
    @Published var userSymptomSeverity = ""
    @Published var lastPEM: String = ""
    @Published var ReportPEM: Bool = false
    
    @Published var hRValue = 0
    @Published var rRValue = 12
    @Published var bPSys = 120
    @Published var bPDias = 70
    @Published var myAnchor: HKQueryAnchor?
    
    // Benchmarks
    @Published var hRlowerlimit = 0
    @Published var hRupperlimit = 0

    //
    
    let store = HKHealthStore()
    func authorizeHealthKit() {
        let healthKitTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
            healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
    }
    
    init(){
        // Authorize HK
        authorizeHealthKit()
        
        // Create the type
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else {return}
        
        // Set up anchor
        if let anchorData = UserDefaults.standard.object(forKey: "anchor") as? Data,
        let anchor = NSKeyedUnarchiver.unarchiveObject(with: anchorData) as? HKQueryAnchor {
            myAnchor = anchor
        }
        
        // Create the query
        let anchoredQuery = HKAnchoredObjectQuery(type: sampleType, predicate: nil, anchor: myAnchor, limit: HKObjectQueryNoLimit) { [weak self] (_, samplesOrNil, _, newAnchor, _) in
            
            guard let samples = samplesOrNil else { return }
            
            // Format lastSample into HR format
            guard let lastSample = samples.last as? HKQuantitySample else { return }
            let hrs = Int(lastSample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute())))
            
            DispatchQueue.main.async {
                self?.hRValue = hrs
            }
            
            if let newAnchor = newAnchor { UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject:newAnchor), forKey: "anchor")
                
                DispatchQueue.main.async {
                    self?.myAnchor = newAnchor
                }
            }
        }
        
        anchoredQuery.updateHandler = { [weak self] (_, samplesOrNil, _, newAnchor, _) in
            
            guard let samples = samplesOrNil else { return }
            
            // Format lastSample into HR format
            guard let lastSample = samples.last as? HKQuantitySample else { return }
            let hrs = Int(lastSample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute())))
            
            
            DispatchQueue.main.async {
                self?.hRValue = hrs
            }
            
            if let newAnchor = newAnchor { UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject:newAnchor), forKey: "anchor")
                
                
                DispatchQueue.main.async {
                    self?.myAnchor = newAnchor
                }
            }
        }
        store.execute(anchoredQuery)
    }
}

// **TODO**
// Create sample type, create query, .updateHandler for each query
