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
    func start() {
        // Authorize HK
        authorizeHealthKit()
        
        // Create the type
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else {return}
        
        // Set up anchor
        if let anchorData = UserDefaults.standard.object(forKey: "anchor") as? Data,
        let anchor = NSKeyedUnarchiver.unarchiveObject(with: anchorData) as? HKQueryAnchor {
            globalModel.myAnchor = anchor
        }
        
        // Create the query
        let anchoredQuery = HKAnchoredObjectQuery(type: sampleType, predicate: nil, anchor: globalModel.myAnchor, limit: 500) {(_, samplesOrNil, _, newAnchor, _) in
            
            guard let samples = samplesOrNil else { return }
            
            // Format lastSample into HR format
            guard let lastSample = samples.last as? HKQuantitySample else { return }
            let hrs = Int(lastSample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute())))
            
            DispatchQueue.main.async {
                globalModel.hRValue = hrs
            }
            
            if let newAnchor = newAnchor { UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject:newAnchor), forKey: "anchor")
                globalModel.myAnchor = newAnchor
            }
            
            // Append and store HR in array -- samples.map {$0.quantity.doubleValue}
            //            for hRSample in samples{
            //                globalModel.hRValue = hrs
            //            }
        }
        store.execute(anchoredQuery)
    }
        
    func authorizeHealthKit() {
        let healthKitTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
            healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
    }
        
    struct hranchoredobject_Previews: PreviewProvider {
        static var previews: some View {
            hranchoredobject()
        }
    }
}

