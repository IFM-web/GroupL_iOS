//
//  TicketDetails_modal.swift
//  iVM360
//
//  Created by 1707 on 07/08/24.
//

import UIKit
class TicketDetails_modal: Codable {
 
    var ClientName : String
    var SiteName : String
    var TicketNo : String
    var TicketType : String
    var TicketCategory : String
    var TicketDescription : String
    var TicketPriority : String
    var TicketAssignmentDate : String
    var TicketImage : String
    var ImageBase64String : String

   
    init() {

        self.ClientName = ""
        self.SiteName = ""
        self.TicketNo = ""
        self.TicketType = ""
        self.TicketCategory = ""
        
        self.TicketDescription = ""
        self.TicketPriority = ""
        self.TicketAssignmentDate = ""
        self.TicketImage = ""
        self.ImageBase64String = ""

    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.ClientName  = String(describing: data["ClientName"] ?? "")
        self.SiteName = String(describing: data["SiteName"] ?? "")
        self.TicketNo = String(describing: data["TicketNo"] ?? "")
        self.TicketType = String(describing: data["TicketType"] ?? "")
        self.TicketCategory = String(describing: data["TicketCategory"] ?? "")
        self.TicketDescription  = String(describing: data["TicketDescription"] ?? "")
        self.TicketPriority = String(describing: data["TicketPriority"] ?? "")
        self.TicketAssignmentDate = String(describing: data["TicketAssignmentDate"] ?? "")
        self.TicketImage = String(describing: data["TicketImage"] ?? "")
        self.ImageBase64String = String(describing: data["ImageBase64String"] ?? "")

}

}

