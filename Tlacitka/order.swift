
import SwiftUI

struct order: View {
    @Binding var okno: Int
    @State private var showingPopover = false
    var body: some View {
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
                okno = 2
                }) {
                    Image(systemName: "doc.viewfinder").foregroundColor(Color.white).font(.largeTitle)
                   }.padding(.trailing)
            }.padding(.vertical).background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.899, green: 0.188, blue: 0.072)/*@END_MENU_TOKEN@*/)
             Spacer()
            
    
        
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
           // okno = 3
                showingPopover = true
                print("ORDER_ENTRY")
        }) {
            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                .font(.largeTitle)
        }
        
        .popover(isPresented: $showingPopover) {
            VStack{
                Spacer()
                TextField("Zadej číslo objednávky", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.red/*@END_MENU_TOKEN@*/)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .keyboardType(/*@START_MENU_TOKEN@*/.asciiCapable/*@END_MENU_TOKEN@*/)
                Spacer()
                Button( action: {
                    showingPopover = false
                }) {
                    Image(systemName: "arrowshape.turn.up.backward.2.circle.fill").foregroundColor(Color.red).font(.largeTitle)
                   }.padding(.trailing)
            }.padding(.vertical)
            
        }
            Spacer()
        }
        .padding()
    
     
    }
        
    }
    
}
struct order_Previews: PreviewProvider {
   static var previews: some View {
       order(okno: .constant(Int(1)))
   }
}
