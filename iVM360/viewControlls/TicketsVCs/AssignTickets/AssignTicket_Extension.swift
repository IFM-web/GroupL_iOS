//
//  AssignTicket_Extension.swift
//  iVM360
//
//  Created by 1707 on 07/08/24.
//

import UIKit
extension Assign_TicketsVC {
    func callGetAssignedTicketListService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetAssignedTicketListService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["EmpNo"]      = AppSession.user?.EmpNumber
       
        print(params)
        WebServiceManager.shared.GetAssignedTicketList(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.AssignedTicketListData = data.compactMap({AssignedTicket_Modal(withData: $0)})
                        if self.AssignedTicketListData.first?.Message == "No Ticket Exists !!"{
                            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                            customAlert.delegate = self
                            customAlert.hideBut = true
                            customAlert.logoutBut = false
                            customAlert.onofflineBut = false
                            customAlert.modalPresentationStyle = .overCurrentContext
                            customAlert.providesPresentationContextTransitionStyle = true
                            customAlert.modalTransitionStyle = .crossDissolve
                            customAlert.titlestring = "Alert"
                            customAlert.massage =  self.AssignedTicketListData.first?.Message
                            self.present(customAlert, animated: true, completion: nil)
                            ActivityView.hide(self.view)
                        }else{
                            self.assignTicketListTableView.reloadData()
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
