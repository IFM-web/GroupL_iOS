//
//  Ticket_TypeModa.swift
//  iVM360
//
//  Created by 1707 on 06/08/24.
//

import UIKit

class Ticket_TypeModa: Codable {
    
    var TicketType : String
    
   
    init() {

        self.TicketType = ""

    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.TicketType  = String(describing: data["TicketType"] ?? "")

}

}
