//
//  HomePageView.swift
//  PEMPal.1.0
//
//  Created by Tim Wu on 1/18/23.
//

import SwiftUI
import HealthKit


struct HomePageView: View {
    @ObservedObject var globalModel: GlobalModel
    
    var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    let store = HKHealthStore()
    var updateView: (() -> Void)?
    
    
    var body: some View {
        ScrollView{
            HStack{
                Spacer()
                Image("logo")
                    .resizable(capInsets: EdgeInsets())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, alignment: .top).padding(.trailing, 20)
            }
            
            // Welcome Message
            VStack(alignment: .leading){
                Text("Hello")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                Text(globalModel.userName)
                    .font(.system(size: 42, weight: .bold, design: .rounded))
            }
            .padding(.top, 50)
            .padding(.trailing, 200)
            
            PEMStatus(globalModel: globalModel)
            lastDay(globalModel: globalModel)
            PEMButton(globalModel: globalModel)
            
            Text("Today")
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .padding(.trailing, 300)
                //.padding(.bottom, 10)
            
            PEMInfo(globalModel: globalModel)
                .tag(0)
            
            Spacer()
        }
    }
}
    

struct HomePageView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomePageView(globalModel: GlobalModel())
    }
}

//******************************************************************//

//struct welcomeText: View {
//
//    @ObservedObject var globalModel = GlobalModel()
//
//    var body: some View{
//        VStack(alignment: .leading){
//            Text("Hello")
//                .font(.system(size: 42, weight: .bold, design: .rounded))
//            Text(globalModel.userName)
//                .font(.system(size: 42, weight: .bold, design: .rounded))
//        }
//        .padding(.top, 50)
//        .padding(.trailing, 200)
//    }
//}

struct PEMStatus: View {
    
    @ObservedObject var globalModel: GlobalModel
    
    // boolean that evaluates whether or not user is at risk for PEM based on heart rate measurements
    // currently buggy - globalModel.userAge always seems to return nil, so the program defaults to 120 bpm as the threshold rate
    var riskBoolean: Bool {
        if globalModel.ReportPEM == true {
            return true
        } else if globalModel.userAge != nil {
            let age = globalModel.userAge
            return Double(globalModel.hRValue) > Double(220 - age!) * 0.76
            // CDC upper threshold
        } else {
            return globalModel.hRValue > 120 // arbitrary threshold if no age is supplied
        }
    }
    
    var riskColor: Color {
        return riskBoolean ? Color.red : Color.green
    }
    
    var buttonLabel: String {
        return riskBoolean ? "High Risk 🚨" : "Low Risk ✅ "
    }
    
    var body: some View{
        Button{
        } label: {
            Text (buttonLabel)
                .frame(width: 300, height: 100, alignment: .center)
                .font(.system(size: 42, weight: .semibold, design: .rounded))
                //.fontWeight(.semibold)
                .padding(.horizontal, 10.0)
                .padding(.vertical, 2.0)
                .foregroundColor(.white)
                .background(riskColor)
                .cornerRadius(8)
        }
    }
}

struct lastDay: View{
    @ObservedObject var globalModel: GlobalModel
    
    var body: some View{
        HStack(spacing: 5){
            Image(systemName: "info.circle")
                .resizable()
                .frame(width: 20, height: 20, alignment: .leading)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding()
            
            Text("You haven't been at risk for PEM in \(globalModel.lastPEM) days!")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.black)
                .layoutPriority(2)
                .padding()
        }
        .background(Color.gray.opacity(0.2))
        .clipShape(Rectangle())
        .frame(width: 350, height: 100)
        .cornerRadius(20)
        .padding(2)
    }
}

struct PEMButton: View{
    @ObservedObject var globalModel: GlobalModel
    
    var body: some View{
        Button( action: {
            print("\(globalModel.hRValue)")
            globalModel.lastPEM = "0"
            globalModel.ReportPEM = true
            
        }) {
            Text ("Report PEM")
                .frame(width: 300, height: 50, alignment: .center)
                .fontWeight(.semibold)
                .padding(.horizontal, 10.0)
                .padding(.vertical, 2.0)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(8)
        }
    }
}

struct PEMInfo: View {
    
    @ObservedObject var globalModel: GlobalModel
    var columns = Array(repeating: GridItem(.flexible(), spacing: 5),
                        count: 2)
    
    var body: some View{
        LazyVGrid(columns: columns, spacing: 30){
            ForEach(createPEMdata(globalModel: globalModel)) {PEM in
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    VStack(alignment: .leading, spacing: 25){
                        Text(PEM.title)
                            .foregroundColor(.white)
                        Text(PEM.data)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        Text(PEM.suggest)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color(PEM.image))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
            }
        }
        .frame(width: 350, height: 350)
        .padding(.horizontal, 10)
        .padding(.top, 45)
    }
}

func createPEMdata(globalModel: GlobalModel) -> [PEM] {
    var hRUpperBound: Int{(220-(globalModel.userAge ?? 0)) * 76 / 100}
    var hRLowerBound: Int{(220-(globalModel.userAge ?? 0)) * 64 / 100}

    var PEMData = [
        PEM(id: 0, title: "Heart Rate", image: "hr", data: "\(globalModel.hRValue) bpm", suggest: "\(hRLowerBound)-\(hRUpperBound) bpm\nhealthy & exercising"),
        PEM(id: 1, title: "Respiratory Rate", image: "rr", data: "\(globalModel.rRValue) /min", suggest: "<60/min\nhealthy & exercising"),
        PEM(id: 2, title: "Blood Pressure", image: "bp", data: "\(globalModel.bPSys)/\(globalModel.bPDias) mmHg", suggest: "<140/90 mmHg\nhealthy & exercising")
    ]
    
    return PEMData
}

struct PEM : Identifiable{
    var id: Int
    var title: String
    var image: String
    var data: String
    var suggest: String
}





//struct addWidget: View{
//    var body: some View{
//        HStack (spacing: 5){
//            Text("+ Add Vitals")
//                .font(.system(size: 20, weight: .semibold, design: .rounded))
//                .foregroundColor(.black)
//                .layoutPriority(1)
//                .lineLimit(2)
//                .padding()
//        }
//        .background(Color.gray.opacity(0.2))
//        .clipShape(Rectangle())
//        .cornerRadius(10)
//        .padding()
//        .padding(.leading, 170)
//        .padding(.top, 130)
//    }
//}

struct tabBar: View{
    var body: some View{
        HStack(spacing: 10){
            Image(systemName: "house.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .padding(20)
            Image(systemName: "map.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .padding(20)
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .padding(20)
            Image(systemName: "headphones")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color(.white))
                .padding(20)
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color(.white))
                .padding(20)
        }
        .background(Color.black.opacity(0.6))
        .clipShape(Rectangle())
        .cornerRadius(25)
        .padding()
    }
}

