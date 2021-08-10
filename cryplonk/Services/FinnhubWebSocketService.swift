//
//  FinnhubWebSocketService.swift
//  cryplonk
//
//  Created by Chris Varble on 8/7/21.
//

import Foundation
import Combine

class FinnhubWebSocketService : WebSocketService {
    
    private let session = URLSession(configuration: .default)
    private var task: URLSessionWebSocketTask?
    
    private let baseURL = "wss://ws.finnhub.io"
    private let apiToken = "c47calqad3iesgv0gt20"
    
    private var cancellable: AnyCancellable? = nil
    
    @Published private var stonksResult: [Stock] = []
    
    override init() {
        super.init()
        cancellable = AnyCancellable($stonksResult.debounce(for: 0.75, scheduler: DispatchQueue.main)
                                        .removeDuplicates()
                                        .assign(to: \.stonks, on: self))
    }
    
    private func ping() {
        task?.sendPing { (error) in
            if let error = error {
                print("❌ FinnhubWebSocketService ping failed: \(error)")
            }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 10) { [weak self] in
                self?.ping()
            }
        }
    }
    
    override func connect() {
        if task != nil {
            stop()
        }
        task = session.webSocketTask(with: URL(string: "\(baseURL)?token=\(apiToken)")!)
        task?.resume()
        
        subscribe()
    }
    
    override func stop() {
        task?.cancel(with: .normalClosure, reason: nil)
    }
    
    private func subscribe() {
        let subs = ["{\"type\":\"subscribe\",\"symbol\":\"BINANCE:BTCUSDT\"}",
                    "{\"type\":\"subscribe\",\"symbol\":\"BINANCE:DOTUSDT\"}",
                    "{\"type\":\"subscribe\",\"symbol\":\"BINANCE:DOGEUSDT\"}",
                    "{\"type\":\"subscribe\",\"symbol\":\"BINANCE:ETHUSDT\"}"]
        
        for sub in subs {
            let message = URLSessionWebSocketTask.Message.string(sub)
            task?.send(message) { error in
                if let error = error {
                    print("❌ FinnhubWebSocketService subscribe failed: \(error)")
                }
            }
        }
        
        receiveResponse()
    }
    
    private func receiveResponse() {
        task?.receive {[weak self] result in
            
            switch result {
            case .success(.string(let str)):
                
                do {
                    let result = try JSONDecoder().decode(ResponseModel.self, from: Data(str.utf8))
                    print("_____________________________________\nRESPONSE:\n\(result)")
                    var arr = self?.stonksResult ?? []
                    for item in result.data {
                        arr.appendOrReplaceFirstMatching(item)
                    }
                    arr = arr.sorted(by: { $0.symbol < $1.symbol })
                    print("**************************************\nARRAY:\n\(arr)")
                    DispatchQueue.main.async {
                        self?.stonksResult = arr
                    }
                } catch  {
                    print("❌ FinnhubWebSocketService receiveResponse error: \(error.localizedDescription)")
                }
                
                self?.receiveResponse()
                
            case .failure(let error):
                print("❌ FinnhubWebSocketService receiveResponse error: \(error)")
            default:
                print("❌ FinnhubWebSocketService default hit")
            }
        }
    }
}
