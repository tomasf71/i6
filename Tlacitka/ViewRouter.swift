//
//  ViewRouter.swift
//  i6 QR code
//
//  Created by Tomas Friml on 17.04.2022.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .DetainOrderView
    @Published var selectedOrder = "Zadej objednávku" 
    @Published var indexEdit = 1
    
    
}
