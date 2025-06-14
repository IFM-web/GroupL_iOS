//
//  appointmentServecies.swift
//  iVM360
//
//  Created by 1707 on 04/03/25.
//

import UIKit
extension Appointment_Letter_VC{
    func callGenerationService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGenerationService()
            }
            return
        }
        ActivityView.show(self.view)
        params["UserName"]  = "grouplprod"
        params["AppId"]      = "Ng=="
        params["Password"]  = "Z3JvdXBsYWRtaW4yMDI0"
           
       
        print(params)
        WebServiceManager.shared.Generation(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if !json.isEmpty {
                    if let mainData = json as? [String: Any] {
                        self.appointment_AuthToken = mainData["Auth_token_no"] as? String ?? ""
                        self.callViewService()
                    } else {
                        print("Data parsing error")
                    }
                } else {
                    ActivityView.hide(self.view)
                    print("Empty JSON response")
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
    
    func callViewService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callViewService()
            }
            return
        }
        ActivityView.show(self.view)
        params["UserName"]  = "grouplprod"
        params["AppId"]      = "Ng=="
        params["Password"]  = "Z3JvdXBsYWRtaW4yMDI0"
        params["EmpCode"]  = "1"
        params["EmployeeType"]  = "Front"
        params["Auth_token_no"]  =  self.appointment_AuthToken
        print(params)
        WebServiceManager.shared.View(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if !json.isEmpty {
                    if let mainData = json as? [String: Any] {
                        self.pdfURL = mainData["LetterPdfLink"] as? String ?? ""
                        self.setupWebView()
                        self.loadPDF()
                        self.callGetAppointmentApprovalService()
                        print("get Data")
                    } else {
                        print("Data parsing error")
                    }
                } else {
                    ActivityView.hide(self.view)
                    print("Empty JSON response")
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
    func callGetAppointmentApprovalService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetAppointmentApprovalService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
        params["EmpID"]  = AppSession.user?.EmpNumber
           
       
        print(params)
        WebServiceManager.shared.GetAppointmentApproval(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        
                        let message = mainData["MessageString1"] as? String
                        if message == "Appointment Letter Accepted"{
                            self.checkBoxBtn.isEnabled = true
                            self.download_submit_Btn.isEnabled = true
                        }else{
                            self.checkBoxBtn.isEnabled = false
                            self.download_submit_Btn.isEnabled = false
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
    
    
    func callInsertAppointmentApprovalService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callInsertAppointmentApprovalService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
        params["EmpID"]  = AppSession.user?.EmpNumber
           
       
        print(params)
        WebServiceManager.shared.InsertAppointmentApproval(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        
                        let message = mainData["MessageString1"] as? String
                        if message == "Appointment Approved Successfully"{
                            self.downloadPDF()
//                       self.navigationController?.popViewController(animated: true)
                        }else{
                           
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
