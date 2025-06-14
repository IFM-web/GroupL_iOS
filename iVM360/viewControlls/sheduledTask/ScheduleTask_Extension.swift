//
//  ScheduleTask_Extension.swift
//  iVM360
//
//  Created by 1707 on 05/08/24.
//

import Foundation
import UIKit
extension sheduledTask_VC{
    @available(iOS 13.0, *)
    func callGetGeoMappedSitesSmartFMService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetGeoMappedSitesSmartFMService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
//        params["latitude"]  = "28.612141"
//        params["longitude"] = "77.387749"
        if let location         = LocationManager.shared.currentLocation {
            params["latitude"]  = location.coordinate.latitude.string
            params["longitude"] = location.coordinate.longitude.string
        }
       
        print(params)
        WebServiceManager.shared.GetGeoMappedSitesSmartFM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.ScheduledSiteData = data.compactMap({Sites_VisitModal(withData: $0)})
                        self.ScheduledSitesNameList.removeAll()
                        for VisitSitelists in self.ScheduledSiteData{
                            self.ScheduledSitesNameList.append(VisitSitelists.SiteName)
                        }
                        self.dropDownScheduledSite.dataSource = self.ScheduledSitesNameList

                       
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
    
    func callViewTodayScheduledWorkService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callViewTodayScheduledWorkService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["empID"]      = AppSession.user?.EmpNumber
       
        print(params)
        WebServiceManager.shared.ViewTodayScheduledWork(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.ViewScheduledTaskData = data.compactMap({ViewScheduledTask_Modal(withData: $0)})
                               self.loactionNsmeTableView.reloadData()
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
