//
//  Stock.swift
//  cryplonk
//
//  Created by Chris Varble on 8/7/21.
//

import Foundation

struct Stock : Codable, Equatable, Identifiable {
    
    var id: String
    var price, volume, timestamp: Double
    var symbol: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "s"
        case price = "p"
        case symbol
        case timestamp = "t"
        case volume = "v"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        price = try container.decode(Double.self, forKey: .price)
        symbol = FinnhubStockHelper.getSymbol(id)
        timestamp = try container.decode(Double.self, forKey: .timestamp)
        volume = try container.decode(Double.self, forKey: .volume)
    }
    
    init(price: Double, fullSymbol: String) {
        self.id = fullSymbol
        self.price = price
        self.symbol = FinnhubStockHelper.getSymbol(id)
        self.timestamp = 0
        self.volume = 0
    }
}
