//
//  AppMain.swift
//  cryplonk
//
//  Created by Chris Varble on 8/7/21.
//

import SwiftUI

@main
struct AppMain: App {
    var body: some Scene {
        WindowGroup {
            CryptoListView(service: FinnhubWebSocketService())
        }
    }
}
