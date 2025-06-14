//
//  Create_View_Ticket_Extension.swift
//  iVM360
//
//  Created by 1707 on 06/08/24.
//


import UIKit
extension create_ViewTickets_VC{
    @available(iOS 13.0, *)
    func callGetTicketTypeService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetTicketTypeService()
            }
            return
        }

        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
       
        print(params)
        WebServiceManager.shared.GetTicketType(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.TicketTypeData = data.compactMap({Ticket_TypeModa(withData: $0)})
                        self.TicketTypeNameList.removeAll()
                        for VisitSitelists in self.TicketTypeData{
                            self.TicketTypeNameList.append(VisitSitelists.TicketType)
                        }
                        self.dropDown_TicketType.dataSource = self.TicketTypeNameList

                       
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

    func callGetTicketCategoryService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetTicketCategoryService()
            }
            return
        }
        ActivityView.show(self.view)
        params["TicketType"]               =  self.TicketTypeName
        params["connectionKey"]             = "SAMS"
        print(params)
        WebServiceManager.shared.GetTicketCategory(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.TicektCategoryData = data.compactMap({Ticket_CategoryModal(withData: $0)})
                        self.TicketCategoryNameList.removeAll()
                        for VisitType in self.TicektCategoryData{
                            self.TicketCategoryNameList.append(VisitType.TicketCategory)
                        }
                       
                        self.dropDown_TicketCategory.dataSource = self.TicketCategoryNameList
                     
//                        if self.SavedemployeeNumber == AppSession.user?.EmpNumber{
//                            if self.savedClintcode.isEmpty == false && self.savedAsmtId.isEmpty == false{
//                                self.siteBtn.setTitle(self.savedSiteName, for: .normal)
//                                self.siteBtn.isEnabled = false
//                                self.callGetEmployeeAttendanceDailyWithShiftService()
//                            }else{
//                                self.siteBtn.isEnabled = true
//                                self.dropDown.dataSource = self.siteNamelist
//                            }
//                        }else{
//                            self.siteBtn.isEnabled = true
//                            self.dropDown.dataSource = self.siteNamelist
//                           print(self.siteNamelist)
//
//                        }
                       
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
