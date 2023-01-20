//
//  Help Page.swift
//  PEMPal.1.0
//
//  Created by Ian Hall on 1/19/23.
//

import SwiftUI

struct Help: View {
    var body: some View {NavigationView {
        VStack(spacing: 30){
            HStack{
                Spacer()
                Image("logo")
                    .resizable(capInsets: EdgeInsets())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, alignment: .top).padding(.trailing, 20)
   
            }
            Text("Help Menu").font(.largeTitle)
                .foregroundColor(Color(red: 0.4, green: 0.7, blue: 1))
                .multilineTextAlignment(.center)
                .bold().italic().underline()
                .frame(height: 50.0)
                .dynamicTypeSize(.xxxLarge).padding(.leading,40)
            HStack{
                Text("Report a Problem").font(.title2)
                    .multilineTextAlignment(.leading).padding(.trailing, 40.0).bold()
                Button(action:{} ){
                    NavigationLink(destination: logo()){
                        Image(systemName: "arrow.right")
                            .foregroundColor(.blue).bold()
                    }
                }
                
            }
            HStack{Text("Frequently Asked Questions").font(.title2)
                    .multilineTextAlignment(.leading).padding(.trailing, 10.0).bold()
                Button(action:{}) {                    NavigationLink(destination: logo()){
                    Image(systemName: "arrow.right")
                        .foregroundColor(.blue).bold()
                }
                    
                }
                
                
            }.padding(.leading)
            HStack{Text("Privacy and Security").font(.title2)
                    .multilineTextAlignment(.leading).padding(.trailing, 40.0).bold()
                Button(action:{} ){
                    NavigationLink(destination: logo()){
                        Image(systemName: "arrow.right")
                            .foregroundColor(.blue).bold()
                    }
                }
                
            }
            HStack{Text("A Guide to Using Pem Pal").font(.title2)
                    .multilineTextAlignment(.center).padding(.trailing, 20.0).bold()
                Button(action:{} ){
                    NavigationLink(destination: logo()){
                        Image(systemName: "arrow.right")
                            .foregroundColor(.blue).bold()
                    }
                }
            }
        }.frame(minWidth: 30, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
        
    }
}


struct help_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}
