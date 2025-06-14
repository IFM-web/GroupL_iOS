//
//  shift_deatils.swift
//  iVM360
//
//  Created by Mac on 15/05/25.
//

import UIKit

class shift_deatils: Codable {
    var MessageID : String
    var ShiftCode : String
    var ShiftDetails : String
   
    init() {
   
        self.MessageID = ""
        self.ShiftCode = ""
        self.ShiftDetails = ""
        
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        self.MessageID = String(describing: data["MessageID"] ?? "")
        self.ShiftCode = String(describing: data["ShiftCode"] ?? "")
        self.ShiftDetails = String(describing: data["ShiftDetails"] ?? "")
        
   
}

}
