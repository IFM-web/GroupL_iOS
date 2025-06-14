//
//  Attendance_StatusVC.swift
//  iVM360
//
//  Created by 1707 on 12/08/24.
//

import UIKit
import DropDown
class Attendance_StatusVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    

    @IBOutlet weak var yearStatusBtn: UIButton!
    @IBOutlet weak var monthsStatusBtn: UIButton!
    @IBOutlet weak var submitStatusBtn: UIButton!
    @IBOutlet weak var attendanceStatusTableViewBtn: UITableView!
    var AttendanceStatusData = [Attendance_StatusModal]()
    let attendancedropDownyears = DropDown()
    let attendancedropDownMonths = DropDown()
    var yearArray = ["2024", "2025"]
    var yearString = String()
    var monthsString = String()
    var MonthsArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yearStatusBtn.layer.cornerRadius = 5
        self.monthsStatusBtn.layer.cornerRadius = 5
        self.submitStatusBtn.layer.cornerRadius = 5
     
        attendancedropDownyears.cornerRadius = 5
        attendancedropDownyears.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        attendancedropDownyears.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.attendancedropDownyears.dataSource = self.yearArray
       
        attendancedropDownyears.anchorView = self.yearStatusBtn
        attendancedropDownyears.bottomOffset = CGPoint(x: -1, y: self.yearStatusBtn.bounds.height)
        attendancedropDownyears.selectionAction = { [unowned self] (index: Int, item: String) in
            self.yearStatusBtn.setTitle(item, for: .normal)
            self.yearString = self.yearArray[index]
            
        }
        attendancedropDownMonths.cornerRadius = 5
        attendancedropDownMonths.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        attendancedropDownMonths.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.attendancedropDownMonths.dataSource = self.MonthsArray
        attendancedropDownMonths.anchorView = self.monthsStatusBtn
        attendancedropDownMonths.bottomOffset = CGPoint(x: -1, y: self.monthsStatusBtn.bounds.height)
        attendancedropDownMonths.selectionAction = { [unowned self] (index: Int, item: String) in
            self.monthsStatusBtn.setTitle(item, for: .normal)
            self.monthsString = self.MonthsArray[index]
        }
        
        
    }
    
    @IBAction func BackclickButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func ClickYearButton(_ sender: Any) {
        attendancedropDownyears.show()

    }
    @IBAction func ClickMonthsButton(_ sender: Any) {
        attendancedropDownMonths.show()

    }
    @IBAction func ClickSubmitButton(_ sender: Any) {
        self.callAttendanceRegularizationStatusService()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.AttendanceStatusData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Attendance_Status_TableCell", for: indexPath) as! Attendance_Status_TableCell
            self.attendanceStatusTableViewBtn.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        cell.selectionStyle = .none
           
            cell.attendanceStatusDateLbl.text = self.AttendanceStatusData[indexPath.row].Date
            cell.attendanceStatusShiftLbl.text = self.AttendanceStatusData[indexPath.row].Shift
            cell.attendanceStatusSiteLbl.text = self.AttendanceStatusData[indexPath.row].SiteName
            cell.attendanceStatusCheckInTimeLbl.text = self.AttendanceStatusData[indexPath.row].CheckInTime
            cell.attendanceStatusCheckOutTimeLbl.text = self.AttendanceStatusData[indexPath.row].CheckoutTime
            cell.attendanceStatusRemarkLbl.text = self.AttendanceStatusData[indexPath.row].Remarks
            cell.attendanceStatusStatuskLbl.text = self.AttendanceStatusData[indexPath.row].ApprovalStatus

        return cell
    }

}
extension Attendance_StatusVC{
    func callAttendanceRegularizationStatusService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callAttendanceRegularizationStatusService()
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
        WebServiceManager.shared.AttendanceRegularizationStatus(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.AttendanceStatusData = data.compactMap({Attendance_StatusModal(withData: $0)})
                        let masg = mainData["Message"] as? String ?? ""
                        if masg == "No Data Available !!"{
                            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                            customAlert.delegate = self
                            customAlert.hideBut = true
                            customAlert.logoutBut = false
                            customAlert.onofflineBut = false
                            customAlert.modalPresentationStyle = .overCurrentContext
                            customAlert.providesPresentationContextTransitionStyle = true
                            customAlert.modalTransitionStyle = .crossDissolve
                            customAlert.titlestring = "Alert"
                            customAlert.massage = masg
                            self.present(customAlert, animated: true, completion: nil)
                            ActivityView.hide(self.view)
                        }else{
                            self.attendanceStatusTableViewBtn.reloadData()
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
}
