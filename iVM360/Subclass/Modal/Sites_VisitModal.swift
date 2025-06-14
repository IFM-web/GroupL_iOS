//
//  Sites_VisitModal.swift
//  iVM360
//
//  Created by 1707 on 31/07/24.
//


     
import UIKit

class Sites_VisitModal: Codable {
    
    var AsmtId : String
    var ClientCode : String
    var SiteName : String
    var MessageID : String
    var LocationAutoID : String
    var CompanyCode : String
    var MessageString : String
    init() {

        self.AsmtId = ""
        self.ClientCode = ""
        self.SiteName = ""
        self.MessageID = ""
        self.LocationAutoID = ""
        self.CompanyCode = ""
        self.MessageString = ""
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.AsmtId  = String(describing: data["AsmtId"] ?? "")
        self.ClientCode = String(describing: data["ClientCode"] ?? "")
        self.SiteName = String(describing: data["SiteName"] ?? "")
        self.MessageID = String(describing: data["MessageID"] ?? "")
        self.LocationAutoID  = String(describing: data["LocationAutoID"] ?? "")
        self.CompanyCode  = String(describing: data["CompanyCode"] ?? "")
        self.MessageString  = String(describing: data["MessageString"] ?? "")
        
   
}

}
