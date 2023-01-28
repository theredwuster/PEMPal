//
//  HRGraph.swift
//  PEMPal.1.0
//
//  Created by Ian Hall on 1/27/23.
//

//test merger


import Foundation
import HealthKit
import Charts
import SwiftUI

//let healthStore = HKHealthStore()
// var heartRateData: [Double] = []

let interval = DateComponents(second: Int(1000) / 20)
let quantityType = HKObjectType.quantityType(
    forIdentifier: .heartRate
)!

let query = HKStatisticsCollectionQuery(
    quantityType: quantityType,
    quantitySamplePredicate: nil,
    options: [.discreteMax, .discreteMin],
    anchorDate: Date(), //need to set to current date
    intervalComponents: interval
)
func fetchOneHRData() {
    query.initialResultsHandler = { _, results, error in
        var weeklyData: [Date: (Double, Double)] = [:]
        
        results!.enumerateStatistics(
            from: Date()-7, ///need to change
            to: Date()  // need to change
        ) { statistics, _ in
            if let minValue = statistics.minimumQuantity() {
                if let maxValue = statistics.maximumQuantity() {
                    let minHeartRate = minValue.doubleValue(
                        for: HKUnit(from: "count/min")
                    )
                    let maxHeartRate = maxValue.doubleValue(
                        for: HKUnit(from: "count/min")
                    )
                    
                    weeklyData[statistics.startDate] = (
                        minHeartRate, maxHeartRate)
                }
            }
        }
        
        // use `weeklyData`
    }
}





struct HRSample: Identifiable {
    let id = UUID()
    let date: Date
    let min: Int
    let max: Int
}


let mappedMeasurements: [HRSample] = measurement.map { //
    (date, span) in let (min, max) = span
    return HRSample(date: date, min: Int(min), max: Int(max))
}

func mapHRdat(){
    Chart(mappedMeasurements, id: \.id) {
        BarMark(
            x: .value("Time", $0.date, unit: .minute),
            yStart: .value("BPM Min", $0.min),
            yEnd: .value("BPM Max", $0.max),
            width: .fixed(10)
        )
        .clipShape(Capsule()).foregroundStyle(.red)
    }
    .chartXAxis {
        AxisMarks(values:.stride(by:24.0)) { _ in //need to change 24.0
            AxisValueLabel(
                format: .dateTime.hour(.defaultDigits(amPM: .narrow))
            )
        }
    }
    .chartYScale(domain: 50...190).frame(height: 150)
}
