//
//  SitePostCheckinModal.swift
//  iVM360
//
//  Created by 1707 on 23/07/24.
//

import UIKit

class SitePostCheckinModal: Codable {
    
    var PostAutoId : String
    var PostDesc : String
    
   
    init() {

        self.PostAutoId = ""
        self.PostDesc = ""
        
        
    
    }
    convenience init(withData data:[String:Any]) {
     self.init()
        
        self.PostAutoId  = String(describing: data["PostAutoId"] ?? "")
        self.PostDesc = String(describing: data["PostDesc"] ?? "")
      
        
   
}

}

