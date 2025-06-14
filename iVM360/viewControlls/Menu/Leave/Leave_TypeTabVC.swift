//
//  Leave_TypeTabVC.swift
//  iVM360
//
//  Created by 1707 on 12/08/24.
//

import UIKit

class Leave_TypeTabVC: UIViewController {
    @IBOutlet weak var casulLeaveBtn: UIButton!
    @IBOutlet weak var earnLeaveBtn: UIButton!
    @IBOutlet weak var LeaveTabBackgroundView: UIView!
    
    
    var isCL = false
    var isEL = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.casulLeaveBtn.layer.cornerRadius = 5
        self.earnLeaveBtn.layer.cornerRadius = 5
        self.LeaveTabBackgroundView.layer.cornerRadius = 10

        
    }
    
    @IBAction func ClickCasualLeaveButton(_ sender: Any) {
        self.isCL = true
        self.isEL = false
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Leave_ApplyVC") as? Leave_ApplyVC
        vc?.isCLback = self.isCL
        vc?.isELback = self.isEL
              self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func ClickEarnLeaveButton(_ sender: Any) {
        self.isCL = false
        self.isEL = true
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Leave_ApplyVC") as? Leave_ApplyVC
        vc?.isCLback = self.isCL
        vc?.isELback = self.isEL
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func ClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Attendance_StatusVC") as? Attendance_StatusVC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }


}
