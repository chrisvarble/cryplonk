//
//  CryptoListView.swift
//  cryplonk
//
//  Created by Chris Varble on 8/7/21.
//

import SwiftUI

struct CryptoListView: View {
    
    @ObservedObject var service: WebSocketService
    
    var body: some View {
        NavigationView {
            //ScrollView with LazyVStack due to iOS 14 lack of removing List's separator lines
            ScrollView {
                LazyVStack {
                    ForEach(service.stonks, id:\.id) { item in
                        NavigationLink(destination: detailView(for: item).navigationTitle(item.symbol)) {
                            CryptoListItemView(item: item)
                        }.accentColor(Color(hex: "#111111"))
                    }
                }.padding()
            }.navigationTitle("STONKS")
        }.onAppear {
            self.service.connect()
        }
    }
    
    func detailView(for stock: Stock) -> CryptoDetailView {
        return CryptoDetailView(service: service, stock: stock)
    }
}

struct CryptoListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListView(service: FinnhubWebSocketService())
    }
}
