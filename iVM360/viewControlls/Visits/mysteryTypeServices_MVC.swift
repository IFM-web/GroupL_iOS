//
//  mysteryTypeServices_MVC.swift
//  SMCApp
//
//  Created by 1707 on 25/01/24.
//

import Foundation
import UIKit
extension MysteryTypeFormVC{
    @available(iOS 13.0, *)
    func callGetVisitChecklistSmartFMIOSService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetVisitChecklistSmartFMIOSService()
            }
            return
        }
      
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["ClientCode"]      = self.clintCodeFromBack
        params["Designation"]  = AppSession.user?.Designation
        params["VisitType"] = self.siteTypeNameFromBack
       
        print(params)
        WebServiceManager.shared.GetVisitChecklistSmartFMIOS(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.VisitCheckListNameData = data.compactMap({Visit_CheckListModal(withData: $0)})
                      if self.VisitCheckListNameData.first?.Message == ""{
                            self.mysteryTableView.reloadData()
                        }else{
                            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                            customAlert.delegate = self
                            customAlert.hideBut = true
                            customAlert.logoutBut = false
                            customAlert.onofflineBut = false
                            customAlert.modalPresentationStyle = .overCurrentContext
                            customAlert.providesPresentationContextTransitionStyle = true
                            customAlert.modalTransitionStyle = .crossDissolve
                            customAlert.titlestring = "Alert"
                            customAlert.massage = self.VisitCheckListNameData.first?.Message
                            self.present(customAlert, animated: true, completion: nil)
                            ActivityView.hide(self.view)
                        }
                      
                       
                                } else {
                                    print("Data parsing error")
                                }
                }else{
                    
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
    
    func callInsertVisitChecklistSmartFMJsonService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callInsertVisitChecklistSmartFMJsonService()
            }
            return
        }
      
        ActivityView.show(self.view)
    

        params["connectionKey"]  = "SAMS"
        params["Json"]           = self.CheckListJson.toJSONString
        
      //  let data = params.toJSONString
        WebServiceManager.shared.InsertVisitChecklistSmartFMJson(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        
                        self.visitJsonMsg = mainData["Message"] as? String ?? ""
                        self.visitsuccess = true
                        let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                        customAlert.delegate = self
                        customAlert.hideBut = true
                        customAlert.logoutBut = false
                        customAlert.onofflineBut = false
                        customAlert.modalPresentationStyle = .overCurrentContext
                        customAlert.providesPresentationContextTransitionStyle = true
                        customAlert.modalTransitionStyle = .crossDissolve
                        customAlert.titlestring = "Alert"
                        customAlert.massage = self.visitJsonMsg
                        self.present(customAlert, animated: true, completion: nil)
                        ActivityView.hide(self.view)
                       
                                } else {
                                    print("Data parsing error")
                                }
                }else{
                    print("ok")
                    ActivityView.hide(self.view)
//                    let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
//                    customAlert.delegate = self
//                    customAlert.hideBut = true
//                    customAlert.logoutBut = false
//                    customAlert.onofflineBut = false
//                    customAlert.modalPresentationStyle = .overCurrentContext
//                    customAlert.providesPresentationContextTransitionStyle = true
//                    customAlert.modalTransitionStyle = .crossDissolve
//                    customAlert.titlestring = "Alert"
//                    customAlert.massage = "Checklist Submitted Successfully !!"
//                    self.present(customAlert, animated: true, completion: nil)
//                    ActivityView.hide(self.view)
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
    func callInsertScheduledWorkChecklistSmartFMJsonService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callInsertScheduledWorkChecklistSmartFMJsonService()
            }
            return
        }
      
        ActivityView.show(self.view)
    

        
        params["connectionKey"]  = "SAMS"
        params["Json"]           = self.ScheduleWorkJson.toJSONString
      //  let data = params.toJSONString
        WebServiceManager.shared.InsertScheduledWorkChecklistSmartFMJson(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.scheduleworkJsonMsg = mainData["Message"] as? String ?? ""
                        self.scheduleworksuccess = true
                        let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                        customAlert.delegate = self
                        customAlert.hideBut = true
                        customAlert.logoutBut = false
                        customAlert.onofflineBut = false
                        customAlert.modalPresentationStyle = .overCurrentContext
                        customAlert.providesPresentationContextTransitionStyle = true
                        customAlert.modalTransitionStyle = .crossDissolve
                        customAlert.titlestring = "Alert"
                        customAlert.massage =  self.scheduleworkJsonMsg
                        self.present(customAlert, animated: true, completion: nil)
                        ActivityView.hide(self.view)
                        
//                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ClientDetaisVC") as? ClientDetaisVC
//                        vc?.isScheduleWorkShow = self.isScheduleWorkmatched
//                        
//                                self.navigationController?.pushViewController(vc!, animated: true)
                       
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
    
    
    func callGetScheduledWorkChecklistSmartFMService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetScheduledWorkChecklistSmartFMService()
            }
            return
        }
      
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["ClientCode"]      = self.clintCodeFromBack
        params["ChecklistID"]  = self.checklistIDFromBack
       
        print(params)
        WebServiceManager.shared.GetScheduledWorkChecklistSmartFM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.VisitCheckListNameData = data.compactMap({Visit_CheckListModal(withData: $0)})
                        self.mysteryTableView.reloadData()
                       
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
