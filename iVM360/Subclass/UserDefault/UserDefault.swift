//
//  UserDefault.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//

import Foundation
extension UserDefaults {
    
    enum Keys {
        static let user          = "user"
        static let userAddress   = "userAddress"
        static let cousAddress   = "coustmerAddress"
        static let userVehicle   = "userVehicle"
        static let basicDetail   = "basicDetail"
        
        
    }
    
    subscript(key: String) -> Any? {
        get { return value(forKey: key) as Any }
        set {
            switch newValue {
            case let value as Int: set(value, forKey: key)
            case let value as Double: set(value, forKey: key)
            case let value as Bool: set(value, forKey: key)
            case let value as URL: set(value, forKey: key)
            case let value as NSObject: set(value, forKey: key)
            case nil: removeObject(forKey: key)
            default: assertionFailure("Invalid value type.")
            }
            synchronize()
        }
    }
    func hasKey(_ key: String) -> Bool {
        return nil != object(forKey: key)
    }
    
    //Codable Protocol Implementation
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        set(data, forKey: key)
        synchronize()
    }
}

