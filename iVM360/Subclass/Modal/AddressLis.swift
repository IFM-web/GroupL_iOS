//
//  AddressLis.swift
//  DexgoHousekeeping
//
//  Created by Apple on 27/08/22.
//

import UIKit

class sitesList: Codable {
    
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
             
 
