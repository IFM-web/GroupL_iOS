//
//  Ticket_CategoryModal.swift
//  iVM360
//
//  Created by 1707 on 06/08/24.
//

import UIKit

class Ticket_CategoryModal: Codable {
    
    var TicketCategory : String
   
    init() {

        self.TicketCategory = ""

    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.TicketCategory  = String(describing: data["TicketCategory"] ?? "")

}

}
