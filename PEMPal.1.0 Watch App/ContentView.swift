//
//  ContentView.swift
//  PEMPal.1.0 Watch App
//
//  Created by Tim Wu on 1/11/23.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    private var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    
    @State private var value = 0
    
    var body: some View {
        ScrollView{
            Image("logo")
                .resizable()
                .frame(width: 100, height: 20)
            HStack{
                Text("\(value)")
                    .fontWeight(.regular)
                    .font(.system(size: 50))
                
                Text("BPM")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
            }
            PEMstatus()
        }
        .onAppear(perform: start)
    }

    func start() {
        autorizeHealthKit()
        startHeartRateQuery(quantityTypeIdentifier: .heartRate)
    }
    
    func autorizeHealthKit() {
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
            self.value = Int(lastHeartRate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PEMstatus: View{
    @State var PEMrisk = "Low Risk"
    
    var body: some View{
        ScrollView{
            Text(PEMrisk)
                .font(.system(size: 25, weight: .semibold, design: .rounded))
                .foregroundColor(.red)
            
            Button{
                self.PEMrisk = "High Risk"
            } label: {
                Text ("Report PEM")
                    .frame(width: 150, height:30, alignment: .center)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10.0)
                    .padding(.vertical, 1.0)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(50)
            }
            .buttonStyle(BorderedButtonStyle(tint: Color.blue.opacity(255)))
        }
    }
}
