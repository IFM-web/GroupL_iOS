//
//  genrrate_Ticket_Modal.swift
//  iVM360
//
//  Created by 1707 on 09/08/24.
//

import UIKit
class genrrate_Ticket_Modal: Codable {
    var TicketID : String
    var MessageID : String
    init() {

        self.TicketID = ""
        self.MessageID = ""

    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.TicketID  = String(describing: data["TicketID"] ?? "")
        self.MessageID  = String(describing: data["MessageID"] ?? "")
}

}
