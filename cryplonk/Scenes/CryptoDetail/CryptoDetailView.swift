//
//  CryptoDetailView.swift
//  cryplonk
//
//  Created by Chris Varble on 8/7/21.
//

import SwiftUI

struct CryptoDetailView: View {
    
    @ObservedObject var service : WebSocketService
    var stock: Stock
    
    var body: some View {
        VStack {
            Text("$\(getPrice()) USD")
                .font(.system(size: 40))
                .padding()
            Spacer()
            
        }
    }
    
    func getPrice() -> String {
        for item in service.stonks {
            if item.id == stock.id {
                return item.price.stringWithoutZeroFraction
            } else {
                continue
            }
        }
        return ""
    }
}

struct CryptoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailView(service: FinnhubWebSocketService(), stock: Stock(price: 999.99999, fullSymbol: "BINANCE:STONKUDST"))
    }
}
