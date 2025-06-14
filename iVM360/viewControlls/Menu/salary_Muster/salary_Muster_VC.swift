//
//  salary_Muster_VC.swift
//  iVM360
//
//  Created by 1707 on 27/02/25.
//

import UIKit
import DropDown

class salary_Muster_VC: UIViewController, CustomAlertDelegate {

    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
   

    @IBOutlet weak var salary_MusteryearStatusBtn: UIButton!
    @IBOutlet weak var salary_MustermonthsStatusBtn: UIButton!
    @IBOutlet weak var salary_MustersubmitStatusBtn: UIButton!
    @IBOutlet weak var salary_MusterTitle: UILabel!
    @IBOutlet weak var salary_MusterDetailTableView: UITableView!
    @IBOutlet weak var salary_MusterHeaderView: UIView!
    @IBOutlet weak var salary_MusterpendingLbl: UILabel!
    
    
    var isleaveStatusBack = Bool()
    var isleaveRecordBack = Bool()
    var isClickMusterBack = Bool()
//    var LeaveStatusData = [Leave_Status_Modal]()
    let salary_MusterdropDownyears = DropDown()
    let salary_MusterdropDownMonths = DropDown()
    var salary_MusteryearArray = ["2024", "2025"]
    var salary_MusteryearString = String()
    var salary_MustermonthsString = String()
    var salary_MusterMonthsArray = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    var salary_MusterAutoId = String()
    var auth_Token = String()
    var salaryPdfLink = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.salary_MusterDetailTableView.isHidden = true
        self.salary_MusterHeaderView.isHidden = true
        if self.isClickMusterBack == true{
            self.salary_MusterTitle.text = "Salary"
        }else{
            self.salary_MusterTitle.text = "Musters"
        }
        self.salary_MusteryearStatusBtn.layer.cornerRadius = 5
        self.salary_MustermonthsStatusBtn.layer.cornerRadius = 5
        self.salary_MustersubmitStatusBtn.layer.cornerRadius = 5
        salary_MusterdropDownyears.cornerRadius = 5
        salary_MusterdropDownyears.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        salary_MusterdropDownyears.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.salary_MusterdropDownyears.dataSource = self.salary_MusteryearArray
       
        salary_MusterdropDownyears.anchorView = self.salary_MusteryearStatusBtn
        salary_MusterdropDownyears.bottomOffset = CGPoint(x: -1, y: self.salary_MusteryearStatusBtn.bounds.height)
        salary_MusterdropDownyears.selectionAction = { [unowned self] (index: Int, item: String) in
            self.salary_MusteryearStatusBtn.setTitle(item, for: .normal)
            self.salary_MusteryearString = self.salary_MusteryearArray[index]
            
        }
        salary_MusterdropDownMonths.cornerRadius = 5
        salary_MusterdropDownMonths.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        salary_MusterdropDownMonths.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.salary_MusterdropDownMonths.dataSource = self.salary_MusterMonthsArray
        salary_MusterdropDownMonths.anchorView = self.salary_MustermonthsStatusBtn
        salary_MusterdropDownMonths.bottomOffset = CGPoint(x: -1, y: self.salary_MustermonthsStatusBtn.bounds.height)
        salary_MusterdropDownMonths.selectionAction = { [unowned self] (index: Int, item: String) in
            self.salary_MustermonthsStatusBtn.setTitle(item, for: .normal)
            self.salary_MustermonthsString = self.salary_MusterMonthsArray[index]
        }
        
        
        
        
    }
    
    @IBAction func salary_MusterBackclickButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func salary_MusterClickYearButton(_ sender: Any) {
        salary_MusterdropDownyears.show()
    }
    @IBAction func salary_MusterClickMonthsButton(_ sender: Any) {
        salary_MusterdropDownMonths.show()
    }
    @IBAction func salary_MusterClickSubmitButton(_ sender: Any) {
        if self.isClickMusterBack == true{
            self.callGenerationService()
        }else{
            self.callAttendanceMusterService()
        }
    }

}
