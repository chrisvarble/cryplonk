//
//  FinnhubStockHelper.swift
//  cryplonk
//
//  Created by Chris Varble on 8/7/21.
//

import Foundation

class FinnhubStockHelper {
    static func getSymbol(_ s: String) -> String {
        return s.replacingOccurrences(of: "BINANCE:", with: "").replacingOccurrences(of: "USDT", with: "")
    }
}
