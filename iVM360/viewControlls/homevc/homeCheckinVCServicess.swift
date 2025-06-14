//
//  homeCheckinVCServicess.swift
//  iVM360
//
//  Created by 1707 on 22/07/24.
//

import Foundation
import UIKit
extension homeCheckinVC{
    //===========================================================
    //MARK: - WebService Methods
    //===========================================================
    @available(iOS 13.0, *)
    func callGetEmpMappedSitesService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetEmpMappedSitesService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["EmpID"]              = AppSession.user?.EmpNumber
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
        params["connectionKey"]  = "SAMS"
        print(params)
        WebServiceManager.shared.GetEmpMappedSites(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.SiteListData = data.compactMap({SitesList(withData: $0)})
                        self.siteNamelist.removeAll()
                        for sitelists in self.SiteListData{
                            self.siteNamelist.append(sitelists.ClientSiteName)
                            self.clintCodeArray.append(sitelists.ClientCode)
                            self.AsmtIdArray.append(sitelists.AsmtId)
                        }
                        
                        self.siteBtn.isEnabled = true
                        self.dropDown.dataSource = self.siteNamelist
                        self.siteBtn.setTitle(self.siteNamelist[0], for: .normal)
                        self.AsmtIDFromSite = self.AsmtIdArray[0]
                        UserDefaultUtility().saveAsmtId(AsmtId: self.AsmtIDFromSite)
                        self.ClientCodeFromSite = self.clintCodeArray[0]
                        UserDefaultUtility().saveClientCode(ClientCode: self.ClientCodeFromSite)
                        self.callGetEmployeeAttendanceDailyWithShiftService()
                        
//                        self.callGetEmployeeAttendanceDailyWithShiftService()
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
                        self.visitSiteData_attendance = data.compactMap({Sites_VisitModal(withData: $0)})
                        self.siteNamelist.removeAll()
                        for sitelists in self.visitSiteData_attendance{
                            self.siteNamelist.append(sitelists.SiteName)
                            self.clintCodeArray.append(sitelists.ClientCode)
                            self.AsmtIdArray.append(sitelists.AsmtId)
                            self.locationAutoId.append(sitelists.LocationAutoID)
                        }
                        
                        self.siteBtn.isEnabled = true
                        self.dropDown.dataSource = self.siteNamelist
                        self.siteBtn.setTitle(self.siteNamelist[0], for: .normal)
                        self.AsmtIDFromSite = self.AsmtIdArray[0]
                        UserDefaultUtility().saveLocationAutoID(fcmToken: self.locationAutoId[0])
                        UserDefaultUtility().saveAsmtId(AsmtId: self.AsmtIDFromSite)
                        self.ClientCodeFromSite = self.clintCodeArray[0]
                        UserDefaultUtility().saveClientCode(ClientCode: self.ClientCodeFromSite)
                        self.callGetStandardShiftsService()
//                        self.callGetEmployeeAttendanceDailyWithShiftService()
                      

                       
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
    
    
    func callGetStandardShiftsService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetStandardShiftsService()
            }
            return
        }
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID

//        if let location         = LocationManager.shared.currentLocation {
//            params["latitude"]  = location.coordinate.latitude.string
//            params["longitude"] = location.coordinate.longitude.string
//        }
       
        print(params)
        WebServiceManager.shared.GetStandardShifts(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.shift_detaislData = data.compactMap({shift_deatils(withData: $0)})
                        self.shiftNameList.removeAll()
                        for shift_list in self.shift_detaislData{
                            self.shiftNameList.append(shift_list.ShiftCode)
                        }
                        self.dropDownShift.dataSource = self.shiftNameList
                        self.shiftBtn.setTitle(self.shiftNameList[0], for: .normal)
                        self.ShiftCode = self.shiftNameList[0]
                        UserDefaultUtility().saveShiftCode(ShiftCode: self.shiftNameList[0])
                        self.callGetEmployeeAttendanceDailyInternalService()

                       
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
    
    
    func callGetEmployeeAttendanceDailyInternalService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetEmployeeAttendanceDailyInternalService()
            }
            return
        }
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["EmployeeNumber"]      = AppSession.user?.EmpNumber

//        if let location         = LocationManager.shared.currentLocation {
//            params["latitude"]  = location.coordinate.latitude.string
//            params["longitude"] = location.coordinate.longitude.string
//        }
       
        print(params)
        WebServiceManager.shared.GetEmployeeAttendanceDailyInternal(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.time_detailsData = data.compactMap({time_deatils(withData: $0)})
                        for time_list in self.time_detailsData{
                            let check_in_Enable = time_list.CheckInEnable
                            let check_out_Enable = time_list.CheckOutEnable
                            let check_in_Time = time_list.InTime
                            let check_out_Time = time_list.OutTime
                            UserDefaultUtility().saveCheckInEnable(CheckInEnable: check_in_Enable )
                            UserDefaultUtility().saveCheckOutEnable(CheckOutEnable: check_out_Enable)
                            if check_in_Enable == "1" && check_out_Enable == "1"{
                                self.siteBtn.isEnabled = true
                                self.shiftBtn.isEnabled = true
                                self.checkinBtn.isEnabled = true
                                self.checkoutBtn.isEnabled = false
                                self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                                self.checkinBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
                                self.shiftendTimeLbl.text = "----"
                                self.shiftStartTimeLbl.text = "----"
                                
                            } else if check_in_Enable == "1" && check_out_Enable == "0"{
                                self.shiftStartTimeLbl.text = "----"
                                self.shiftendTimeLbl.text = check_out_Time
                                self.siteBtn.isEnabled = true
                                self.shiftBtn.isEnabled = true
                                self.checkinBtn.isEnabled = true
                                self.checkoutBtn.isEnabled = false
                                self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                                self.checkinBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
                                
                            } else if check_in_Enable == "0" && check_out_Enable == "1"{
                                self.siteBtn.isEnabled = true
                                self.shiftBtn.isEnabled = true
                                self.checkinBtn.isEnabled = false
                                self.checkoutBtn.isEnabled = true
                                self.checkinBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                                self.checkoutBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
                                self.shiftStartTimeLbl.text = check_in_Time
                                self.shiftendTimeLbl.text = "----"
                                                              
                            } else if check_in_Enable == "0" && check_out_Enable == "0"{
                                self.siteBtn.isEnabled = true
                                self.shiftBtn.isEnabled = true
                                self.checkinBtn.isEnabled = false
                                self.checkoutBtn.isEnabled = false
                                self.checkinBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                                self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                                self.shiftStartTimeLbl.text = check_in_Time
                                self.shiftendTimeLbl.text = check_out_Time
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
        if self.isceheckInsubmittedDone == true || (UserDefaultUtility().getCheckInEnable() == "0" && UserDefaultUtility().getCheckOutEnable() == "1"){
            params["ClientCode"]             = UserDefaultUtility().getClientCode()
            params["AsmtId"]                = UserDefaultUtility().getAsmtId()
        }else{
            params["ClientCode"]             = self.ClientCodeFromSite
            params["AsmtId"]                = self.AsmtIDFromSite
        }
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
        
        
//        if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
//            params["LocationAutoID"]        = UserDefaultUtility().getLocationAutoID()
//        }else{
//            params["LocationAutoID"]        = AppSession.user?.LocationAutoID
//        }
        
        
        print(params)
        WebServiceManager.shared.GetEmployeeAttendanceDailyWithShift(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.ShiftListData = data.compactMap({ShiftsfList(withData: $0)})
                        self.shiftNameList.removeAll()
                        for shiftlist in self.ShiftListData{
                            self.shiftNameList.append(shiftlist.ShiftCode)
                            self.checkinTimeArray.append(shiftlist.InTime)
                            self.checkOutTimeArray.append(shiftlist.OutTime)
                            self.shiftCodeArray.append(shiftlist.ShiftCode)
                            if shiftlist.CheckInEnable == "0" && shiftlist.CheckOutEnable == "1"{
                                if self.isceheckInsubmittedDone == true || UserDefaultUtility().getEmpNumber() == AppSession.user?.EmpNumber{
                                    UserDefaultUtility().saveCheckInEnable(CheckInEnable: shiftlist.CheckInEnable)
                                    UserDefaultUtility().saveCheckOutEnable(CheckOutEnable: shiftlist.CheckOutEnable)
                                    self.checkoutBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
                                    self.checkinBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                                    self.shiftBtn.setTitle(UserDefaultUtility().getShiftCode(), for: .normal)
                                    self.siteBtn.setTitle(UserDefaultUtility().getClientSiteName(), for: .normal)
                                    self.siteBtn.isEnabled = true
                                    self.shiftBtn.isEnabled = true
                                    self.checkinBtn.isEnabled = false
                                    self.checkoutBtn.isEnabled = true
                                if shiftlist.InTime != "" && shiftlist.OutTime == "" {
                                                self.shiftStartTimeLbl.text = shiftlist.InTime
                                                self.shiftendTimeLbl.text = "----"
                                    }else if shiftlist.OutTime != "" && shiftlist.InTime != ""{
                                        self.shiftendTimeLbl.text = shiftlist.OutTime
                                        self.shiftStartTimeLbl.text = shiftlist.InTime
                                    }else if shiftlist.OutTime == "" && shiftlist.InTime == ""{
                                        self.shiftendTimeLbl.text = "----"
                                        self.shiftStartTimeLbl.text = "----"
                                    }
                            let shiftDetails = shiftlist.ShiftDetails
                            if let range = shiftDetails.range(of: "\\((.*?)\\)", options: .regularExpression) {
                                let timeDetails = shiftDetails[range].dropFirst(2).dropLast(2)
                                print(timeDetails)
                                // Split the time details by hyphen
                                let times = timeDetails.components(separatedBy: "-")
                                print(times)
                                print(times.count)
                                if times.count == 2 {
                                    let startTime = times[0].trimmingCharacters(in: .whitespaces)
                                    let endTime = times[1].trimmingCharacters(in: .whitespaces)
                                    self.checkInTimeLbl.text = startTime
                                    self.checkOutTimeLbl.text = endTime
                                    UserDefaultUtility().saveShiftEndTime(endTime: endTime)
                                    let date = Date()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "E d MMM"
                                    let formattedDate = dateFormatter.string(from: date)
                                    UserDefaultUtility().savedate(date: formattedDate)
                                    
                                }
                            }
                                    
                                }else{
                                    
                                }
                            }else if shiftlist.CheckInEnable == "1" && shiftlist.CheckOutEnable == "0"{
                                self.siteBtn.isEnabled = true
                                self.shiftBtn.isEnabled = true
                                self.checkinBtn.isEnabled = true
                                self.checkoutBtn.isEnabled = false
                                self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                                self.checkinBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
                                if shiftlist.InTime != "" && shiftlist.OutTime == "" {
                                                self.shiftStartTimeLbl.text = shiftlist.InTime
                                                self.shiftendTimeLbl.text = "----"
                                    }else if shiftlist.OutTime != "" && shiftlist.InTime != ""{
                                        self.shiftendTimeLbl.text = shiftlist.OutTime
                                        self.shiftStartTimeLbl.text = shiftlist.InTime
                                    }else if shiftlist.OutTime == "" && shiftlist.InTime == ""{
                                        self.shiftendTimeLbl.text = "----"
                                        self.shiftStartTimeLbl.text = "----"
                                    }
                            let shiftDetails = shiftlist.ShiftDetails
                            if let range = shiftDetails.range(of: "\\((.*?)\\)", options: .regularExpression) {
                                let timeDetails = shiftDetails[range].dropFirst(2).dropLast(2)
                                print(timeDetails)
                                // Split the time details by hyphen
                                let times = timeDetails.components(separatedBy: "-")
                                print(times)
                                print(times.count)
                                if times.count == 2 {
                                    let startTime = times[0].trimmingCharacters(in: .whitespaces)
                                    let endTime = times[1].trimmingCharacters(in: .whitespaces)
                                    self.checkInTimeLbl.text = startTime
                                    self.checkOutTimeLbl.text = endTime
                                    
                                }
                            }
                            }else if shiftlist.CheckInEnable == "0" && shiftlist.CheckOutEnable == "0"{
                                if self.isceheckInsubmittedDone == true{
                                    self.siteBtn.isEnabled = true
                                    self.shiftBtn.isEnabled = true
                                    self.checkinBtn.isEnabled = false
                                    self.checkoutBtn.isEnabled = false
                                    self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                                    self.checkinBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                                    self.shiftBtn.setTitle(UserDefaultUtility().getShiftCode(), for: .normal)
                                    self.siteBtn.setTitle(UserDefaultUtility().getClientSiteName(), for: .normal)
                                }
                                   
                                if shiftlist.InTime != "" && shiftlist.OutTime == "" {
                                                self.shiftStartTimeLbl.text = shiftlist.InTime
                                                self.shiftendTimeLbl.text = "----"
                                    }else if shiftlist.OutTime != "" && shiftlist.InTime != ""{
                                        self.shiftendTimeLbl.text = shiftlist.OutTime
                                        self.shiftStartTimeLbl.text = shiftlist.InTime
                                    }else if shiftlist.OutTime == "" && shiftlist.InTime == ""{
                                        self.shiftendTimeLbl.text = "----"
                                        self.shiftStartTimeLbl.text = "----"
                                    }
                            let shiftDetails = shiftlist.ShiftDetails
                            if let range = shiftDetails.range(of: "\\((.*?)\\)", options: .regularExpression) {
                                let timeDetails = shiftDetails[range].dropFirst(2).dropLast(2)
                                print(timeDetails)
                                // Split the time details by hyphen
                                let times = timeDetails.components(separatedBy: "-")
                                print(times)
                                print(times.count)
                                if times.count == 2 {
                                    let startTime = times[0].trimmingCharacters(in: .whitespaces)
                                    let endTime = times[1].trimmingCharacters(in: .whitespaces)
                                    self.checkInTimeLbl.text = startTime
                                    self.checkOutTimeLbl.text = endTime
                                    
                                }
                            }
                            }

                        }
                        self.dropDownShift.dataSource = self.shiftNameList
                        self.shiftBtn.setTitle(self.shiftNameList[0], for: .normal)
                        self.ShiftCode = self.shiftCodeArray[0]
                        UserDefaultUtility().saveShiftCode(ShiftCode: self.shiftCodeArray[0])
                        self.checkinTime = self.checkinTimeArray[0]
                        self.checkoutTime = self.checkOutTimeArray[0]
                        
                       
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
    func callGetSitesPostService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetSitesPostService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]          = "SAMS"
//        params["ClientCode"]             = self.ClientCodeFromSite
//        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
        
        if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
            params["LocationAutoID"]        = UserDefaultUtility().getLocationAutoID()
        }else{
            params["LocationAutoID"]        = AppSession.user?.LocationAutoID
        }
        
//        if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
//            if let location         = LocationManager.shared.currentLocation {
//                params["latitude"]  = location.coordinate.latitude.string
//                params["longitude"] = location.coordinate.longitude.string
//            }
//        }else{
//            print("ok")
//        }
        
//        params["AsmtId"]                = self.AsmtIDFromSite
        if UserDefaultUtility().getEmpNumber() == AppSession.user?.EmpNumber{
            if UserDefaultUtility().getCheckInEnable() == "0" && UserDefaultUtility().getCheckOutEnable() == "1"{
                params["ClientCode"] = UserDefaultUtility().getClientCode()
                params["AsmtId"] = UserDefaultUtility().getAsmtId()
            }else{
                params["ClientCode"]             = self.ClientCodeFromSite
                params["AsmtId"]                = self.AsmtIDFromSite
            }
        }else{
            params["ClientCode"]             = self.ClientCodeFromSite
            params["AsmtId"]                = self.AsmtIDFromSite
        }
      
        print(params)
        WebServiceManager.shared.GetSitesPost(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.sitePostData = data.compactMap({SitePostCheckinModal(withData: $0)})
                        self.postId = self.sitePostData.first?.PostAutoId ?? ""
                        if self.sitePostData.count > 1 {
                            let scanvc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanViewController") as? ScanViewController
                            scanvc?.ScanShiftCodefromBack          = self.ShiftCode
                            scanvc?.ScanClintCodefromBack          = self.ClientCodeFromSite
                            scanvc?.ScanAsmtIDfromBack             = self.AsmtIDFromSite
    //                        scanvc?.ScanpostIDFromBack             = self.postId
                            scanvc?.ScancheckInTimeFromBack         = self.checkinTime
                            scanvc?.ScancheckOutTimeFromBack        = self.checkoutTime
                            scanvc?.clientSiteNameFromback = self.clientSiteName
                            self.navigationController?.pushViewController(scanvc!, animated: true)
                        }else if self.sitePostData.count == 1 && self.postId.isEmpty == false{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AttendenceVC") as? AttendenceVC
                            vc?.ShiftCodefromBack          = self.ShiftCode
                            vc?.ClintCodefromBack          = self.ClientCodeFromSite
                            vc?.AsmtIDfromBack             = self.AsmtIDFromSite
                            vc?.postIDFromBack             = self.postId
                            vc?.checkInTimeFromBack         = self.checkinTime
                            vc?.checkOutTimeFromBack        = self.checkoutTime
                            vc?.clientSiteNameFromBack = self.clientSiteName
                            self.navigationController?.pushViewController(vc!, animated: true)
                        }else if  self.postId.isEmpty == true{
                            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                                           customAlert.delegate = self
                                           customAlert.hideBut = true
                                           customAlert.logoutBut = false
                                           customAlert.onofflineBut = false
                                           customAlert.modalPresentationStyle = .overCurrentContext
                                           customAlert.providesPresentationContextTransitionStyle = true
                                           customAlert.modalTransitionStyle = .crossDissolve
                                           customAlert.titlestring = "Alert"
                                           customAlert.massage = "Post not available!!"
                                           self.present(customAlert, animated: true, completion: nil)
                                           ActivityView.hide(self.view)
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
