//
//  Visit_CheckListModal.swift
//  iVM360
//
//  Created by 1707 on 31/07/24.
//
import UIKit
class Visit_CheckListModal: Codable {
    
    var MessageID : String
    var AutoID : String
    var ChecklistName : String
    var remarks = ""
    var Message : String
   
    init() {

        self.MessageID = ""
        self.AutoID = ""
        self.ChecklistName = ""
        self.Message = ""
       
        
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.MessageID  = String(describing: data["MessageID"] ?? "")
        self.AutoID = String(describing: data["AutoID"] ?? "")
        self.ChecklistName = String(describing: data["ChecklistName"] ?? "")
        self.Message = String(describing: data["Message"] ?? "")
       
        
   
}

}
