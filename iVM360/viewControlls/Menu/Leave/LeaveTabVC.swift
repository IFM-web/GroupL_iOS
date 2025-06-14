//
//  LeaveTabVC.swift
//  iVM360
//
//  Created by 1707 on 12/08/24.
//

import UIKit

class LeaveTabVC: UIViewController {
    
    @IBOutlet weak var applyLeaveBtn: UIButton!
    @IBOutlet weak var applyLeaveStatusBtn: UIButton!
    @IBOutlet weak var leaveRecordsBtn: UIButton!
    @IBOutlet weak var LeaveTabBackgroundView: UIView!

    
  var isLeaveStatus = false
  var isLeaveRecord = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.applyLeaveBtn.layer.cornerRadius = 5
        self.applyLeaveStatusBtn.layer.cornerRadius = 5
        self.leaveRecordsBtn.layer.cornerRadius = 10
        self.LeaveTabBackgroundView.layer.cornerRadius = 10
    }
    @IBAction func ClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MenuVC") as? MenuVC
//             self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func ClickLeaveApplyButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Leave_TypeTabVC") as? Leave_TypeTabVC
             self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func ClickLeaveStatusButton(_ sender: Any) {
        self.isLeaveRecord = false
        self.isLeaveStatus = true
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Leave_StatusVC") as? Leave_StatusVC
        vc?.isleaveRecordBack = self.isLeaveRecord
        vc?.isleaveStatusBack = self.isLeaveStatus
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func ClickLeaveRecordButton(_ sender: Any) {
        self.isLeaveRecord = true
        self.isLeaveStatus = false
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Leave_StatusVC") as? Leave_StatusVC
        vc?.isleaveRecordBack = self.isLeaveRecord
        vc?.isleaveStatusBack = self.isLeaveStatus
        self.navigationController?.pushViewController(vc!, animated: true)

    }


}
