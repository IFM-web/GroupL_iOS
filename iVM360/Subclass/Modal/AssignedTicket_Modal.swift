//
//  AssignedTicket_Modal.swift
//  iVM360
//
//  Created by 1707 on 07/08/24.
//
import UIKit
class AssignedTicket_Modal: Codable {
    
    var ClientName : String
    var SiteName : String
    var TicketNo : String
    var TicketType : String
    var TicketCategory : String
    var Message : String
  

   
    init() {

        self.ClientName = ""
        self.SiteName = ""
        self.TicketNo = ""
        self.TicketType = ""
        self.TicketCategory = ""
        self.Message = ""
       
       
        
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.ClientName  = String(describing: data["ClientName"] ?? "")
        self.SiteName = String(describing: data["SiteName"] ?? "")
        self.TicketNo = String(describing: data["TicketNo"] ?? "")
        self.TicketType = String(describing: data["TicketType"] ?? "")
        self.TicketCategory = String(describing: data["TicketCategory"] ?? "")
        self.Message = String(describing: data["Message"] ?? "")
     
        
   
}

}
