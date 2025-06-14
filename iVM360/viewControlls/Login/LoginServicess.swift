//
//  LoginServicess.swift
//  iVM360
//
//  Created by 1707 on 18/07/24.
//
import Foundation
import UIKit
import Network
extension LoginImpIdVC{
    //===========================================================
    //MARK: - WebService Methods
    //===========================================================
    @available(iOS 13.0, *)
    func callLoginByEmpIDFCMService(){
        var params: [String: Any] = [:]
        guard let phoneNumber = EmpIdBtn.text,phoneNumber.trimmingCharacters(in: .whitespaces).isEmpty == false else {
            let customAlert : AlertVC = AlertVC.instance()
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "enter username"
            self.present(customAlert, animated: true, completion: nil)
            ActivityView.hide(self.view)
            return
        }
        guard let password = pinBtn.text,password.trimmingCharacters(in: .whitespaces).isEmpty == false  else {
            let customAlert : AlertVC = AlertVC.instance()
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "enter password"
            self.present(customAlert, animated: true, completion: nil)
            return
        }
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callLoginByEmpIDFCMService()
            }
            return
        }
        
        let fcmToken = UserDefaultUtility().getFcmToken()
        ActivityView.show(self.view)
        params["EmpID"]         = phoneNumber
        params["PIN"]           = password
        params["connectionKey"]  = "SAMS"
        params["OSType"]  = "iOS"
        params["FCMId"]  = fcmToken
        
        
        print(params)
        WebServiceManager.shared.LoginByEmpIDFCM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.userDetails = UserModel(withData: mainData)
                                    AppSession.user = UserModel(withData: mainData)
                        if AppSession.user?.MessageID == "-1"{
                            let customAlert : AlertVC = AlertVC.instance()
                            customAlert.delegate = self
                            customAlert.hideBut = true
                            customAlert.logoutBut = false
                            customAlert.onofflineBut = false
                            customAlert.modalPresentationStyle = .overCurrentContext
                            customAlert.providesPresentationContextTransitionStyle = true
                            customAlert.modalTransitionStyle = .crossDissolve
                            customAlert.titlestring = "Alert"
                            customAlert.massage = AppSession.user?.MessageString
                            self.present(customAlert, animated: true, completion: nil)
                        }else{
                            if AppSession.user?.Isrunnner == "True"{
                                self.calladdRunnerInSessionService()
                            }else{
                                UserDefaults.standard.set(true, forKey: "isLogin")
//                                UserDefaults.standard.removeObject(forKey: "isLogin")
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
                                self.navigationController?.pushViewController(vc!, animated: true)
                            }
                          
                        }
                       
//                                  print("LocationAutoID: \(AppSession.user.LocationAutoID)")
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
    
    
    func calladdRunnerInSessionService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.calladdRunnerInSessionService()
            }
            return
        }
        let deviceID = getDeviceID()
        
        let deviceToken = UserDefaultUtility().getDeviceToken()
        let fcmToken = UserDefaultUtility().getFcmToken()
        ActivityView.show(self.view)
        params["deviceToken"]  = deviceToken
        params["deviceId"]      = deviceID
        params["token"]  = AppSession.user?.UserSessionID
        params["userName"]      = AppSession.user?.dex_runner_username
        print(params)
        WebServiceManager.shared.addRunnerInSession(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if let json = json as? [String: Any], // Ensure the JSON is a dictionary
                   let dataArray = json["data"] as? [[String: Any]], // Extract the "data" array
                   !dataArray.isEmpty, // Check if the array is not empty
                   let successMessage = dataArray.first?["success"] as? String { // Extract the "success" message
                    print("Success message: \(successMessage)")
                    if successMessage == "Login Successfully"{
                       UserDefaults.standard.set(true, forKey: "isLogin")
                        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
                        self.navigationController?.pushViewController(vc!, animated: true)
                        print("Runner successfully enabled")

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
                        customAlert.massage = "runner not Login Successfully"
                        self.present(customAlert, animated: true, completion: nil)
                        ActivityView.hide(self.view)
                    }
                } else {
                    print("Data parsing error")
                }
                
//                if json.isEmpty == false {
//                    if let data = json as? [[String: Any]]{
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
//                        self.navigationController?.pushViewController(vc!, animated: true)
//                        print("runner successfully enable")
//                       
//                                } else {
//                                    print("Data parsing error")
//                                }
//                }else{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
//                    self.navigationController?.pushViewController(vc!, animated: true)
//                    print("runner Error enable")
//                }
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
