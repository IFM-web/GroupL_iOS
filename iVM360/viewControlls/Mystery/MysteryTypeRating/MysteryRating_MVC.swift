//
//  MysteryRating_MVC.swift
//  SMCApp
//
//  Created by 1707 on 31/01/24.
//

import Foundation
import UIKit
extension MysteryRatingVC{
    func callgetAuditQuestionDetailsService(){
        var params: [String: Any] = [:]
    
            guard Connectivity.isInternetConnected else {
                AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                    guard let `self` = self else {return}
                    self.callgetAuditQuestionDetailsService()
                }
                return
            }
//            ActivityView.show(self.view)
        if self.MYsteryRatingTypeID == 12001{
                params["categoryId"]                  = "35"
            
        }else if self.MYsteryRatingTypeID == 12002 {
            params["categoryId"]                      = "30"
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
                                self.MysteryRatingquestionDataMVCPattern = details.compactMap({QuestionDetailmodel(withData: $0)})
                                print(self.MysteryRatingquestionDataMVCPattern.count)
                                self.mysteryRatingscreenTitleLbl.text = self.MysteryRatingquestionDataMVCPattern.first?.categoryName
                                self.MYRatingcategoryIDd = self.MysteryRatingquestionDataMVCPattern.first?.categoryId ?? ""
                                self.mysteryRatingfacilityTableView.reloadData()
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
}
