//
//  ResponseModel.swift
//  cryplonk
//
//  Created by Chris Varble on 8/7/21.
//

import Foundation

struct ResponseModel: Codable {
    var data: [Stock]
    var type : String
}
