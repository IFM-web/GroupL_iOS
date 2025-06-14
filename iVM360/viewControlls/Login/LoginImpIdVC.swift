//
//  LoginImpIdVC.swift
//  iVM360
//
//  Created by 1707 on 15/07/24.
//

import UIKit
import Network
class LoginImpIdVC: UIViewController, CustomAlertDelegate, UITextFieldDelegate {
    
    
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var EmpIdBtn: UITextField!
    @IBOutlet weak var pinBtn: UITextField!
    
    var userDetails = UserModel()
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.continueBtn.layer.cornerRadius = 5
        self.EmpIdBtn.delegate = self
        self.pinBtn.delegate = self
        self.pinBtn.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
           // Unregister from notifications
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
       }
    
    func getDeviceID() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
           updateLoginButtonState()
       }
    
    
    @IBAction func continueClickBtn(_ sender: Any) {
        self.callLoginByEmpIDFCMService()
       

    }
    
    func updateLoginButtonState() {
           if let text =  self.pinBtn.text, !text.isEmpty {
               // Change the button color when the text field is not empty
               continueBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1) // Or any color you like
               continueBtn.isEnabled = true
           } else {
               // Revert the button color when the text field is empty
               continueBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
               continueBtn.isEnabled = false
           }
       }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            // Adjust the button's position by moving it up by the height of the keyboard
            UIView.animate(withDuration: 0.3, animations: {
                self.continueBtn.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 21)
                // Adding +20 for some padding between the button and the keyboard
            })
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        // Move the button back to its original position
        UIView.animate(withDuration: 0.3, animations: {
            self.continueBtn.transform = .identity
        })
    }

}
