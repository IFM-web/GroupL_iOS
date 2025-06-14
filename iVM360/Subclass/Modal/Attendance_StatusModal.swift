//
//  Attendance_StatusModal.swift
//  iVM360
//
//  Created by 1707 on 04/09/24.
//

    import UIKit
    class Attendance_StatusModal: Codable {
        
        var Date : String
        var SiteName : String
        var Shift : String
        var CheckInTime : String
        var CheckoutTime : String
        var Remarks : String
        var ApprovalStatus : String
        
        init() {

            self.Date = ""
            self.SiteName = ""
            self.Shift = ""
            self.CheckInTime = ""
            self.CheckoutTime = ""
            self.Remarks = ""
            self.ApprovalStatus = ""
           
        
        }
        convenience init(withData data:[String:Any]) {
         self.init()
            
            self.Date  = String(describing: data["Date"] ?? "")
            self.SiteName = String(describing: data["SiteName"] ?? "")
            self.Shift = String(describing: data["Shift"] ?? "")
            self.CheckInTime = String(describing: data["CheckInTime"] ?? "")
            self.CheckoutTime  = String(describing: data["CheckoutTime"] ?? "")
            self.Remarks = String(describing: data["Remarks"] ?? "")
            self.ApprovalStatus  = String(describing: data["ApprovalStatus"] ?? "")
            
       
    }

    }
