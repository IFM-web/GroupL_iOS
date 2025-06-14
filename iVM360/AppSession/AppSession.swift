//
//  AppSession.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//

import Foundation

class AppSession: NSObject {
    
    static let shared = AppSession()

    
    static var user: UserModel? {
        get {
            if let data = UserDefaults.standard.data(forKey: UserDefaults.Keys.user) {
                guard let user = try? JSONDecoder().decode(UserModel.self, from: data) else {
                    return UserModel()
                }
                return user
            }
            return nil
        }
        set {
            let s: UserDefaults = UserDefaults.standard
            if newValue != nil {
                guard let jsonData = try? JSONEncoder().encode(newValue) else {
                    return
                }
                s.set(jsonData, forKey: UserDefaults.Keys.user)
            } else {
                s.removeObject(forKey: UserDefaults.Keys.user)
            }
            s.synchronize()
        }
    }
        
    static var authToken: String? {
        get {
            return UserDefaults.standard.string(forKey: ServiceConst.authorization)
        }
        set {
            let s: UserDefaults = UserDefaults.standard
            if newValue != nil {
                s.set(newValue, forKey: ServiceConst.authorization)
            } else {
                s.removeObject(forKey: ServiceConst.authorization)
            }
            s.synchronize()
        }
    }
    static var authTokenDex: String? {
        get {
            return UserDefaults.standard.string(forKey: ServiceConst.tokenDex)
        }
        set {
            let s: UserDefaults = UserDefaults.standard
            if newValue != nil {
                s.set(newValue, forKey: ServiceConst.tokenDex)
            } else {
                s.removeObject(forKey: ServiceConst.tokenDex)
            }
            s.synchronize()
        }
    }
    
    
}
