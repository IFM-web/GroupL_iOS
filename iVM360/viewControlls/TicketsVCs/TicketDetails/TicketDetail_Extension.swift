//
//  TicketDetail_Extension.swift
//  iVM360
//
//  Created by 1707 on 07/08/24.
//

import UIKit
extension Ticket_DetailsVC {
    func callGetTicketDetailsService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetTicketDetailsService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["TicketNo"]      = self.TicketNumberFromBack
       
        print(params)
        WebServiceManager.shared.GetTicketDetails(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.TicketDetailsData = data.compactMap({TicketDetails_modal(withData: $0)})
                        for TicketDetails in self.TicketDetailsData{
                            self.clientNameLbl.text = TicketDetails.ClientName
                            self.siteNameLbl.text = TicketDetails.SiteName
                            self.ticketNumberLbl.text = TicketDetails.TicketNo
                            self.ticketCategoryLbl.text = TicketDetails.TicketCategory
                            self.ticketTypeNameLbl.text = TicketDetails.TicketType
                            self.ticketPriorityLbl.text = TicketDetails.TicketPriority
                            self.ticketDiscriptionLbl.text = TicketDetails.TicketDescription
                            self.ticketAssignmentDateLbl.text = TicketDetails.TicketAssignmentDate
                            self.ImageString_base64 = TicketDetails.ImageBase64String
                        }
                        if let imageData = Data(base64Encoded: self.ImageString_base64) {
                            if let image = UIImage(data: imageData) {
                                let imageView = UIImageView(image: image)
                                self.openTicketImageView.image = image
                            } else {
                                print("Failed to create UIImage from data")
                            }
                        }
                                } else {
                                    print("Data parsing error")
                                }
                }
                ActivityView.hide(self.view)
            case ServiceConst.Status.unauthorized:
               // AlertView.show(message: json["Message"] as? String)
                ActivityView.hide(self.view)
            default:
                let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                customAlert.delegate = self
                customAlert.hideBut = true
                customAlert.logoutBut = false
                customAlert.onofflineBut = false
                customAlert.modalPresentationStyle = .overCurrentContext
                customAlert.providesPresentationContextTransitionStyle = true
                customAlert.modalTransitionStyle = .crossDissolve
                customAlert.titlestring = "Alert"
               // customAlert.massage = json["message"] as? String
                self.present(customAlert, animated: true, completion: nil)
                ActivityView.hide(self.view)
            }
        }
    }
}
