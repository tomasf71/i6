//
//  OrderList.swift
//  Tlacitka
//
//  Created by Tomas Friml on 03.02.2022.
//

import SwiftUI

struct OrderItemList:  Codable{
    var OrdCode: String = "ORDC1234"
    var ComName: String = "DANZER BOHEMIA-DÝHÁRNA s.r.o."
}



struct SelectOrderView: View {
    @State var orders: [OrderItemList]
    @EnvironmentObject var selectedOrder: SelectedOrder
    @State var selectedCompany:String = ""
    @EnvironmentObject var viewRouter: ViewRouter
   
 
    var body: some View {
        VStack {
          HStack {
            Spacer()
            Text("Objednávky - Fakturovat").font(.body)
            Spacer()
            }
            HStack {
            Text(viewRouter.selectedOrder)
            .font(.headline).bold().padding(.leading)
             Text(selectedCompany)
            .font(.headline).bold().padding(.leading)
            Spacer()
            Button(action: {
                viewRouter.currentPage = .DetainOrderView
            }, label: {
                Image(systemName: "arrowshape.turn.up.backward")
                    .foregroundColor(Color.white)
            }).padding([.bottom, .trailing])
            }
        }.background(Color(red: 0.899, green: 0.188, blue: 0.072))
    
        List {
            ForEach(0..<orders.count, id: \.self) { index in
              HStack {
                  Text(orders[index].OrdCode)
                      .frame(width: 110.0)
                Text(orders[index].ComName)
                Spacer()
                Button(action: {
                    viewRouter.selectedOrder = orders[index].OrdCode
                    selectedCompany = orders[index].ComName
                    viewRouter.currentPage = .DetainOrderView
                    
                }, label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                    })
                
                    
            }
            }
        }
        .onAppear {
            SendRequest()
        }
    }

    func SendRequest() {
             
            guard let url: URL = URL(string: "http://info.ul.fccps.cz/request/index7.php") else {
                print("invalid URL")
                return
            }
             
            var urlRequest: URLRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard let data = data else {
                    print("invalid response")
                    return
                }
                do {
                    orders = try JSONDecoder().decode([OrderItemList].self, from: data)
            
                } catch {
                    print(error.localizedDescription)
                }
                 
            }).resume()
        
        }



}
 


 struct SelectOrderView_Previews: PreviewProvider {
     static var previews: some View {
         SelectOrderView(orders: [])}
}
