//
//  HR-observer.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 1/28/23.
//

import SwiftUI
import HealthKit

class ViewController: UIViewController {
    
    var healthStore: HKHealthStore? = nil
    var bpm = 0.0
    let sampleType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)
    
    
    //    public func subscribeToHeartBeatChanges() {
    //        heartRateQuery = HKObserverQuery.init(
    //            sampleType: sampleType!,
    //            predicate: nil) { [weak self] _, _, error in
    //                guard error == nil else{
    //                    log.warn(error!)
    //                    return
    //                }
    //
    //                self.fetchLatestSampleHeartRateSample(completion: { sample in
    //                    guard let sample = sample else {
    //                        return
    //                    }
    //                    DispatchQueue.main.async{
    //                        let heartRateUnit = HKUnit(from: "count/min")
    //                        let heartRate = sample
    //                            .quantity
    //                            .doubleValue(for: heartRateUnit)
    //
    //                        self?.heartRateLabel.setText("\(Int(heartRate))")
    //                    }
    //                })
    //            }
    //    }
    //
    //    public func fetchLatestHeartRateSample(completion: @escaping (_ sample: HKQuantitySample?) -> Void){
    //        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else{
    //            completion(nil)
    //            return
    //        }
    //
    //        let predicate = HKQuery
    //            .predicateForSamples(withStart: Date.distantPast, end: Date(),options: .strictEndDate)
    //
    //        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
    //
    //        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { (_, results, error) in
    //            guard error == nil else{
    //                print("Error: \(error!.localizedDescription)")
    //                return
    //            }
    //            completion(results?[0] as? HKQuantitySample)
    //        }
    //        self.healthStore?.execute(query)
    //    }
    //
    //
    //
    //
    //    //Check if Health is available on this device
    //    func isHealthAvailable() -> Bool {
    //        return HKHealthStore.isHealthDataAvailable()
    //    }
    //
    //    //Check if this app is authorized to access Health data
    //    func isHealthAuthorized() -> Bool {
    //        return healthStore!.authorizationStatus(for: sampleType!) == HKAuthorizationStatus.sharingAuthorized
    //    }
    //
    //
    //}
}
