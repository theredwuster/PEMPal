//
//  HeartRateChart1.swift
//  PEMPal.1.0
//
//  Created by Ian Hall on 1/25/23.
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
    Profit(department: "Production", profit: 15000),
    Profit(department: "Marketing", profit: 8000),
    Profit(department: "Finance", profit: 10000)
]

var bodies: some View {
    Chart(datas) {
        BarMark(
            x: .value("Department", $0.department),
            y: .value("Profit", $0.profit)
        )
    }.hoverEffect(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
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
