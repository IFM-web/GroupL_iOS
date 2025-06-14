//
//  time_deatils.swift
//  iVM360
//
//  Created by Mac on 15/05/25.
//

import UIKit

class time_deatils: Codable {
    var CheckInEnable : String
    var CheckOutEnable : String
    var InTime : String
    var OutTime : String
   
   
    init() {
        self.CheckInEnable  = ""
        self.CheckOutEnable = ""
        self.InTime = ""
        self.OutTime = ""
       
        
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        self.CheckInEnable  = String(describing: data["CheckInEnable"] ?? "")
        self.CheckOutEnable =  String(describing: data["CheckOutEnable"] ?? "")
        self.InTime  = String(describing: data["InTime"] ?? "")
        self.OutTime = String(describing: data["OutTime"] ?? "")
       
   
}

}
