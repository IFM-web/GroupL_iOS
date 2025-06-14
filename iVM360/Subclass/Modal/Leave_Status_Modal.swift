//
//  Leave_Status_Modal.swift
//  iVM360
//
//  Created by 1707 on 03/09/24.
//

import UIKit
class Leave_Status_Modal: Codable {
    
    var LeaveType : String
    var FromDate : String
    var ApplyDate : String
    var LeaveStatus : String
    var AutoId : String
    
    init() {

        self.LeaveType = ""
        self.FromDate = ""
        self.ApplyDate = ""
        self.LeaveStatus = ""
        self.AutoId = ""
       
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.LeaveType  = String(describing: data["LeaveType"] ?? "")
        self.FromDate = String(describing: data["FromDate"] ?? "")
        self.ApplyDate = String(describing: data["ApplyDate"] ?? "")
        self.LeaveStatus = String(describing: data["LeaveStatus"] ?? "")
        self.AutoId  = String(describing: data["AutoId"] ?? "")
        
   
}

}
