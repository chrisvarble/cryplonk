//
//  ArrayExtension.swift
//  cryplonk
//
//  Created by Chris Varble on 8/7/21.
//

import Foundation

extension Array where Element: Identifiable {
    mutating func appendOrReplaceFirstMatching(_ item: Element) {
        appendOrReplace(item, firstMatchingKeyPath: \.id)
    }
    
    private mutating func appendOrReplace<Value>(_ item: Element, firstMatchingKeyPath keyPath: KeyPath<Element, Value>) where Value: Equatable {
        let itemValue = item[keyPath: keyPath]
        appendOrReplace(item, whereFirstIndex: { $0[keyPath: keyPath] == itemValue })
    }
    
    private mutating func appendOrReplace(_ item: Element, whereFirstIndex predicate: (Element) -> Bool) {
        if let idx = self.firstIndex(where: predicate) {
            self[idx] = item
        } else {
            append(item)
        }
    }
}
