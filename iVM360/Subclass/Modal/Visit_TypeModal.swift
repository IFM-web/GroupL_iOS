//
//  Visit_TypeModal.swift
//  iVM360
//
//  Created by 1707 on 31/07/24.
//

import UIKit

class Visit_TypeModal: Codable {
    
    var AutoID : String
    var Designation : String
    var ChecklistHeader : String
   
    init() {

        self.AutoID = ""
        self.Designation = ""
        self.ChecklistHeader = ""
       
        
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.AutoID  = String(describing: data["AutoID"] ?? "")
        self.Designation = String(describing: data["Designation"] ?? "")
        self.ChecklistHeader = String(describing: data["ChecklistHeader"] ?? "")
       
        
   
}

}
