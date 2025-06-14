//
//  SitesList.swift
//  iVM360
//
//  Created by 1707 on 22/07/24.
//

import UIKit

class SitesList: Codable {
    
    var AsmtId : String
    var ClientCode : String
    var ClientSiteName : String
    var MessageID : String
   
    init() {

        self.AsmtId = ""
        self.ClientCode = ""
        self.ClientSiteName = ""
        self.MessageID = ""
        
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.AsmtId  = String(describing: data["AsmtId"] ?? "")
        self.ClientCode = String(describing: data["ClientCode"] ?? "")
        self.ClientSiteName = String(describing: data["ClientSiteName"] ?? "")
        self.MessageID = String(describing: data["MessageID"] ?? "")
        
   
}

}
