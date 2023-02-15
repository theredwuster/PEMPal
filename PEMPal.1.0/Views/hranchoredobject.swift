//
//  hranchoredobject.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 2/14/23.
//

import SwiftUI
import HealthKit

struct hranchoredobject: View {
    private var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    let store = HKHealthStore()

    var updateView: (() -> Void)?
    var myAnchor = HKQueryAnchor?

    @StateObject var globalModel = GlobalModel()

    // VIEW CONTROLLER //
    var body: some View {
        ScrollView{
            Image("logo")
                .resizable()
                .frame(width: 100, height: 20)
            HStack{
                Text("\(globalModel.hRValue)")
                    .fontWeight(.regular)
                    .font(.system(size: 50))

                Text("BPM")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
            }
        }
        .onAppear(perform: start)
    }

    // Function on start
    mutating func start() {
        // Authorize HK
        authorizeHealthKit()
        
        // Create the type
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else {return}
        
        // Set up anchor
        if let anchorData = UserDefaults.standard.object(forKey: "anchor") as? Data {
            myAnchor = NSKeyedUnarchiver.unarchiveObject(with: anchorData) as? HKQueryAnchor
            }
        
        // Create the query
        let anchoredQuery = HKAnchoredObjectQuery(type: sampleType, predicate: nil, anchor: myAnchor, limit: 500) { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
            
            guard let samples = samplesOrNil, let deletedObjects = deletedObjectsOrNil else{ return }
            
            // Format lastSample into HR format
            guard let lastSample = samples.last as? HKQuantitySample else { return }
            let hrs = Int(lastSample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute())))
            
            guard let strongSelf = self else {return}
            strongSelf.myAnchor = newAnchor
            
            if let newAnchor = newAnchor{ UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject:newAnchor), forKey: "anchor")
            }
            
            for hRSample in samples{
                globalModel.hRValue = hrs
            }
            
            for deletedhRSamples in deletedObjects{
                return
            }
            
            DispatchQueue.main.async {
                //Update UI
            }
            
            store.execute(anchoredQuery)
            
        }
        
        func authorizeHealthKit() {
            let healthKitTypes: Set = [
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
            healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
        }
        
        struct hranchoredobject_Previews: PreviewProvider {
            static var previews: some View {
                hranchoredobject()
            }
        }
    }
}
