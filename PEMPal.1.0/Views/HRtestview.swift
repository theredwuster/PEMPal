//
//  HRtestview.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 2/1/23.
//

import SwiftUI
import HealthKit

struct HRtestview: View {
    private var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    
    let store = HKHealthStore()
        
    var updateView: (() -> Void)?
    
    @StateObject var globalModel = GlobalModel()
    
    //var viewModel: vitalsViewModel
    
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

    func start() {
        
        authorizeHealthKit()
        startHeartRateQuery(quantityTypeIdentifier: .heartRate)
        
        //Want AnchoredObjectQuery
        let sampleQuery = HKSampleQuery(sampleType: HKQuantityType(.heartRate), predicate: nil, limit: 500, sortDescriptors: nil) { _, samples, error in
            
            guard let lastSample = samples?.last as? HKQuantitySample else { return }
            let hrs = Int(lastSample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute())))
            DispatchQueue.main.async {
                globalModel.hRValue = hrs
            }
        }
        
//        let sampleQuery = HKSampleQuery(sampleType: HKQuantityType(.heartRate), predicate: nil, limit: 500, sortDescriptors: nil) { query, samples, error in
//
//            guard
//                let lastHRSample = samples?.last as HKQuantitySample else { return }
//
//
//        }
        
        store.execute(sampleQuery)
        
    }
    
    func authorizeHealthKit() {
        let healthKitTypes: Set = [
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
    }

    private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        
        // 1
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        // 2
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
        // 3
        guard let samples = samples as? [HKQuantitySample] else {
            return
        }
            
        self.process(samples, type: quantityTypeIdentifier)

        }
        
        // 4
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        // 5
        healthStore.execute(query)
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        var lastHeartRate = 0.0
        
        for sample in samples {
            if type == .heartRate {
                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
            }
            self.globalModel.hRValue = Int(lastHeartRate)
        }
    }
}

struct HRtestview_Previews: PreviewProvider {
    static var previews: some View {
        HRtestview()
    }
}
