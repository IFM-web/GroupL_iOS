//
//  Employee_MusterServicess.swift
//  iVM360
//
//  Created by 1707 on 04/03/25.
//

import UIKit
extension salary_Muster_VC{
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
                        self.auth_Token = mainData["Auth_token_no"] as? String ?? ""
                        self.callEmpWiseService()
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
    
    func callEmpWiseService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callEmpWiseService()
            }
            return
        }
        ActivityView.show(self.view)
        params["UserName"]  = "grouplprod"
        params["AppId"]      = "Ng=="
        params["Password"]  = "Z3JvdXBsYWRtaW4yMDI0"
        params["Month"]  = self.salary_MustermonthsString
        params["Year"]      = self.salary_MusteryearString
        params["EmpCode"]  = "1"
        params["EmployeeType"]  = "Front"
        params["Auth_token_no"]  =  self.auth_Token
        print(params)
        WebServiceManager.shared.EmpWise(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if !json.isEmpty {
                    if let mainData = json as? [String: Any] {
                        self.salaryPdfLink = mainData["SalarySlipPdfLink"] as? String ?? ""
                        if let url = URL(string: self.salaryPdfLink) {
                            UIApplication.shared.open(url)
                        }
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
    func callAttendanceMusterService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callAttendanceMusterService()
            }
            return
        }
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
        params["EmployeeID"]  = AppSession.user?.EmpNumber
        params["Month"]  = self.salary_MustermonthsString
        params["Year"]   = self.salary_MusteryearString
           
       
        print(params)
        WebServiceManager.shared.AttendanceMuster(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        
//                        let designation = mainData["Designation"] as? String
//                        let contactNumber = mainData["ContactNo"] as? String
//                        let EmpNmae = mainData["EmpName"] as? String
//                        let clientName = mainData["ClientName"] as? String
//                        let Siteaddress = mainData["AsmtAddress"] as? String
//                        let EmpCode = mainData["EmpID"] as? String
////                        let image_String = mainData["EmpID"] as? String
//                        let base64String = mainData["ImageBase64String"] as? String
//                        if let image = convertBase64ToImage(base64String: base64String ?? "") {
//                            self.profile_Photo.image = image
//                        } else {
//                            print("Failed to convert Base64 to UIImage")
//                        }
//                        
//                        self.data_BackGroundView.isHidden = false
//                        self.nameLbl.text = EmpNmae
//                        self.degination_Lbl.text = designation
//                        self.employee_CodeLbl.text = EmpCode
//                        self.contactNumber_Lbl.text = contactNumber
//                        self.client_NameLbl.text = clientName
//                        self.Site_NameLbl.text = Siteaddress
//                        

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
