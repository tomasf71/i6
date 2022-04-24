//
//  orderentry.swift
//  i6 QR code
//
//  Created by Tomas Friml on 06.02.2022.
//

import SwiftUI

struct orderentry: View {
    @Binding var okno: Int
    var body: some View {
        VStack{
            VStack {
                HStack{
                    VStack{
                        HStack{
                            Text("ORDC220040").foregroundColor(Color.white).bold()
                        Spacer()
                        }
                        HStack{
                            Text("Hitachi Energy Czech Republic s.r.o.")
                                .font(.caption).foregroundColor(Color.white)
                            Spacer()
                        }
                     }.padding(.leading)
                    Spacer()
                    Button( action: {
                    print("Najdi dokumet!")
                    okno = 1
                    }) {
                        Image(systemName: "arrowshape.turn.up.backward.2.circle.fill").foregroundColor(Color.white).font(.largeTitle)
                       }.padding(.trailing)
                }.padding(.vertical).background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.899, green: 0.188, blue: 0.072)/*@END_MENU_TOKEN@*/)
                 Spacer()
            }
           
            TextField("Zadej číslo objednávky", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

            
            // PATICKA
              HStack{
              Spacer()
                  Button( action: {
                  print("Scan!")
              }) {
                  Image(systemName: "qrcode.viewfinder")
                      .font(.largeTitle)
              }
              Spacer()
                  Button( action: {
                  okno = 3
                  print("ORDER_ENTRY")
              }) {
                  Image(systemName: "rectangle.and.pencil.and.ellipsis")
                      .font(.largeTitle)
              }
             
                  Spacer()
              }
              .padding()
          
           
          }
              
    }
}

struct orderentry_Previews: PreviewProvider {
    static var previews: some View {
        orderentry(okno: .constant(Int(3)))
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
