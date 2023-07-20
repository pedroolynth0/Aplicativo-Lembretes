//
//  Dicionario.swift
//  AppLembretes
//
//  Created by Pedro Olyntho on 20/07/23.
//


import Foundation

struct OrderedDictionary<Key: Hashable, Value> {
    private var keys: [Key] = []
    private var values: [Key: Value] = [:]
    
    
    //MARK: INSERIR
    mutating func insert(_ value: Value, forKey key: Key, at index: Int) {
        if index >= 0 {
            keys.insert(key, at: index)
        } else {
            keys.append(key)
        }
        values[key] = value
    }
    //MARK: CHAVES ORDENADAS
    public var orderedKeys: [Key] {
        return keys
    }
    //MARK: VALOR DAS CHAVES
    func value(forKey key: Key) -> Value? {
        return values[key]
    }
    
    //MARK: TAMANHO DICIONARIO
    var count: Int {
        return keys.count
    }
    
    subscript(key: Key) -> Value? {
        get { return values[key] }
        set {
            if let value = newValue {
                if !keys.contains(key) {
                    keys.append(key)
                }
                values[key] = value
            } else {
                if let index = keys.firstIndex(of: key) {
                    keys.remove(at: index)
                }
                values[key] = nil
            }
        }
    }
    
    subscript(index: Int) -> (key: Key, value: Value)? {
        guard index >= 0, index < keys.count else { return nil }
        let key = keys[index]
        let value = values[key]
        return (key: key, value: value!)
    }
}

extension OrderedDictionary: ExpressibleByDictionaryLiteral {
    init(dictionaryLiteral elements: (Key, Value)...) {
        for (key, value) in elements {
            insert(value, forKey: key, at: -1)
        }
    }
}
