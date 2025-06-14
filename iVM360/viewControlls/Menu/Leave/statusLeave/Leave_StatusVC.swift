//
//  Leave_StatusVC.swift
//  iVM360
//
//  Created by 1707 on 03/09/24.
//

import UIKit
import DropDown
class Leave_StatusVC: UIViewController, UITableViewDelegate, UITableViewDataSource,CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
   

    @IBOutlet weak var leaveyearStatusBtn: UIButton!
    @IBOutlet weak var leavemonthsStatusBtn: UIButton!
    @IBOutlet weak var leavesubmitStatusBtn: UIButton!
    @IBOutlet weak var leaveTitle: UILabel!
    @IBOutlet weak var leaveDetailTableView: UITableView!
    @IBOutlet weak var leaveHeaderView: UIView!
    @IBOutlet weak var pendingLbl: UILabel!
    
    
    var isleaveStatusBack = Bool()
    var isleaveRecordBack = Bool()
    var LeaveStatusData = [Leave_Status_Modal]()
    let dropDownyears = DropDown()
    let dropDownMonths = DropDown()
    var yearArray = ["2024", "2025"]
    var yearString = String()
    var monthsString = String()
    var MonthsArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var LeaveAutoId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leaveyearStatusBtn.layer.cornerRadius = 5
        self.leavemonthsStatusBtn.layer.cornerRadius = 5
        self.leavesubmitStatusBtn.layer.cornerRadius = 5
        dropDownyears.cornerRadius = 5
        dropDownyears.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDownyears.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.dropDownyears.dataSource = self.yearArray
       
        dropDownyears.anchorView = self.leaveyearStatusBtn
        dropDownyears.bottomOffset = CGPoint(x: -1, y: self.leaveyearStatusBtn.bounds.height)
        dropDownyears.selectionAction = { [unowned self] (index: Int, item: String) in
            self.leaveyearStatusBtn.setTitle(item, for: .normal)
            self.yearString = self.yearArray[index]
            
        }
        dropDownMonths.cornerRadius = 5
        dropDownMonths.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDownMonths.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.dropDownMonths.dataSource = self.MonthsArray
        dropDownMonths.anchorView = self.leavemonthsStatusBtn
        dropDownMonths.bottomOffset = CGPoint(x: -1, y: self.leavemonthsStatusBtn.bounds.height)
        dropDownMonths.selectionAction = { [unowned self] (index: Int, item: String) in
            self.leavemonthsStatusBtn.setTitle(item, for: .normal)
            self.monthsString = self.MonthsArray[index]
        }
        
        
        
        if self.isleaveStatusBack == true && self.isleaveRecordBack == false{
            self.leaveTitle.text = "Leave Staus"
            self.pendingLbl.isHidden = false
           
            
        }else{
            self.leaveTitle.text = "Leave Record"
            self.pendingLbl.isHidden = true
        }
        
      
    }
    
    @IBAction func leaveBackclickButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func leaveClickYearButton(_ sender: Any) {
        dropDownyears.show()
    }
    @IBAction func leaveClickMonthsButton(_ sender: Any) {
        dropDownMonths.show()
    }
    @IBAction func leaveClickSubmitButton(_ sender: Any) {
        if self.isleaveStatusBack == true && self.isleaveRecordBack == false{
            self.callLeaveApplicationStatusService()
        }else{
            self.callLeaveRecordService()
        }
    }
    @objc func leaveDeleteButton(sender: UIButton){
        self.LeaveAutoId = self.LeaveStatusData[sender.tag].AutoId
        self.callLeaveCancellationRequestService()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.LeaveStatusData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Leave_Status_TableCell", for: indexPath) as! Leave_Status_TableCell
            self.leaveDetailTableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        cell.selectionStyle = .none
        if self.isleaveStatusBack == true && self.isleaveRecordBack == false{
            cell.deletebtn.isHidden = false
            cell.deletebtn.tag = indexPath.row
            cell.deletebtn.addTarget(self, action: #selector(leaveDeleteButton), for: .touchUpInside)
            cell.leaveStatuLbl.isHidden = false
            cell.leaveTypeLbl.text = " " + self.LeaveStatusData[indexPath.row].LeaveType
            cell.leaveApplyLbl.text = self.LeaveStatusData[indexPath.row].ApplyDate
            cell.leaveDateLbl.text = self.LeaveStatusData[indexPath.row].FromDate
            cell.leaveStatuLbl.text = self.LeaveStatusData[indexPath.row].LeaveStatus
            
        }else{
            cell.deletebtn.isHidden = true
            cell.leaveStatuLbl.isHidden = true
            cell.leaveTypeLbl.text = " " + self.LeaveStatusData[indexPath.row].LeaveType
            cell.leaveApplyLbl.text = self.LeaveStatusData[indexPath.row].ApplyDate
            cell.leaveDateLbl.text = self.LeaveStatusData[indexPath.row].FromDate
        }
        return cell
    }
  
    
}
extension Leave_StatusVC{
    func callLeaveApplicationStatusService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callLeaveApplicationStatusService()
            }
            return
        }
 
        ActivityView.show(self.view)
        params["connectionKey"]              = "SAMS"
        params["EmployeeID"]                = AppSession.user?.EmpNumber
        params["LocationAutoId"]            = AppSession.user?.LocationAutoID
        params["Year"]                    = self.yearString
        if self.monthsString == "January"{
            params["Month"]     = "01"
        }else if self.monthsString == "February"{
            params["Month"]        = "02"
        }else if self.monthsString == "March"{
            params["Month"]        = "03"
        }else if self.monthsString == "April"{
            params["Month"]        = "04"
        }else if self.monthsString == "May"{
            params["Month"]        = "05"
        }else if self.monthsString == "June"{
            params["Month"]        = "06"
        }else if self.monthsString == "July"{
            params["Month"]        = "07"
        }else if self.monthsString == "August"{
            params["Month"]        = "08"
        }else if self.monthsString == "September"{
            params["Month"]        = "09"
        }else if self.monthsString == "October"{
            params["Month"]        = "10"
        }else if self.monthsString == "November"{
            params["Month"]        = "11"
        }else if self.monthsString == "December"{
            params["Month"]        = "12"
        }
        print(params)
        WebServiceManager.shared.LeaveApplicationStatus(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.LeaveStatusData = data.compactMap({Leave_Status_Modal(withData: $0)})
                        let msg = mainData["Message"] as? String ?? ""
                        if msg == "No Leave Exists !!"{
                            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                            customAlert.delegate = self
                            customAlert.hideBut = true
                            customAlert.logoutBut = false
                            customAlert.onofflineBut = false
                            customAlert.modalPresentationStyle = .overCurrentContext
                            customAlert.providesPresentationContextTransitionStyle = true
                            customAlert.modalTransitionStyle = .crossDissolve
                            customAlert.titlestring = "Alert"
                            customAlert.massage = msg
                            self.present(customAlert, animated: true, completion: nil)
                            ActivityView.hide(self.view)
                        }else{
                            self.leaveDetailTableView.reloadData()
                        }
                        
                        
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
    func callLeaveRecordService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callLeaveRecordService()
            }
            return
        }
 
        ActivityView.show(self.view)
        params["connectionKey"]              = "SAMS"
        params["EmployeeID"]                = AppSession.user?.EmpNumber
        params["LocationAutoId"]            = AppSession.user?.LocationAutoID
        params["Year"]                    = self.yearString
        if self.monthsString == "January"{
            params["Month"]     = "01"
        }else if self.monthsString == "February"{
            params["Month"]        = "02"
        }else if self.monthsString == "March"{
            params["Month"]        = "03"
        }else if self.monthsString == "April"{
            params["Month"]        = "04"
        }else if self.monthsString == "May"{
            params["Month"]        = "05"
        }else if self.monthsString == "June"{
            params["Month"]        = "06"
        }else if self.monthsString == "July"{
            params["Month"]        = "07"
        }else if self.monthsString == "August"{
            params["Month"]        = "08"
        }else if self.monthsString == "September"{
            params["Month"]        = "09"
        }else if self.monthsString == "October"{
            params["Month"]        = "10"
        }else if self.monthsString == "November"{
            params["Month"]        = "11"
        }else if self.monthsString == "December"{
            params["Month"]        = "12"
        }
        print(params)
        WebServiceManager.shared.LeaveRecord(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.LeaveStatusData = data.compactMap({Leave_Status_Modal(withData: $0)})
                        let msg = mainData["Message"] as? String ?? ""
                        if msg == "No Leave Exists !!"{
                            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                            customAlert.delegate = self
                            customAlert.hideBut = true
                            customAlert.logoutBut = false
                            customAlert.onofflineBut = false
                            customAlert.modalPresentationStyle = .overCurrentContext
                            customAlert.providesPresentationContextTransitionStyle = true
                            customAlert.modalTransitionStyle = .crossDissolve
                            customAlert.titlestring = "Alert"
                            customAlert.massage = msg
                            self.present(customAlert, animated: true, completion: nil)
                            ActivityView.hide(self.view)
                        }else{
                            self.leaveDetailTableView.reloadData()
                        }
                        
                       
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
    func callLeaveCancellationRequestService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callLeaveCancellationRequestService()
            }
            return
        }
 
        ActivityView.show(self.view)
        params["connectionKey"]              = "SAMS"
        params["LeaveAutoID"]                = self.LeaveAutoId
        print(params)
        WebServiceManager.shared.LeaveCancellationRequest(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
//                        self.LeaveStatusData = data.compactMap({Leave_Status_Modal(withData: $0)})
//                        self.leaveDetailTableView.reloadData()
                        self.callLeaveApplicationStatusService()
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
