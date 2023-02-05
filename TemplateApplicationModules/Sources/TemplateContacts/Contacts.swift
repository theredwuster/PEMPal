//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Contact
import Foundation
import SwiftUI


/// Displays the contacts for the CardinalKit Template Application.
public struct Contacts: View {
    
    //PREVIOUS
    let contacts = [
        Contact(
            name: PersonNameComponents(
                givenName: "Leland",
                familyName: "Stanford"
            ),
            image: Image(systemName: "figure.wave.circle"),
            title: "University Founder",
            description: String(localized: "LELAND_STANFORD_BIO", bundle: .module),
            organization: "Stanford University",
            address: {
                let address = CNMutablePostalAddress()
                address.country = "USA"
                address.state = "CA"
                address.postalCode = "94305"
                address.city = "Stanford"
                address.street = "450 Serra Mall"
                return address
            }(),
            contactOptions: [
                .call("+1 (650) 723-2300"),
                .text("+1 (650) 723-2300"),
                .email(addresses: ["contact@stanford.edu"]),
                ContactOption(
                    image: Image(systemName: "safari.fill"),
                    title: "Website",
                    action: {
                        if let url = URL(string: "https://stanford.edu") {
                           UIApplication.shared.open(url)
                        }
                    }
                )
            ]
        )
    ]
    //
    
    public var body: some View {
        VStack{
            HStack{
                Spacer()
                Image("logo")
                    .resizable(capInsets: EdgeInsets())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, alignment: .top).padding(.trailing, 20)
   
            }
            
            welcomeText()
            lastDay()
            PEMButton()
    
            PEMInfo(PEMData: PEMData)
                .tag(0)
                .overlay(addWidget())
        
            Spacer()
            
            //tabBar()
            
        }
    }
    
    public init() {}
}


struct Contacts_Previews: PreviewProvider {
    static var previews: some View {
        Contacts()
    }
}


struct welcomeText: View {
    var body: some View{
        VStack(alignment: .leading){
            Text("Hello")
                .font(.system(size: 42, weight: .bold, design: .rounded))
            Text("User.")
                .font(.system(size: 42, weight: .bold, design: .rounded))
        }
        .padding(.top, 50)
        .padding(.trailing, 200)
    }
}

struct lastDay: View{
    var body: some View{
        HStack(spacing: 5){
            Image(systemName: "info.circle")
                .resizable()
                .frame(width: 20, height: 20, alignment: .leading)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding()
            
            Text("You haven't been at risk for PEM in 4 days!")
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
    var body: some View{
        Button{
            
        } label: {
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
    
    var PEMData: [PEM]
    var columns = Array(repeating: GridItem(.flexible(), spacing: 5),
                        count: 2)
    
    var body: some View{
        LazyVGrid(columns: columns, spacing: 30){
            ForEach(PEMData) { PEM in
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    VStack(alignment: .leading, spacing: 25){
                        Text(PEM.title)
                            .foregroundColor(.white)
                        Text(PEM.data)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        Text(PEM.suggest)
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

struct PEM : Identifiable{
    var id: Int
    var title: String
    var image: String
    var data: String
    var suggest: String
}

var PEMData = [
    PEM(id: 0, title: "Heart Rate", image: "hr", data: "0 bpm", suggest: "70-130\nhealthy"),
    PEM(id: 1, title: "Respiratory Rate", image: "rr", data: "50 /min", suggest: "40 /min\nhealthy"),
    PEM(id: 2, title: "Blood Pressure", image: "bp", data: "110/70 mmHg", suggest: "120/50 mmHg\nhealthy")
    
]


struct addWidget: View{
    var body: some View{
        HStack (spacing: 5){
            Text("+ Add Vitals")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.black)
                .layoutPriority(1)
                .lineLimit(2)
                .padding()
        }
        .background(Color.gray.opacity(0.2))
        .clipShape(Rectangle())
        .cornerRadius(10)
        .padding()
        .padding(.leading, 170)
        .padding(.top, 130)
    }
}

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

