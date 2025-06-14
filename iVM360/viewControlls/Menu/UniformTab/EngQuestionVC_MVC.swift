//
//  EngQuestionVC_MVC.swift
//  SMCApp
//
//  Created by 1707 on 16/01/24.
//

import Foundation
import UIKit
extension EngineeringAuditVC{
    func callGetEmpUniformDetailsService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetEmpUniformDetailsService()
            }
            return
        }
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
        params["EmpID"]  = AppSession.user?.EmpNumber
           
       
        print(params)
        WebServiceManager.shared.GetEmpUniformDetails(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.UniformDetails_Data = data.compactMap({UniformItemModal(withData: $0)})
                        self.engAuditTableView.reloadData()
                       

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
    
    func callUpdateEmpUniformStatusService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callUpdateEmpUniformStatusService()
            }
            return
        }
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
        params["EmpID"]  = AppSession.user?.EmpNumber
        params["EmpBase64"]  = ""
        params["ItemName"]  = ""
           
        
        
        print(params)
        WebServiceManager.shared.UpdateEmpUniformStatus(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        
                       

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
    
   
//    func callgetAuditQuestionDetailsService(){
//        var params: [String: Any] = [:]
//    
//            guard Connectivity.isInternetConnected else {
//                AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
//                    guard let `self` = self else {return}
//                    self.callgetAuditQuestionDetailsService()
//                }
//                return
//            }
//            ActivityView.show(self.view)
//        if self.categoryIDD == "12"{
//            params["categoryId"]                  = "13"
//        }else if self.categoryIDD == "13"{
//            params["categoryId"]                  = "14"
//        }else if self.categoryIDD == "14"{
//            params["categoryId"]                  = "15"
//        }else if self.categoryIDD == "15"{
//            params["categoryId"]                  = "16"
//        }else if self.categoryIDD == "16"{
//            params["categoryId"]                  = "17"
//        }else{
//            params["categoryId"]                  = "12"
//        }
//            print(params)
//        
//        
//WebServiceManager.shared.getAuditQuestionDetails(params) { (status, json) in
//            switch status {
//            case ServiceConst.Status.success,
//                 ServiceConst.Status.internalServerError:
//                if json.isEmpty == false {
//                    print(json)
//                    if json["status"] as? Bool == true {
//                        if let data = json["data"] as? [[String:Any]],let mainData = data.first{
//                            print(data)
//                            if let details = mainData["details"] as? [[String:Any]]{
//                                self.questionDataMVCPattern = details.compactMap({QuestionDetailmodel(withData: $0)})
//                                print(self.questionDataMVCPattern.count)
//                                self.typeTitleLbl.text = self.questionDataMVCPattern.first?.categoryName
//                                self.fromNumberLbl.text = self.questionDataMVCPattern.first?.categoryId
//                                self.categoryIDD =  self.questionDataMVCPattern.first?.categoryId ?? ""
//                                self.totalFromNumberLbl.text = "17"
//                                self.engAuditTableView.reloadData()
//                                ActivityView.hide(self.view)
//                            }
//                            }
//                    
//                        }
//                    }else{
////                        AlertView.show(message: json["msg"] as? String)
//                    
//                    }
//                   ActivityView.hide(self.view)
//            case ServiceConst.Status.bedRequest:
////                   AlertView.show(message: json["msg"] as? String)
//                    ActivityView.hide(self.view)
//                print("hjghj")
//           case ServiceConst.Status.unauthorized:
//                   ActivityView.hide(self.view)
//                print("hjghj")
////          case ServiceConst.Status.fail:
//                    ActivityView.hide(self.view)
////                   AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
////                        guard let `self` = self else {return}
////                        self.callgetAddressListService()
////                print("hjghj")
////                }            default:
//                print("hjghj")
//
//        ActivityView.hide(self.view)
//            default:
//                print("hdjkshfk")
//            }
//          
//            }
//       }
//    
//    func callcreateAuditAnswerService(){
//        var params: [String: Any] = [:]
//    
//            guard Connectivity.isInternetConnected else {
//                AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
//                    guard let `self` = self else {return}
//                    self.callcreateAuditAnswerService()
//                }
//                return
//            }
//            ActivityView.show(self.view)
//
//        let auditorID = UserDefaultUtility().getuserId()
//            params["categoryId"]                  = "\(self.categoryIDD)"
//            params["locationId"]                      = self.locationIDDD
//            params["auditorId"]                   = auditorID
//            params["auditId"]                     = "\(self.auditIDDD)"
////            params["image"]                       = ""
////            params["submitReport"]                 = alljson
//        let sumitData = self.alljson
//        do {
//            // Convert the studentData array to JSON data
//            let jsonData = try JSONSerialization.data(withJSONObject: sumitData, options: .prettyPrinted)
//            
//            // Convert the JSON data to a string
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                params["submitReport"] = jsonString
//            }
//        } catch {
//            print("Error converting to JSON: \(error)")
//        }
//       
//            print(params)
//        
//        
//WebServiceManager.shared.createAuditAnswer(params) { (status, json) in
//            switch status {
//            case ServiceConst.Status.success,
//                 ServiceConst.Status.internalServerError:
//                if json.isEmpty == false {
//                    print(json)
//                    if json["status"] as? Bool == true {
//                        if let data = json["data"] as? [[String:Any]]{
//                            print(data)
//                            let statusrequest = QuestionStatusRequest(locationId: "\(self.locationIDDD)", auditId: "\(self.auditIDDD)")
//                            print(statusrequest)
//                            self.engquestionStatusData.QStatus(Requests: statusrequest)
//                         
//                            if self.categoryIDD == "17"{
//                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReportVC") as? ReportVC
//                                vc?.locationIDfromBack = self.locationIDDD
//                                vc?.auditIDfromBack = self.auditIDDD
//                                vc?.categoryIDfromBack = self.categoryIDD
//                                    self.navigationController?.pushViewController(vc!, animated: true)
//                                }else{
//                                    self.callgetAuditQuestionDetailsService()
//                                }
//                            ActivityView.hide(self.view)
//                            }
//                    
//                        }
//                    }else{
////                        AlertView.show(message: json["msg"] as? String)
//                    
//                    }
//                   ActivityView.hide(self.view)
//            case ServiceConst.Status.bedRequest:
////                   AlertView.show(message: json["msg"] as? String)
//                    ActivityView.hide(self.view)
//                print("hjghj")
//           case ServiceConst.Status.unauthorized:
//                   ActivityView.hide(self.view)
//                print("hjghj")
////          case ServiceConst.Status.fail:
//                    ActivityView.hide(self.view)
////                   AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
////                        guard let `self` = self else {return}
////                        self.callgetAddressListService()
////                print("hjghj")
////                }            default:
//                print("hjghj")
//
//        ActivityView.hide(self.view)
//            default:
//                print("hdjkshfk")
//            }
//          
//            }
//       }
}
