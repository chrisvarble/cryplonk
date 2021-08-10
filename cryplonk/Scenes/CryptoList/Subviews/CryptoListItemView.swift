//
//  CryptoListItemView.swift
//  cryplonk
//
//  Created by Chris Varble on 8/7/21.
//

import SwiftUI

struct CryptoListItemView: View {
    var item: Stock
    
    var body: some View {
        HStack {
            Text(item.symbol).padding()
            Spacer()
            Text("$\(item.price.stringWithoutZeroFraction) USD").padding()
        }
    }
}

struct CryptoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListItemView(item: Stock(price: 0.0, fullSymbol: "STONK"))
    }
}
