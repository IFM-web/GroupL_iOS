//
//  Complaintlist_Modal.swift
//  DexgoHousekeeping
//
//  Created by 1707 on 03/11/24.
//

import UIKit
class Complaintlist_Modal: Codable {

   
    var complainDate: String
       var submittedFeedbackId: Int
       var feedbackTypeId: Int
       var serviceTypeId: Int
       var complainRemark: String
       var hospitalId: Int
       var addressName: String
       var complainImages: [String]
       var jobStatus: Int
       var jobDid: String
       var jobStatusText: String
       var serviceTypeText: String
       var resolvedRemark: String
       var resolvedImages: [String]
       var resolvedDate: String

     

    init() {
           self.complainDate = ""
               self.submittedFeedbackId = 0
               self.feedbackTypeId = 0
               self.serviceTypeId = 0
               self.complainRemark = ""
               self.hospitalId = 0
               self.addressName = ""
               self.complainImages = []
               self.jobStatus = 0
               self.jobDid = ""
               self.jobStatusText = ""
               self.serviceTypeText = ""
               self.resolvedRemark = ""
               self.resolvedImages = []
               self.resolvedDate = ""
     
      
    }
    convenience init(withData data:[String:Any]){
        self.init()
                self.complainDate = data["complainDate"] as? String ?? ""
                self.submittedFeedbackId = data["submittedFeedbackId"] as? Int ?? 0
                self.feedbackTypeId = data["feedbackTypeId"] as? Int ?? 0
                self.serviceTypeId = data["serviceTypeId"] as? Int ?? 0
                self.complainRemark = data["complainRemark"] as? String ?? ""
                self.hospitalId = data["hospitalId"] as? Int ?? 0
                self.addressName = data["addressName"] as? String ?? ""
                self.complainImages = data["complainImages"] as? [String] ?? []
                self.jobStatus = data["jobStatus"] as? Int ?? 0
                self.jobDid = data["jobDid"] as? String ?? ""
                self.jobStatusText = data["jobStatusText"] as? String ?? ""
                self.serviceTypeText = data["serviceTypeText"] as? String ?? ""
                self.resolvedRemark = data["resolvedRemark"] as? String ?? ""
                self.resolvedImages = data["resolvedImages"] as? [String] ?? []
                self.resolvedDate = data["resolvedDate"] as? String ?? ""
    }
}
