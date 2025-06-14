//
//  LoginByPIN_VC.swift
//  iVM360
//
//  Created by 1707 on 20/02/25.
//

import UIKit

class LoginByPIN_VC: UIViewController, UITextFieldDelegate, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("Cancel")
    }
    

    @IBOutlet weak var emojiImageView: UIImageView!
    @IBOutlet weak var emoji_Name_Lbl: UILabel!
    @IBOutlet weak var title_NameLbl: UILabel!
    @IBOutlet weak var pin_Fld: UITextField!
    @IBOutlet weak var lable_One: UILabel!
    @IBOutlet weak var lable_Two: UILabel!
    @IBOutlet weak var lable_Three: UILabel!
    @IBOutlet weak var lable_Foure: UILabel!
    @IBOutlet weak var backGround_View: UIView!

    @IBOutlet var pinTextFields: [UITextField]!
    
    var userDetails = UserModel()
    var actualPin : [String] = ["", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.emoji_Name_Lbl.text = AppSession.user?.EmpName
        self.backGround_View.layer.cornerRadius = 5
        self.emojiImageView.layer.cornerRadius = 25
        setupPinFields()
        for textField in pinTextFields {
               textField.addTarget(self, action: #selector(pinTextFieldDidChange(_:)), for: .editingChanged)
           }
    }
    
    
    
    
    @IBAction func clickcameraTOLogin(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginImpIdVC") as? LoginImpIdVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func getDeviceID() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    
    private func setupPinFields() {
           for textField in pinTextFields {
               textField.delegate = self
               textField.keyboardType = .numberPad
               textField.textAlignment = .center
               textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
           }
       }

       @objc private func textFieldDidChange(_ textField: UITextField) {
           guard let index = pinTextFields.firstIndex(of: textField) else { return }
           guard let text = textField.text, !text.isEmpty else {
               // If backspace is pressed, clear previous field and move back
               actualPin[index] = ""
               textField.text = ""
               if index > 0 {
                   pinTextFields[index - 1].becomeFirstResponder()
               }
               return
           }

           // Store actual digit and show '*'
           actualPin[index] = text
           textField.text = "*"

           // Move to next field automatically
           if index < pinTextFields.count - 1 {
               pinTextFields[index + 1].becomeFirstResponder()
           } else {
               textField.resignFirstResponder()
               validatePin()
           }
       }

    @objc func pinTextFieldDidChange(_ textField: UITextField) {
        // Ensure all 4 fields are filled
        let enteredPin = pinTextFields.map { $0.text?.trimmingCharacters(in: .whitespaces) ?? "" }.joined()
        
        if enteredPin.count == 4 {
            callLoginByEmpIDFCMService()
        }
    }
    
       private func validatePin() {
           let enteredPin = actualPin.joined()
           print("Entered PIN: \(enteredPin)") // You can validate it with a stored PIN
//           if enteredPin == "1111" { // Example PIN
//               print("PIN Correct")
//           } else {
//               print("Incorrect PIN")
//           }
       }

}








extension LoginByPIN_VC{
    func callLoginByEmpIDFCMService(){
        var params: [String: Any] = [:]
        guard let fristDigit = pinTextFields[0].text,fristDigit.trimmingCharacters(in: .whitespaces).isEmpty == false else {
            let customAlert : AlertVC = AlertVC.instance()
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "Incorrect Pin"
            self.present(customAlert, animated: true, completion: nil)
            ActivityView.hide(self.view)
            return
        }
        guard let secondDigit = pinTextFields[1].text,secondDigit.trimmingCharacters(in: .whitespaces).isEmpty == false  else {
            let customAlert : AlertVC = AlertVC.instance()
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "Incorrect Pin"
            self.present(customAlert, animated: true, completion: nil)
            return
        }
        guard let secondDigit = pinTextFields[2].text,secondDigit.trimmingCharacters(in: .whitespaces).isEmpty == false  else {
            let customAlert : AlertVC = AlertVC.instance()
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "Incorrect Pin"
            self.present(customAlert, animated: true, completion: nil)
            return
        }
        guard let secondDigit = pinTextFields[3].text,secondDigit.trimmingCharacters(in: .whitespaces).isEmpty == false  else {
            let customAlert : AlertVC = AlertVC.instance()
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "Incorrect Pin"
            self.present(customAlert, animated: true, completion: nil)
            return
        }
        let enteredPin = pinTextFields.map { $0.text?.trimmingCharacters(in: .whitespaces) ?? "" }.joined()
        guard enteredPin.count == 4 else { return }
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callLoginByEmpIDFCMService()
            }
            return
        }
        
        let fcmToken = UserDefaultUtility().getFcmToken()
        ActivityView.show(self.view)
        params["EmpID"]         = AppSession.user?.EmpNumber
        params["PIN"]           = actualPin.joined()
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
