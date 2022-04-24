//
//  DataModel.swift
//  i6 QR code
//
//  Created by Tomas Friml on 08.04.2022.
//

import Foundation


struct OrderItem: Codable{
    var StiId: Int = 0
    var StiCode: String = ""
    var OriQty: String = ""
    var OriBlock: String = ""
    var StiName: String = ""
    var StiLocName: String = ""
    var OriSort: Int = 0
    var ComName: String = ""
    var itemIn: String? = ""
    
}


struct Order {
    var item: [OrderItem] = []
    var zakaznik: String = ""
    var sorted:Bool? = true



    mutating func vymaz(){
        self.item.removeAll()
        
        }
    
    mutating func sortLoc()
        {
                           if self.sorted! {
                                self.item.sort{$0.StiLocName > $1.StiLocName}
                                }
                            else{
                                self.item.sort{$0.StiLocName < $1.StiLocName}
                            }
                        self.sorted!.toggle()
        }
    
    mutating func sortOri()
        {
                       self.item.sort{$0.OriSort < $1.OriSort}
                       
        }
  
}

