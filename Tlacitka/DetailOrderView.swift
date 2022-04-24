//
//  ContentView.swift
//  Tlacitka
//
//  Created by Tomas Friml on 03.02.2022.
//

import SwiftUI
import CodeScanner
import AVFoundation

class SelectedOrder: ObservableObject {
    @Published var order = ""
}

struct DetailOrderView: View {
    @State var current_order: Order
    
    @State private var isShowingScannerOrder = false
    @State private var isShowingScannerItem = false
   // @State private var isShowingOrderView = false
    @State private var HideUnblocked = false
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var indexHiLighted : Int = 1000
   
    
    var body: some View {
        
                VStack {
                    HStack{
                        VStack{
                            HStack{
                                Text(viewRouter.selectedOrder).foregroundColor(Color.white).bold().padding(.leading)
                                Spacer()
                            }
                            HStack{
                                Text(current_order.item[0].ComName)
                                    .font(.caption).foregroundColor(Color.white).padding(.leading)
                                Spacer()
                            }
                        }.padding(.leading)
                        Spacer()
                       
                        
                        Button(action: {})
                        {
                            Image(systemName: "doc.viewfinder").foregroundColor(Color.white).padding(.trailing).font(.largeTitle)
                        }.padding(.trailing)
                        
                        .simultaneousGesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    viewRouter.selectedOrder = UIPasteboard.general.string ?? "Zadej objednávku"
                                    SendRequest()
                                    let systemSoundID: SystemSoundID = 1255
                                    AudioServicesPlaySystemSound(systemSoundID)
                                }
                        )
                        .highPriorityGesture(TapGesture()
                                                .onEnded { _ in
                                                    print("Najdi dokumet!")
                                                    isShowingScannerOrder=true;
                                                })
                        
                        
                        
                    }.padding(.vertical).background(Color(red: 0.899, green: 0.188, blue: 0.072))
                        .sheet(isPresented: $isShowingScannerOrder) {
                            CodeScannerView(codeTypes: [.code39], simulatedData: "OFRC211152", completion: handleScanOrder)
                        }
                    
                    
                    Spacer()
                    
                    
                    // výpis položek
                                    List {
                                        ForEach(0..<current_order.item.count, id: \.self) { index in
                                            
                                            if current_order.item[index].OriSort > 0
                                            {
                                                if (HideUnblocked && current_order.item[index].OriBlock == ".000"){
                                                }
                                                else
                                                {
                                                    HStack{
                                                        
                                                        Text(current_order.item[index].StiLocName+"  ").foregroundColor(Color.black).bold().padding(.all).frame(width: 50.0).background(.yellow).cornerRadius(15)
                                                    
                                                    
                                                        VStack{
                                                            HStack{
                                                                Text(current_order.item[index].StiCode).font(.headline).bold().padding(.horizontal)
                                                                    .background(indexHiLighted==index ? .red: Color(UIColor.systemBackground)).cornerRadius(5)
                                                            
                                                                Spacer()
                                                            }
                                                            
                                                          //  }
                                                            HStack{
                                                                Text(current_order.item[index].StiName)
                                                                    .font(.caption).multilineTextAlignment(.leading).padding(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                                                Spacer()
                                                            }
                                                            HStack{
                                                                
                                                                if let unwrappedIn = current_order.item[index].itemIn {
                                                                    Text(unwrappedIn).font(.caption2)
                                                                        .foregroundColor(Color.red).padding(.leading)
                                                                        
                                                                }
                                                
                                                                Spacer()
                                                            }
                                                        }
                                                        VStack{
                                                            
                                                            Text(current_order.item[index].OriQty).font(.body).foregroundColor(Color.black).bold().padding(.all, 4.0).background(.green).cornerRadius(10)
                                                            
                                                            if (current_order.item[index].OriBlock != ".000")
                                                            {
                                                                Text(String(current_order.item[index].OriBlock)).font(.body).foregroundColor(Color.black).bold().padding(.all, 4.0).background(.blue).cornerRadius(10)
                                                            }
                                                        }
                                                    }.swipeActions {
                                                        Button {
                                                            print("button edit")
                                                            indexHiLighted=1000
                                                            // viewRouter.indexEdit = index
                                                            // viewRouter.currentPage = .EditInView
                                                        }label: {
                                                            Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                                                        }
                                                        .tint(.yellow)
                                                        Button {
                                                            print("button delete")
                                                            current_order.item[index].itemIn = nil
                                                            indexHiLighted=1000
                                                        }label: {
                                                            Label("Delete", systemImage: "trash")
                                                        }
                                                        .tint(.red)
                                                    }
                                                }
                                                
                                            }
                                        }
                                       
                                    }
                    .onAppear {
                        SendRequest() 
                    }
                }
            .padding(.horizontal, -16.0)
            
            
            // paticka s tlačítky
            HStack{
                    Spacer()
                    Button( action: {
                        indexHiLighted=1000
                        isShowingScannerItem = true
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                            .font(.largeTitle)
                    }.disabled(!viewRouter.selectedOrder.contains("R")).sheet(isPresented: $isShowingScannerItem) {
                        CodeScannerView(codeTypes: [.qr],scanMode: .once ,showViewfinder:true , simulatedData: "48560_220173.32", completion: handleScanItem )
                    }
                
                
                    Spacer()
                    Button( action: {
                        indexHiLighted=1000
                        viewRouter.currentPage = .SelectOrderView
                    }) {
                        Image(systemName: "doc.badge.ellipsis")
                            .font(.largeTitle)
                    }
                    Spacer()
                        Button( action: {
                            indexHiLighted=1000
                            current_order.sortLoc()
                    }) {
                        Image(systemName: "arrow.up.arrow.down.circle")
                            .font(.largeTitle)
                    }.disabled(!viewRouter.selectedOrder.contains("R"))
                    Spacer()
                        Button( action: {
                            indexHiLighted=1000
                            HideUnblocked.toggle()
                    }) {
                        Image(systemName: "eye.slash")
                            .font(.largeTitle)
                    }.disabled(!viewRouter.selectedOrder.contains("R"))
                       
                    Spacer()
            }
           
    
    }
    func handleScanItem(result: Result<ScanResult, ScanError>) {
        var succes = false
        isShowingScannerItem = false
        switch result {
        case .success(let result):
            let itemId = result.string.components(separatedBy: "_")[0]
            var itemIn = ""
            if result.string.components(separatedBy: "_").count>1 {
                itemIn = result.string.components(separatedBy: "_")[1]
            }
            print("item IN: \(itemId)")
            print("item IN: \(itemIn)")
            indexHiLighted = 1000
            for index in 0...current_order.item.count-1
            {
                if current_order.item[index].StiId == Int(itemId)
                {
                    print(" porovnavame toto \(current_order.item[index].itemIn ?? "xxxx")")
                    if current_order.item[index].itemIn == nil {
                        current_order.item[index].itemIn = itemIn
                        print("první vyskyt")
                        succes = true
                        indexHiLighted=index
                    }
                    else {
                        current_order.item[index].itemIn!.append(contentsOf: ", " + itemIn)
                        print("Druhý výskyt")
                        succes = true
                        indexHiLighted=index
                    }
                        
                }
            }
        
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
        if (succes) {
            let systemSoundID: SystemSoundID = 1255
            AudioServicesPlaySystemSound(systemSoundID)
            }
        else {
            let systemSoundID: SystemSoundID = 1005
            AudioServicesPlaySystemSound(systemSoundID)
        
        }
        
    }
        
func handleScanOrder(result: Result<ScanResult, ScanError>) {
    isShowingScannerOrder = false
    switch result {
    case .success(let result):
        print("Scanning success")
        viewRouter.selectedOrder=result.string
        SendRequest()
    case .failure(let error):
        print("Scanning failed: \(error.localizedDescription)")
    }
}

    func SendRequest() {
        
            guard let url: URL = URL(string:        "http://info.ul.fccps.cz/request/index6.php?request=1&OrdCode="+viewRouter      .selectedOrder) else {
                    print("invalid URL")
                    return
                }
        
                var urlRequest: URLRequest = URLRequest(url: url)
                urlRequest.httpMethod = "GET"
                URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response,      error) in
                    guard let data = data else {
                        print("invalid response")
                        return
                    }
                    do {
                        current_order.item = try JSONDecoder().decode([OrderItem].self, from: data)
                        current_order.sortOri()
                    } catch {
                        print(error.localizedDescription)
                    }
        
                }).resume()
    }
 
}


 struct DetailOrderView_Previews: PreviewProvider {
    static var previews: some View {
        let objednavka = Order(item:[OrderItem(StiCode: "CBL-SAST-1251-100",OriQty: "3", OriBlock: "2" ,StiName: "SFF-8654-8i (SlimSAS ×8) rovný -> 4× SATA rovný - 60/50", StiLocName: "A2", OriSort: 1)],  zakaznik: "YYYYYYYYY")
       
        
        DetailOrderView(current_order: objednavka )
    }
}
