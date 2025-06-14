//
//  MenuVC.swift
//  iVM360
//
//  Created by 1707 on 16/07/24.
//

import UIKit

class MenuVC: UIViewController {
    @IBOutlet weak var salaryBtn: UIButton!
    @IBOutlet weak var attendanceBtn: UIButton!
    @IBOutlet weak var leavesBtn: UIButton!
    @IBOutlet weak var musterBtn: UIButton!
    @IBOutlet weak var myDocBtn: UIButton!
    @IBOutlet weak var contactBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    
     var isClickMuster = false
    override func viewDidLoad() {
        super.viewDidLoad()
//        salaryBtn.isHidden = true
//        musterBtn.isHidden = true
//        myDocBtn.isHidden = true
//        contactBtn.isHidden = true
//        profileBtn.isHidden = true
//        notificationBtn.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.salaryBtn.layer.cornerRadius = 10
        self.attendanceBtn.layer.cornerRadius = 10
        self.leavesBtn.layer.cornerRadius = 10
        self.musterBtn.layer.cornerRadius = 10
        self.myDocBtn.layer.cornerRadius = 10
        self.contactBtn.layer.cornerRadius = 10
        self.profileBtn.layer.cornerRadius = 10
        self.notificationBtn.layer.cornerRadius = 10
      
    }
    override func viewWillAppear(_ animated: Bool) {
        self.isClickMuster = false
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func attendanceClickBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AttendanceTabVC") as? AttendanceTabVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func LeaveClickBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LeaveTabVC") as? LeaveTabVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func salaryClickBtn(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "salary_Muster_VC") as? salary_Muster_VC
//        self.isClickMuster = true
//        vc?.isClickMusterBack = self.isClickMuster
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func ERegisterClickBtn(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterVC") as? RegisterVC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func ProfileClickBtn(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Profile_VC") as? Profile_VC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func MusterClickBtn(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "salary_Muster_VC") as? salary_Muster_VC
//        self.isClickMuster = false
//        vc?.isClickMusterBack = self.isClickMuster
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func uniformsClickBtn(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EngineeringAuditVC") as? EngineeringAuditVC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func DocClickBtn(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Appointment_Letter_VC") as? Appointment_Letter_VC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
