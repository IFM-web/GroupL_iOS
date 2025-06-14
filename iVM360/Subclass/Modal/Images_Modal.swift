//
//  Images_Modal.swift
//  iVM360
//
//  Created by 1707 on 01/08/24.
//



import UIKit
class Images_Modal: Codable {
    
   
    var ImageBase64String : String
    var VisitImage : String
   
    init() {

       
        self.ImageBase64String = ""
        self.VisitImage = ""
       
        
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        
        self.ImageBase64String = String(describing: data["ImageBase64String"] ?? "")
        self.VisitImage = String(describing: data["VisitImage"] ?? "")
       
        
   
}

}
