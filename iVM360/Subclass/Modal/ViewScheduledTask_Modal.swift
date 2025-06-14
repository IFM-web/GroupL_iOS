//
//  ViewScheduledTask_Modal.swift
//  iVM360
//
//  Created by 1707 on 05/08/24.
//

import UIKit
class ViewScheduledTask_Modal: Codable {
    
    var ClientCode : String
    var ChecklistName : String
    var ChecklistID : String
    var ClientCodeName : String
    var AsmtID : String
    var ScheduleDate : String
   
    init() {

        self.ClientCode = ""
        self.ChecklistName = ""
        self.ChecklistID = ""
        self.ClientCodeName = ""
        self.AsmtID = ""
        self.ScheduleDate = ""
       
        
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.ClientCode  = String(describing: data["ClientCode"] ?? "")
        self.ChecklistName = String(describing: data["ChecklistName"] ?? "")
        self.ChecklistID = String(describing: data["ChecklistID"] ?? "")
        self.ClientCodeName = String(describing: data["ClientCodeName"] ?? "")
        self.AsmtID = String(describing: data["AsmtID"] ?? "")
        self.ScheduleDate = String(describing: data["ScheduleDate"] ?? "")
        
   
}

}
