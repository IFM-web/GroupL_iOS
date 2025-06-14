//
//  ShiftsfList.swift
//  iVM360
//
//  Created by 1707 on 22/07/24.
//



import UIKit

class ShiftsfList: Codable {
    var CheckInEnable : String
    var CheckOutEnable : String
    var InTime : String
    var OutTime : String
    var ShiftCode : String
    var ShiftDetails : String
   
    init() {
        self.CheckInEnable  = ""
        self.CheckOutEnable = ""
        self.InTime = ""
        self.OutTime = ""
        self.ShiftCode = ""
        self.ShiftDetails = ""
        
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        self.CheckInEnable  = String(describing: data["CheckInEnable"] ?? "")
        self.CheckOutEnable =  String(describing: data["CheckOutEnable"] ?? "")
        self.InTime  = String(describing: data["InTime"] ?? "")
        self.OutTime = String(describing: data["OutTime"] ?? "")
        self.ShiftCode = String(describing: data["ShiftCode"] ?? "")
        self.ShiftDetails = String(describing: data["ShiftDetails"] ?? "")
        
   
}

}

