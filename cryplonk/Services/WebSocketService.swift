//
//  WebSocketService.swift
//  cryplonk
//
//  Created by Chris Varble on 8/7/21.
//

import Foundation

class WebSocketService : ObservableObject {
    
    @Published var stonks: [Stock] = []
    
    private func ping() {
        assertionFailure("Missing: override this in the subclass")
    }
    
    func connect() {
        assertionFailure("Missing: override this in the subclass")
    }
    
    func stop() {
        assertionFailure("Missing: override this in the subclass")
    }
    
    private func subscribe() {
        assertionFailure("Missing: override this in the subclass")
    }
    
    private func receiveResponse() {
        assertionFailure("Missing: override this in the subclass")
    }
}
