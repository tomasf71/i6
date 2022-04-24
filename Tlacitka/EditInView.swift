//
//  EditInView.swift
//  i6 QR code
//
//  Created by Tomas Friml on 19.04.2022.
//

import SwiftUI
import CodeScanner


struct EditInView: View {
    //@State var current_order: Order
    @EnvironmentObject var viewRouter: ViewRouter

    
    var body: some View {
    VStack {
        Text("Editace záznamu: \(viewRouter.indexEdit)")
      Button("Zpět") {
          viewRouter.currentPage = .DetainOrderView
        }
    }
 }
}
    
    struct EditInView_Previews: PreviewProvider {
        static var previews: some View {
            EditInView( )
           }
       }
