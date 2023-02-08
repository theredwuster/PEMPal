//
//  HeartRateChart1.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 1/28/23.
//

import Foundation
import SwiftUI
import Charts

struct Profit: Identifiable {
    let id = UUID()
    let department: String
    let profit: Double
}

let datas: [Profit] = [
    Profit (department: "T-4", profit: 75),
    Profit(department: "T-3", profit: 65),
    Profit(department: "T-2", profit: 72),
    Profit(department: "T-1", profit: 80),
    Profit(department: "Today", profit: 79)
]

var bodies: some View {
    Chart(datas) {
        LineMark(
            x: .value("Date", $0.department),
            y: .value("Heart Rate", $0.profit)
        )
    }.hoverEffect(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
    .chartXAxisLabel ("Date", alignment: .center)
    .chartYAxisLabel("Heart Rate, bpm")
}

struct ContentViewer: View {
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Image("logo")
                    .resizable(capInsets: EdgeInsets())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, alignment: .top).padding(.trailing, 20)
   
            }
            Text("Heart Rate History").font(.largeTitle).foregroundColor(Color(red: 0.4, green: 0.7, blue: 1))
                .multilineTextAlignment(.center)
                .bold().italic().underline()
            bodies
            
        }
        .padding()
    }
}



struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            ContentViewer()
        }
    }
}
