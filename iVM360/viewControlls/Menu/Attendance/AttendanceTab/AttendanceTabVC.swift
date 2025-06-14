//
//  AttendanceTabVC.swift
//  iVM360
//
//  Created by 1707 on 10/08/24.
//

import UIKit

class AttendanceTabVC: UIViewController, CustomAlertDelegate{
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    @IBOutlet weak var attendanceregulationBtn: UIButton!
    @IBOutlet weak var attendanceStatusBtn: UIButton!
    @IBOutlet weak var TabBackgroundView: UIView!

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.attendanceregulationBtn.layer.cornerRadius = 5
        self.attendanceStatusBtn.layer.cornerRadius = 5
        self.TabBackgroundView.layer.cornerRadius = 10
        

        
       
    }
    
    @IBAction func backclickButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func regulationButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Attendance_RegulerigationVC") as? Attendance_RegulerigationVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func RegStatusButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Attendance_StatusVC") as? Attendance_StatusVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

