//
//  UserDefaultUtility.swift
//  SMCApp
//
//  Created by 1707 on 14/12/23.
//

import Foundation
import UIKit

//===========================================================
//MARK: - RootViewController
//===========================================================
enum RootViewController {
    case Home,Login,Verification
}

struct UserDefaultUtility
{
    //===================================================================
    //MARK:- SaveData in userDefault regionId
    //===================================================================
    func saveClientCode(ClientCode: String)
    {
        UserDefaults.standard.set(ClientCode, forKey: "ClientCode")
    }
    func saveAsmtId(AsmtId: String)
    {
        UserDefaults.standard.set(AsmtId, forKey: "AsmtId")
    }
    func saveClientSiteName(ClientSiteName: String)
    {
        UserDefaults.standard.set(ClientSiteName, forKey: "ClientSiteName")
    }
    func saveShiftCode(ShiftCode: String)
    {
        UserDefaults.standard.set(ShiftCode, forKey: "ShiftCode")
    }
//    func saveuserId(userId: String)
//    {
//        UserDefaults.standard.set(userId, forKey: "userId")
//    }
//    func savePorterStatus(status: Int)
//    {
//        UserDefaults.standard.set(status, forKey: "Status")
//    }
//    func saveToken(token: String)
//    {
//        UserDefaults.standard.set(token, forKey: "token")
//    }
//    func isLoginNav(isLogin:Bool)
//    {
//        UserDefaults.standard.set(isLogin, forKey: "ISLOGIN")
//    }
//    func runningTrip(trip_id:String)
//    {
//        UserDefaults.standard.set(trip_id, forKey: "TRIPID")
//    }
//    func devicesToken(deviceToken:String) {
////        UserDefaults.standard.set(deviceToken, forKey: "deviceToken")
//    }

    //===================================================================
    //MARK:- Get in userDefault
    //===================================================================
    func getClientCode() -> String
    {
        return UserDefaults.standard.value(forKey: "ClientCode") as! String
    }
    func getAsmtId() -> String
    {
        return UserDefaults.standard.value(forKey: "AsmtId") as? String ?? ""
    }
    func getClientSiteName() -> Int
    {
        return UserDefaults.standard.value(forKey: "ClientSiteName") as? Int ?? 0
    }
    func getShiftCode() -> Int
    {
        return UserDefaults.standard.value(forKey: "ShiftCode") as? Int ?? 0
    }
//    func getuserId() -> String
//    {
//        return UserDefaults.standard.value(forKey: "userId") as? String ?? ""
//    }
//    func getPorterStatus() -> Int
//    {
//        return UserDefaults.standard.value(forKey: "Status") as? Int ?? 0
//    }
//    func getIsLogin() -> Bool
//    {
//        return UserDefaults.standard.value(forKey: "ISLOGIN") as? Bool ?? false
//    }
//    func getToken() -> String
//    {
//        return UserDefaults.standard.value(forKey: "token") as? String ?? ""
//    }
//    func getRunninTrip() -> String
//    {
//        return UserDefaults.standard.value(forKey: "TRIPID") as? String ?? ""
//    }
//    func getDeviceToken() -> String {
//        UserDefaults.standard.value(forKey: "deviceToken") as! String
//    }
    
}
