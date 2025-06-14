//
//  LoginTabVC.swift
//  iVM360
//
//  Created by 1707 on 15/07/24.
//

import UIKit

class LoginTabVC: UIViewController {
    @IBOutlet weak var loginByPhoneBtn: UIButton!
    
    @IBOutlet weak var loginbyEmpCodeBtn: UIButton!
    var isNewRegistration_Back = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.loginByPhoneBtn.isHidden = true
        if self.isNewRegistration_Back == true{
            self.loginbyEmpCodeBtn.setTitle("Login by Employee Code", for: .normal)
            self.loginByPhoneBtn.setTitle("Login by Phone", for: .normal)
        }else{
            self.loginbyEmpCodeBtn.setTitle("Sign up by Employee Code", for: .normal)
            self.loginByPhoneBtn.setTitle("Sign up by Mobile", for: .normal)
        }
        self.loginByPhoneBtn.layer.cornerRadius = 5
        self.loginbyEmpCodeBtn.layer.cornerRadius = 5
    }
    
    @IBAction func phoneClickBtn(_ sender: Any) {
        
        
    }
    @IBAction func empCodeClickBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginImpIdVC") as? LoginImpIdVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
