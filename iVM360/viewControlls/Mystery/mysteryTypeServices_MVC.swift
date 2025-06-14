//
//  mysteryTypeServices_MVC.swift
//  SMCApp
//
//  Created by 1707 on 25/01/24.
//

import Foundation
import UIKit
extension MysteryTypeFormVC{
    func callgetAuditQuestionDetailsService(){
        var params: [String: Any] = [:]
    
            guard Connectivity.isInternetConnected else {
                AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                    guard let `self` = self else {return}
                    self.callgetAuditQuestionDetailsService()
                }
                return
            }
            ActivityView.show(self.view)
//       for MallHKAndTech 12001
        if self.MYsteryTypeID == 12001{
            if self.mysteryCategoryID == "18"{
                params["categoryId"]                  = "19"
            }else if self.mysteryCategoryID == "19"{
                params["categoryId"]                  = "20"
            }else if self.mysteryCategoryID == "20"{
                params["categoryId"]                  = "21"
            }else if self.mysteryCategoryID == "21"{
                params["categoryId"]                  = "22"
            }else if self.mysteryCategoryID == "22"{
                params["categoryId"]                  = "23"
            }else if self.mysteryCategoryID == "23"{
                params["categoryId"]                  = "24"
            }else if self.mysteryCategoryID == "24"{
                params["categoryId"]                  = "25"
            }else if self.mysteryCategoryID == "25"{
                params["categoryId"]                  = "26"
            }else if self.mysteryCategoryID == "26"{
                params["categoryId"]                  = "27"
            }else if self.mysteryCategoryID == "27"{
                params["categoryId"]                  = "28"
            }else if self.mysteryCategoryID == "28"{
                params["categoryId"]                  = "29"
            }else if self.mysteryCategoryID == "29"{
                params["categoryId"]                  = "31"
            }else if self.mysteryCategoryID == "31"{
                params["categoryId"]                  = "32"
            }else if self.mysteryCategoryID == "32"{
                params["categoryId"]                  = "33"
            }else if self.mysteryCategoryID == "33"{
                params["categoryId"]                  = "34"
            }else if self.mysteryCategoryID == "34"{
                params["categoryId"]                  = "35"
            }else{
                params["categoryId"]                  = "18"
            }
//          for  MallHk 12002
        }else if self.MYsteryTypeID == 12002{
            if self.mysteryCategoryID == "18"{
                params["categoryId"]                  = "19"
            }else if self.mysteryCategoryID == "19"{
                params["categoryId"]                  = "20"
            }else if self.mysteryCategoryID == "20"{
                params["categoryId"]                  = "21"
            }else if self.mysteryCategoryID == "21"{
                params["categoryId"]                  = "22"
            }else if self.mysteryCategoryID == "22"{
                params["categoryId"]                  = "23"
            }else if self.mysteryCategoryID == "23"{
                params["categoryId"]                  = "24"
            }else if self.mysteryCategoryID == "24"{
                params["categoryId"]                  = "25"
            }else if self.mysteryCategoryID == "25"{
                params["categoryId"]                  = "26"
            }else if self.mysteryCategoryID == "26"{
                params["categoryId"]                  = "27"
            }else if self.mysteryCategoryID == "27"{
                params["categoryId"]                  = "28"
            }else if self.mysteryCategoryID == "28"{
                params["categoryId"]                  = "29"
            }else if self.mysteryCategoryID == "29"{
                params["categoryId"]                  = "30"
            }else{
                params["categoryId"]                  = "18"
            }
        }
        
            print(params)
        
        
WebServiceManager.shared.getAuditQuestionDetails(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                 ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    print(json)
                    if json["status"] as? Bool == true {
                        if let data = json["data"] as? [[String:Any]],let mainData = data.first{
                            print(data)
                            if let details = mainData["details"] as? [[String:Any]]{
                                self.MysteryquestionDataMVCPattern = details.compactMap({QuestionDetailmodel(withData: $0)})
                                print(self.MysteryquestionDataMVCPattern.count)
                                self.mysteryTitleLbl.text = self.MysteryquestionDataMVCPattern.first?.categoryName
                                self.mysteryFromNumberLbl.text = self.MysteryquestionDataMVCPattern.first?.categoryId
                                self.mysteryCategoryID = self.MysteryquestionDataMVCPattern.first?.categoryId ?? ""
                                self.mysteryTableView.reloadData()
                                ActivityView.hide(self.view)
                            }
                            }
                    
                        }
                    }else{
//                        AlertView.show(message: json["msg"] as? String)
                    
                    }
                   ActivityView.hide(self.view)
            case ServiceConst.Status.bedRequest:
//                   AlertView.show(message: json["msg"] as? String)
                    ActivityView.hide(self.view)
                print("hjghj")
           case ServiceConst.Status.unauthorized:
                   ActivityView.hide(self.view)
                print("hjghj")
//          case ServiceConst.Status.fail:
                    ActivityView.hide(self.view)
//                   AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
//                        guard let `self` = self else {return}
//                        self.callgetAddressListService()
//                print("hjghj")
//                }            default:
                print("hjghj")

        ActivityView.hide(self.view)
            default:
                print("hdjkshfk")
            }
          
            }
       }
    func callcreateMysteryAuditAnswerService(){
        var params: [String: Any] = [:]
    
            guard Connectivity.isInternetConnected else {
                AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                    guard let `self` = self else {return}
                    self.callcreateMysteryAuditAnswerService()
                }
                return
            }
            ActivityView.show(self.view)

        let auditorID = UserDefaultUtility().getuserId()
            params["categoryId"]                  = "\(self.mysteryCategoryID)"
            params["locationId"]                  = self.MysteryLocationIDD
            params["auditorId"]                   = auditorID
            params["auditId"]                     = "\(self.MysteryAuditIDD)"
            params["submitReport"]                 = ""
       
            print(params)
        
        
           WebServiceManager.shared.createMysteryAuditAnswer(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                 ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    print(json)
                    if json["status"] as? Bool == true {
                        if let data = json["data"] as? [[String:Any]]{
                            print(data)
                            self.callupdateMysteryAuditStatusService()
                            ActivityView.hide(self.view)
                            
                            }
                    
                        }
                    }else{
//                        AlertView.show(message: json["msg"] as? String)
                    
                    }
                   ActivityView.hide(self.view)
            case ServiceConst.Status.bedRequest:
//                   AlertView.show(message: json["msg"] as? String)
                    ActivityView.hide(self.view)
                print("hjghj")
           case ServiceConst.Status.unauthorized:
                   ActivityView.hide(self.view)
                print("hjghj")
//          case ServiceConst.Status.fail:
                    ActivityView.hide(self.view)
//                   AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
//                        guard let `self` = self else {return}
//                        self.callgetAddressListService()
//                print("hjghj")
//                }            default:
                print("hjghj")

        ActivityView.hide(self.view)
            default:
                print("hdjkshfk")
            }
          
            }
       }
    func callupdateMysteryAuditStatusService(){
        var params: [String: Any] = [:]
            guard Connectivity.isInternetConnected else {
                AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                    guard let `self` = self else {return}
                    self.callupdateMysteryAuditStatusService()
                }
                return
            }
            ActivityView.show(self.view)
            params["typeId"]                  = "9002"
            params["auditId"]                     = "\(self.MysteryAuditIDD)"
            print(params)
        
           WebServiceManager.shared.updateMysteryAuditStatus(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                 ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    print(json)
                    if json["status"] as? Bool == true {
                        if let data = json["data"] as? [[String:Any]]{
                            print(data)
                            
                        let statusrequest = QuestionStatusRequest(locationId: "\(self.MysteryLocationIDD)", auditId: "\(self.MysteryAuditIDD)")
                        print(statusrequest)
                        self.MysteryquestionStatusData.QStatus(Requests: statusrequest)
                            ActivityView.hide(self.view)
                            }
                    
                        }
                    }else{
//                        AlertView.show(message: json["msg"] as? String)
                    
                    }
                   ActivityView.hide(self.view)
            case ServiceConst.Status.bedRequest:
//                   AlertView.show(message: json["msg"] as? String)
                    ActivityView.hide(self.view)
                print("hjghj")
           case ServiceConst.Status.unauthorized:
                   ActivityView.hide(self.view)
                print("hjghj")
//          case ServiceConst.Status.fail:
                    ActivityView.hide(self.view)
//                   AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
//                        guard let `self` = self else {return}
//                        self.callgetAddressListService()
//                print("hjghj")
//                }            default:
                print("hjghj")

        ActivityView.hide(self.view)
            default:
                print("hdjkshfk")
            }
          
            }
       }
}
