//
//  Storage.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

import Foundation

enum StorageKey: String {
    case product
}

protocol Storaging {
    func create<T: Encodable>(object: T, key: StorageKey) throws
    func read<T: Decodable>(objectType: T.Type, key: StorageKey) throws -> T
    func update<T: Encodable>(object: T, key: StorageKey) throws
    func delete(key: StorageKey)
}

final class Storage: Storaging {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }
    
    func create<T: Encodable>(object: T, key: StorageKey) throws {
        let data = try JSONEncoder().encode(object)
        defaults.set(data, forKey: key.rawValue)
    }
    
    func read<T: Decodable>(objectType: T.Type, key: StorageKey) throws -> T {
        guard let data = defaults.object(forKey: key.rawValue) as? Data else { throw ApiError.nilData }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func update<T: Encodable>(object: T, key: StorageKey) throws {
        try create(object: object, key: key)
    }
    
    func delete(key: StorageKey) {
        defaults.removeObject(forKey: key.rawValue)
    }
}
