//
//  DoubleExtension.swift
//  cryplonk
//
//  Created by Chris Varble on 8/7/21.
//

import Foundation

extension Double {
    var stringWithoutZeroFraction: String {
        let str = truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.2f", self) : String(self)
        let decimalCount = str.split(separator: ".")[1].count
        let doub = Double(str) ?? 0
        return decimalCount < 2 ? String(format: "%.2f", doub) : str
    }
}
