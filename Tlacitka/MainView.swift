//
//  MainView.swift
//  i6 QR code
//
//  Created by Tomas Friml on 17.04.2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
   
    
    var body: some View {
        switch viewRouter.currentPage {
        case .DetainOrderView:
            DetailOrderView(current_order: Order(item:[OrderItem(OriSort: 0)],  zakaznik: "YYYYYYYYY"))
        case .SelectOrderView:
            SelectOrderView(orders: [])
                .transition(.scale)
        case .EditInView:
            EditInView()
                .transition(.scale)
       
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ViewRouter())
    }
}
