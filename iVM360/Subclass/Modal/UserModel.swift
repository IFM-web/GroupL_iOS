//
//  UserModel.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//

import UIKit

class UserModel: Codable {
        var MessageID          : String
        var MessageString       : String
        var EmpName             : String
        var EmpNumber          : String
        var Designation         : String
        var LocationAutoID       : String
        var ContactNo           : String
        var CompanyCode         : String
        var Isrunnner : String
        var UserSessionID : String
        var dex_runner_username : String


    init() {
        
        self.MessageID       = ""
        self.MessageString       = ""
        self.EmpName       = ""
        self.EmpNumber       = ""
        self.Designation       = ""
        self.LocationAutoID       = ""
        self.ContactNo       = ""
        self.CompanyCode       = ""
        self.Isrunnner = ""
        self.UserSessionID = ""
        self.dex_runner_username = ""
  
    }
    convenience init(withData data:[String:Any]) {
        self.init()
        
        
        
        self.MessageID          = String(describing: data["MessageID"] ?? "")
        self.MessageString          = String(describing: data["MessageString"] ?? "")
        self.EmpName          = String(describing: data["EmpName"] ?? "")
        self.EmpNumber          = String(describing: data["EmpNumber"] ?? "")
        self.Designation          = String(describing: data["Designation"] ?? "")
        self.LocationAutoID          = String(describing: data["LocationAutoID"] ?? "")
        self.ContactNo          = String(describing: data["ContactNo"] ?? "")
        self.CompanyCode          = String(describing: data["CompanyCode"] ?? "")
        self.Isrunnner          = String(describing: data["Isrunnner"] ?? "")
        self.UserSessionID          = String(describing: data["UserSessionID"] ?? "")
        self.dex_runner_username          = String(describing: data["dex_runner_username"] ?? "")
        
        
        
       
  
//        if let password = data["passwordText"] as? Int{
//            self.passwordText = "\(password)"
//        }
//
//        if let profileUrl           = data["profilePic"] as? String,
//                                    profileUrl.isEmpty == false {
//            self.profileUrl         = profileUrl
//        }
        if let token                = data["UserSessionID"] as? String {
            AppSession.authTokenDex    = token
        }
        
    }
    static var instance: UserModel {
        if let data = UserDefaults.standard.data(forKey: UserDefaults.Keys.user) {
            guard let driver = try? JSONDecoder().decode(UserModel.self, from: data) else {
                return UserModel()
            }
            return driver
        }
        return UserModel()
    }
    //===========================================================
    //MARK: - Saved Object in driverDefault
    //===========================================================
    func saved() {
        UserDefaults.standard.set(object: self, forKey: UserDefaults.Keys.user)
    }
}
        
