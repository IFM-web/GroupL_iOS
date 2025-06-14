//
//  IFMSerices.swift
//  iVM360
//
//  Created by 1707 on 31/07/24.
//

import Foundation
import UIKit
extension IFMVC{
    
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
                        self.visitSiteData = data.compactMap({Sites_VisitModal(withData: $0)})
                        self.visitSitesNameList.removeAll()
                        for VisitSitelists in self.visitSiteData{
                            self.visitSitesNameList.append(VisitSitelists.SiteName)
                            self.ClientCodeFromVisitSiteArray.append(VisitSitelists.ClientCode)
                            self.AsmtIdfromSiteArray.append(VisitSitelists.AsmtId)
                            self.CompanyCodefromSiteArray.append(VisitSitelists.CompanyCode)
                            self.LocationAutoIdfromSiteArray.append(VisitSitelists.LocationAutoID)
                         
                        }
                        self.dropDownIFMSite.dataSource = self.visitSitesNameList
                        self.fmsiteBtn.setTitle(self.visitSitesNameList[0], for: .normal)
                        self.AsmtIdfromSite = self.AsmtIdfromSiteArray[0]
                        self.CompanyCodefromSite = self.CompanyCodefromSiteArray[0]
                        self.LocationAutoIdfromSite = self.LocationAutoIdfromSiteArray[0]
                        self.siteNameFromGeoSite = self.visitSitesNameList[0]
                        self.ClientCodeFromVisitSite = self.ClientCodeFromVisitSiteArray[0]
                        self.callGetVisitTypeSmartFMService()
                        self.isSiteSelection = true
                      

                       
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

    func callGetVisitTypeSmartFMService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetVisitTypeSmartFMService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["Designation"]              = AppSession.user?.Designation
        params["ClientCode"]               = self.ClientCodeFromVisitSite
        params["connectionKey"]  = "SAMS"
        print(params)
        WebServiceManager.shared.GetVisitTypeSmartFM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.visitsTypeData = data.compactMap({Visit_TypeModal(withData: $0)})
                        self.VisitTypeNameList.removeAll()
                        for VisitType in self.visitsTypeData{
                            self.VisitTypeNameList.append(VisitType.ChecklistHeader)
                            self.autoIdfromVisitArray.append(VisitType.AutoID)
                            self.designationFromVisitArray.append(VisitType.Designation)
                            
                        }
                       
                        self.dropDownSiteType.dataSource = self.VisitTypeNameList
                        self.isvisitSelection = true
                        self.visitselectBtn.setTitle(self.VisitTypeNameList[0], for: .normal)
                        self.siteType = self.VisitTypeNameList[0]
                        self.autoIdfromVisit = self.autoIdfromVisitArray[0]
                        self.designationFromVisit = self.designationFromVisitArray[0]
                        
                      
                      
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
