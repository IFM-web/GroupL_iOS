//
//  AttendanceVCServicess.swift
//  iVM360
//
//  Created by 1707 on 23/07/24.
//

import Foundation
import UIKit
extension AttendenceVC{
    
    func callInsertEmployeeAttendanceService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callInsertEmployeeAttendanceService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]          = "SAMS"
        params["EmployeeNumber"]         = AppSession.user?.EmpNumber
        params["LocationAutoID"]        = AppSession.user?.LocationAutoID
        
//        if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
//            params["LocationAutoID"]        = UserDefaultUtility().getLocationAutoID()
//        }else{
//            params["LocationAutoID"]        = AppSession.user?.LocationAutoID
//        }
        
       if let location         = LocationManager.shared.currentLocation {
           params["latitude"]  = location.coordinate.latitude.string
           params["longitude"] = location.coordinate.longitude.string
       }
        if UserDefaultUtility().getEmpNumber() == AppSession.user?.EmpNumber{
            if UserDefaultUtility().getCheckInEnable() == "0" && UserDefaultUtility().getCheckOutEnable() == "1"{
                    params["ClientCode"]             = UserDefaultUtility().getClientCode()
                    params["AsmtId"]                = UserDefaultUtility().getAsmtId()
                    params["ShiftCode"]                 = UserDefaultUtility().getShiftCode()
                
            }else{
                params["ClientCode"]             = self.ClintCodefromBack
                params["AsmtId"]                = self.AsmtIDfromBack
                params["ShiftCode"]                 = self.ShiftCodefromBack
            }
        }else{
            params["ClientCode"]             = self.ClintCodefromBack
            params["AsmtId"]                = self.AsmtIDfromBack
            params["ShiftCode"]                 = self.ShiftCodefromBack
        }
          
        if self.QRCode.isEmpty == true && self.postIDFromBack.isEmpty == false{
            params["Post"]                      = self.postIDFromBack
        }else if self.QRCode.isEmpty == false && self.postIDFromBack.isEmpty == true{
            params["Post"]                      = self.QRCode
        }
            params["Post"]                      = self.postIDFromBack
      
        params["IMEI"]                  = ""
        params["userId"]                = AppSession.user?.EmpNumber
        if UserDefaultUtility().getCheckInEnable() == "0" && UserDefaultUtility().getCheckOutEnable() == "1"{
            params["InOutStatus"]            = "OUT"
        } else{
            params["InOutStatus"]            = "IN"
        }
        params["DutyDateTime"]            = self.currentDateTiem
        params["altitude"]                 = ""
        params["employeeImageBase64"]        = self.checkListmarkbased64VPhoto
        params["LocationName"]               = self.currentAddress
      
      
        print(params)
        WebServiceManager.shared.InsertEmployeeAttendance(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                  
                  
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        let messageId =  mainData["MessageID"] as? Int ?? 0
                        if messageId == 2 {
                            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                            customAlert.delegate = self
                            customAlert.hideBut = true
                            customAlert.logoutBut = false
                            customAlert.onofflineBut = false
                            customAlert.modalPresentationStyle = .overCurrentContext
                            customAlert.providesPresentationContextTransitionStyle = true
                            customAlert.modalTransitionStyle = .crossDissolve
                            customAlert.titlestring = "Alert"
                            customAlert.massage = "Unable to mark Attendance as Check In Not Exists for this Shift !!"
                            self.present(customAlert, animated: true, completion: nil)
                        }else{
                            
                              let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AttendenceSubmitedVC") as? AttendenceSubmitedVC
                                 vc?.ischeckinSuccess = self.ischeckin
                          vc?.CurrentAddressFromBack = self.currentAddress
                          vc?.isscannerVCFromBackk = self.isscanerVCFromBack
                          self.navigationController?.pushViewController(vc!, animated: false)
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
    
    
    
    func callGetEmployeeAttendanceDailyWithShiftService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetEmployeeAttendanceDailyWithShiftService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]          = "SAMS"
        params["EmployeeNumber"]         = AppSession.user?.EmpNumber
        let defaults = UserDefaults.standard
        params["ClientCode"]             =  defaults.value(forKey: "ClientCode") as? String ?? "not checkin"
        let defaults1 = UserDefaults.standard
        params["AsmtId"]                =  defaults1.value(forKey: "AsmtId") as? String ?? "not checkin"
        
//        if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
//            params["LocationAutoID"]        = UserDefaultUtility().getLocationAutoID()
//        }else{
//            params["LocationAutoID"]        = AppSession.user?.LocationAutoID
//        }
        params["LocationAutoID"]         = AppSession.user?.LocationAutoID
        print(params)
        WebServiceManager.shared.GetEmployeeAttendanceDailyWithShift(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.ShiftListData = data.compactMap({ShiftsfList(withData: $0)})
                        for checkinshiftlistData in self.ShiftListData{
                            self.checkInTime = checkinshiftlistData.InTime
                            self.checkOutTime = checkinshiftlistData.OutTime
                            print(self.checkInTime)
                            print(self.checkOutTime)
                            self.checkinenable = checkinshiftlistData.CheckInEnable
                            self.checkoutenable = checkinshiftlistData.CheckOutEnable
                        }
                        if  self.checkInTime.isEmpty == false && self.checkOutTime.isEmpty == false{
                            let defaults = UserDefaults.standard
                            defaults.removeObject(forKey: "ClientCode")

                            let defaults1 = UserDefaults.standard
                            defaults1.removeObject(forKey: "AsmtId")

                            let defaults2 = UserDefaults.standard
                            defaults2.removeObject(forKey: "EmpNumber")

                            let defaults3 = UserDefaults.standard
                            defaults3.removeObject(forKey: "ClientSiteName")

                            let defaults4 = UserDefaults.standard
                            defaults4.removeObject(forKey: "ShiftCode")
                        }else{
                            let defaults = UserDefaults.standard
                            defaults.set(self.ClintCodefromBack, forKey: "ClientCode")
                            let defaults1 = UserDefaults.standard
                            defaults1.set(self.AsmtIDfromBack, forKey: "AsmtId")
                            let defaults2 = UserDefaults.standard
                            defaults2.set(AppSession.user?.EmpNumber, forKey: "EmpNumber")
                            let defaults3 = UserDefaults.standard
                            defaults3.set(self.clientSiteNameFromBack, forKey: "ClientSiteName")
                            let defaults4 = UserDefaults.standard
                            defaults4.set(self.ShiftCodefromBack, forKey: "ShiftCode")
                        }
                                
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AttendenceSubmitedVC") as? AttendenceSubmitedVC
                        vc?.checkListmarklastImgFromBack = self.checkListmarklastImg
                        vc?.latfromBack = self.lat
                        vc?.longFromBack = self.long
//                        vc?.submitshiftCodeFromBack = self.ShiftCodefromBack
//                        vc?.currentDateTiemFromBack = self.currentDateTiem
                        vc?.isscannerVCFromBackk = self.isscanerVCFromBack
//                        vc?.checkInTimeFromBack = self.checkInTime
//                        vc?.checkOutTimeFromBack = self.checkOutTime
                        
                        self.navigationController?.pushViewController(vc!, animated: false)
                        
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
