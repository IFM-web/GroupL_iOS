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
    func saveAsmtId(AsmtId: String)
    {
        UserDefaults.standard.set(AsmtId, forKey: "AsmtId")
    }
    func saveClientSiteName(ClientSiteName: String)
    {
        UserDefaults.standard.set(ClientSiteName, forKey: "ClientSiteName")
    }
    func saveClientCode(ClientCode: String)
    {
        UserDefaults.standard.set(ClientCode, forKey: "ClientCode")
    }
    func saveShiftCode(ShiftCode: String)
    {
        UserDefaults.standard.set(ShiftCode, forKey: "ShiftCode")
    }
    func saveCheckInEnable(CheckInEnable: String)
    {
        UserDefaults.standard.set(CheckInEnable, forKey: "CheckInEnable")
    }
    func saveCheckOutEnable(CheckOutEnable: String)
    {
        UserDefaults.standard.set(CheckOutEnable, forKey: "CheckOutEnable")
    }
    func saveEmpNumber(EmpNumber: String)
    {
        UserDefaults.standard.set(EmpNumber, forKey: "EmpNumber")
    }
    func saveCurrentAddress(CurrentAddress: String)
    {
        UserDefaults.standard.set(CurrentAddress, forKey: "CurrentAddress")
    }
    func saveShiftEndTime(endTime: String)
    {
        UserDefaults.standard.set(endTime, forKey: "endTime")
    }

    func savedate(date:String)
    {
        UserDefaults.standard.set(date, forKey: "date")
    }
    func saveDevicesToken(deviceToken:String) {
        UserDefaults.standard.set(deviceToken, forKey: "deviceToken")
    }
    func saveFcmToken(fcmToken:String) {
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
    }
    func saveLocationAutoID(fcmToken:String) {
        UserDefaults.standard.set(fcmToken, forKey: "LocationAutoID")
    }

    //===================================================================
    //MARK:- Get in userDefault
    //===================================================================
    func getAsmtId() -> String
    {
        return UserDefaults.standard.value(forKey: "AsmtId") as! String
    }
    func getClientCode() -> String
    {
        return UserDefaults.standard.value(forKey: "ClientCode") as? String ?? ""
    }
    func getClientSiteName() -> String
    {
        return UserDefaults.standard.value(forKey: "ClientSiteName") as? String ?? ""
    }
    func getShiftCode() -> String
    {
        return UserDefaults.standard.value(forKey: "ShiftCode") as? String ?? ""
    }
    func getCheckInEnable() -> String
    {
        return UserDefaults.standard.value(forKey: "CheckInEnable") as? String ?? ""
    }
    func getCheckOutEnable() -> String
    {
        return UserDefaults.standard.value(forKey: "CheckOutEnable") as? String ?? ""
    }
    func getEmpNumber() -> String
    {
        return UserDefaults.standard.value(forKey: "EmpNumber") as? String ?? ""
    }
    func getCurrentAddress() -> String
    {
        return UserDefaults.standard.value(forKey: "CurrentAddress") as? String ?? ""
    }
    func getShiftEndTime() -> String
    {
        return UserDefaults.standard.value(forKey: "endTime") as? String ?? ""
    }
    
    func getDate() -> String {
        UserDefaults.standard.value(forKey: "date") as? String ?? ""
    }
    func getDeviceToken() -> String {
        UserDefaults.standard.value(forKey: "deviceToken") as? String ?? ""
    }
    func getFcmToken() -> String {
        UserDefaults.standard.value(forKey: "fcmToken") as? String ?? ""
    }
    func getLocationAutoID() -> String {
        UserDefaults.standard.value(forKey: "LocationAutoID") as? String ?? ""
    }
    
    
    //===================================================================
    //MARK:- Remove from userDefault
    //===================================================================
    
    
    func removeShiftEndTime() {
        UserDefaults.standard.removeObject(forKey: "endTime")
        
        }
    func removeDate() {
        UserDefaults.standard.removeObject(forKey: "date")
        
        }
 
    func removeEmpNumber() {
        UserDefaults.standard.removeObject(forKey: "EmpNumber")
        
        }
    func removeCheckinEnable() {
        UserDefaults.standard.removeObject(forKey: "CheckInEnable")
        
        }
    func removeCheckOutEnable() {
        UserDefaults.standard.removeObject(forKey: "CheckOutEnable")
        
        }
    
    func removeClientCode() {
        UserDefaults.standard.removeObject(forKey: "ClientCode")
        
        }
    func removeClientSiteName() {
        UserDefaults.standard.removeObject(forKey: "ClientSiteName")
        
        }
    
    func removeAsmtId() {
        UserDefaults.standard.removeObject(forKey: "AsmtId")
        
        }
}
