//
//  Leave_ApplyVC.swift
//  iVM360
//
//  Created by 1707 on 12/08/24.
//

import UIKit
import FSCalendar
class Leave_ApplyVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        if self.leavesuccess == true && self.leaveMasg == "Leave Applied Sucessfully !!"{
            self.navigationController?.popViewController(animated: true)
        }else{
            print("ok")
        }
       
    }
    
    func canceltapBtn() {
        print("Cancel")
    }
    
    @IBOutlet weak var singleLeaveBtn: UIButton!
    @IBOutlet weak var multipleLeaveStatusBtn: UIButton!
    @IBOutlet weak var longLeaveBtn: UIButton!
    @IBOutlet weak var submitStatusBtn: UIButton!
    @IBOutlet weak var leaveStatusBackgroundView: UIView!
    @IBOutlet weak var longFromBtn: UIButton!
    @IBOutlet weak var longToBtn: UIButton!
    @IBOutlet weak var titleFromBtn: UILabel!
    @IBOutlet weak var titleToBtn: UILabel!
    
    var calendar = FSCalendar()
    var islongLeave = false
    var isfrom = false
    var isTo = false
    var issingle = false
    var isMultiple = false
    var singleselectionDate = String()
    var multipleSelectionDate = [Date]()
    var multipleselectDateStringArray = [String]()
    var longselectDateArray = [String]()
//    var fromDate = String()
//    var toDate = String()
    var fromDate: String?
    var toDate: String?
    var LeaveJson = [[String:Any]]()
    var isCLback = Bool()
    var isELback = Bool()
    var leavesuccess = false
    var leaveMasg = String()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.longLeaveBtn.isEnabled = false
        self.multipleLeaveStatusBtn.isEnabled = false
        self.longFromBtn.isHidden = true
        self.longToBtn.isHidden = true
        self.titleToBtn.isHidden = true
        self.titleFromBtn.isHidden = true
        self.islongLeave = false
        self.issingle = true
        self.isMultiple = false
        self.singleLeaveBtn.layer.cornerRadius = 5
        self.multipleLeaveStatusBtn.layer.cornerRadius = 5
        self.longLeaveBtn.layer.cornerRadius = 5
        singleLeaveBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
        singleLeaveBtn.tintColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        self.singleLeaveBtn.setTitleColor(UIColor.white, for: .normal)
        showCalendar()
        calendar.scrollEnabled = false
        calendar.allowsMultipleSelection = false
        calendar.delegate = self
        calendar.dataSource = self
         calendar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        calendar.layer.borderColor = UIColor.gray.cgColor
        calendar.layer.borderWidth = 1
        self.view.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
    
        let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "calendar")
            imageAttachment.bounds = CGRect(x: 0, y: -3.0, width: 25, height: 25)
            let imageString = NSAttributedString(attachment: imageAttachment)
            let initialTitle = NSMutableAttributedString()
            initialTitle.append(imageString)

    }
    
    @objc func showCalendar() {
        let targetOriginY = self.longFromBtn.frame.maxY
            let calendarHeight: CGFloat = 300
            let calendarWidth = self.view.frame.width
        self.calendar.frame = CGRect(x: 0, y: targetOriginY + 180, width: calendarWidth, height: calendarHeight)
              
            UIView.animate(withDuration: 0.3) {
                self.calendar.frame = CGRect(x:0, y: targetOriginY + 180 , width: calendarWidth, height: calendarHeight)
            }
                
//            UIView.animate(withDuration: 0.3) {
//                self.calendar.frame = CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300)
//            }
        }
    
    // FSCalendar Delegate Methods
//        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//       
//            let formatter = DateFormatter()
//               formatter.dateFormat = "dd MMM yyyy"
//            let formattedDateString = formatter.string(from: date)
//            if self.isfrom == true && self.islongLeave == true{
//                self.longFromBtn.setTitle(formattedDateString, for: .normal)
//                self.fromDate = formattedDateString
//            }else if self.isTo == true && self.islongLeave == true{
//
//                self.longToBtn.setTitle(formattedDateString, for: .normal)
//                self.toDate = formattedDateString
//            }else if self.issingle == true{
//                self.singleselectionDate = formattedDateString
//            }else if self.isMultiple == true{
//                if let selectedDates = calendar.selectedDates as? [Date]{
//                    self.multipleSelectionDate = selectedDates
//                    let formatter = DateFormatter()
//                       formatter.dateFormat = "dd MMM yyyy"
//                    for multipledateStringArray in self.multipleSelectionDate{
//                        let formattedDateString = formatter.string(from: multipledateStringArray)
//                       
//                    }
//                    self.multipleselectDateStringArray.append(formattedDateString)
//                    
//                }
//            }else{
//                UIView.animate(withDuration: 0.3) {
//                    self.calendar.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300)
//                }
//
//            }
//        
//
//
//        }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
       
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let formattedDateString = formatter.string(from: date)
//        // Ensure the calendar always stays on the current month
//        if monthPosition != .current {
//            calendar.setCurrentPage(date, animated: true)
//        }

        // Disable calendar scrolling
        calendar.scrollEnabled = false
        if self.isfrom == true && self.islongLeave == true {
            // Handle 'From' date for long leave
            self.longFromBtn.setTitle(formattedDateString, for: .normal)
            self.fromDate = formattedDateString
            
            // Deselect previously selected range if any
            if let toDate = self.toDate, !toDate.isEmpty {
                deselectRangeInCalendar(calendar: calendar)
            }
            
        } else if self.isTo == true && self.islongLeave == true {
            func selectRangeInCalendar(calendar: FSCalendar, from startDate: Date, to endDate: Date) -> [String] {
                var currentDate = startDate
                let calendarSystem = Calendar.current
                var selectedDates: [String] = []
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                
                while currentDate <= endDate {
                    calendar.select(currentDate)
                    let formattedDate = formatter.string(from: currentDate)
                    selectedDates.append(formattedDate)
                    currentDate = calendarSystem.date(byAdding: .day, value: 1, to: currentDate)!
                }
                
                return selectedDates
            }
            self.longToBtn.setTitle(formattedDateString, for: .normal)
            self.toDate = formattedDateString
            
            // Select and highlight the range
            if let fromDateString = self.fromDate, let fromDate = formatter.date(from: fromDateString) {
                if date >= fromDate {
                    let selectedDates = selectRangeInCalendar(calendar: calendar, from: fromDate, to: date)
                    print(selectedDates)
                    self.longselectDateArray.append(contentsOf: selectedDates)
                } else {
                    // Handle error if 'To' date is before 'From' date
                    // Example: Show an alert or reset selection
                }
            }
            
        } else if self.issingle == true {
            // Handle single date selection
            self.singleselectionDate = formattedDateString
            
        } else if self.isMultiple == true {
            // Handle multiple date selection
            if let selectedDates = calendar.selectedDates as? [Date] {
                self.multipleSelectionDate = selectedDates
//                self.multipleselectDateStringArray.removeAll()
                
                for multipledate in selectedDates {
                    let formattedDateString = formatter.string(from: multipledate)
                    self.multipleselectDateStringArray.append(formattedDateString)
                }
            }
        } else {
            // Default case: animate calendar dismissal or any other necessary action
            UIView.animate(withDuration: 0.3) {
                self.calendar.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300)
            }
        }
    }

    func selectRangeInCalendar(calendar: FSCalendar, from startDate: Date, to endDate: Date) {
        var currentDate = startDate
        let calendarSystem = Calendar.current
        
        while currentDate <= endDate {
            calendar.select(currentDate)
            currentDate = calendarSystem.date(byAdding: .day, value: 1, to: currentDate)!
        }
    }

    func deselectRangeInCalendar(calendar: FSCalendar) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        
        if let fromDateString = self.fromDate, let toDateString = self.toDate,
           let fromDate = formatter.date(from: fromDateString),
           let toDate = formatter.date(from: toDateString) {
            var currentDate = fromDate
            let calendarSystem = Calendar.current
            
            while currentDate <= toDate {
                calendar.deselect(currentDate)
                currentDate = calendarSystem.date(byAdding: .day, value: 1, to: currentDate)!
            }
        }
    }


 
   

    
    @IBAction func ClickBackkkButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func ClicksingleButton(_ sender: Any) {
        deselectAllDates()
        self.titleToBtn.isHidden = true
        self.titleFromBtn.isHidden = true
        self.longFromBtn.isHidden = true
        self.longToBtn.isHidden = true
        self.islongLeave = false
        self.issingle = true
        self.isMultiple = false

        calendar.isHidden = false

        calendar.allowsMultipleSelection = false
        showCalendar()
           resetButtonColors()
        singleLeaveBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
        singleLeaveBtn.tintColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        self.singleLeaveBtn.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func ClickLongButton(_ sender: Any) {
        deselectAllDates()
        calendar.isHidden = true
        self.islongLeave = true
        self.issingle = false
        self.titleToBtn.isHidden = false
        self.titleFromBtn.isHidden = false
        self.longFromBtn.isHidden = false
        self.longToBtn.isHidden = false
       

        calendar.allowsMultipleSelection = false
           resetButtonColors()
        longLeaveBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
        longLeaveBtn.tintColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        self.longLeaveBtn.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func ClickMultipleButton(_ sender: Any) {
        self.multipleselectDateStringArray.removeAll()
        deselectAllDates()
        calendar.isHidden = false
        calendar.allowsMultipleSelection = true
        self.issingle = false
        self.islongLeave = false
        self.isMultiple = true
        self.titleToBtn.isHidden = true
        self.titleFromBtn.isHidden = true
        self.longFromBtn.isHidden = true
        self.longToBtn.isHidden = true

        showCalendar()
           resetButtonColors()
            multipleLeaveStatusBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
        multipleLeaveStatusBtn.tintColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        self.multipleLeaveStatusBtn.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func ClicklongFromButton(_ sender: Any) {
        deselectAllDates()
        self.islongLeave = true
        self.isfrom = true
        self.isTo = false
        self.issingle = false
        self.isMultiple = false
        self.titleToBtn.isHidden = false
        self.titleFromBtn.isHidden = false
        self.longFromBtn.isHidden = false
        self.longToBtn.isHidden = false
        calendar.isHidden = false

        showCalendar()
        
    }
    @IBAction func ClicklongToButton(_ sender: Any) {
//        deselectAllDates()
        calendar.allowsMultipleSelection = true
        self.islongLeave = true
        self.issingle = false
        self.isMultiple = false
        self.isfrom = false
        self.isTo = true
        self.titleToBtn.isHidden = false
        self.titleFromBtn.isHidden = false
        self.longFromBtn.isHidden = false
        self.longToBtn.isHidden = false
        showCalendar()
       
        calendar.isHidden = false

    }
    @IBAction func ClickfinalSubmitButton(_ sender: Any) {
        if self.issingle == true{
            self.callApplyForLeaveService()
        }else if self.isMultiple == true{
            self.LeaveJson.removeAll()
            for Multipleselectdate in self.multipleselectDateStringArray{
                if self.isCLback == true && self.isELback == false{
                    var Ans = ["EmployeeID":AppSession.user?.EmpNumber ?? "",
                       "LocationAutoId":AppSession.user?.LocationAutoID ?? "",
                       "LeaveType":"CL",
                        "LeaveReason": "Casual Leave",
                        "FromDateTime": Multipleselectdate,
                       "ToDateTime": Multipleselectdate]
                    self.LeaveJson.append(Ans)
                }else{
                    var Ans = ["EmployeeID":AppSession.user?.EmpNumber ?? "",
                       "LocationAutoId":AppSession.user?.LocationAutoID ?? "",
                       "LeaveType":"EL",
                        "LeaveReason": "Earn Leave",
                        "FromDateTime": Multipleselectdate,
                       "ToDateTime": Multipleselectdate]
                    self.LeaveJson.append(Ans)
                }
                
            }
            print(self.LeaveJson)
            self.callApplyMultipleLeavesService()
        }else if self.isTo == true && self.islongLeave == true {
            for longleaveSelectDate in self.longselectDateArray{
                if self.isCLback == true && self.isELback == false{
                    var Ans = ["EmployeeID":AppSession.user?.EmpNumber ?? "",
                       "LocationAutoId":AppSession.user?.LocationAutoID ?? "",
                       "LeaveType":"CL",
                        "LeaveReason": "Casual Leave",
                        "FromDateTime": longleaveSelectDate,
                       "ToDateTime": longleaveSelectDate]
                    self.LeaveJson.append(Ans)
                }else{
                    var Ans = ["EmployeeID":AppSession.user?.EmpNumber ?? "",
                       "LocationAutoId":AppSession.user?.LocationAutoID ?? "",
                       "LeaveType":"EL",
                        "LeaveReason": "Earn Leave",
                        "FromDateTime": longleaveSelectDate,
                       "ToDateTime": longleaveSelectDate]
                    self.LeaveJson.append(Ans)
                }
                
            }
            print(self.LeaveJson)
            self.callApplyMultipleLeavesService()
        }
       
    }

    func resetButtonColors() {
        // Reset background color and tint color for singleLeaveBtn
        self.singleLeaveBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        self.singleLeaveBtn.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.singleLeaveBtn.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)

        // Reset background color and tint color for multipleLeaveStatusBtn
        self.multipleLeaveStatusBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        self.multipleLeaveStatusBtn.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.multipleLeaveStatusBtn.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)

        // Reset background color and tint color for longLeaveBtn
        self.longLeaveBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        self.longLeaveBtn.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.longLeaveBtn.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
    }
    
    func deselectAllDates() {
        let selectedDates = calendar.selectedDates
        for date in selectedDates {
            calendar.deselect(date)
        }
    }


}
extension Leave_ApplyVC{
    
    func callApplyForLeaveService(){
        var params: [String: Any] = [:]

        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callApplyForLeaveService()
            }
            return
        }
    
        ActivityView.show(self.view)
        params["connectionKey"]              = "SAMS"
        params["EmployeeID"]                = AppSession.user?.EmpNumber
        params["LocationAutoId"]             =  AppSession.user?.LocationAutoID
        if self.isCLback == true && self.isELback == false{
            params["LeaveType"]                 = "CL"
            params["LeaveReason"]               = "Casual Leave"
        }else{
            params["LeaveType"]                 = "EL"
            params["LeaveReason"]               = "Earn Leave"
        }
        
        params["FromDateTime"]              =  self.singleselectionDate
        params["ToDateTime"]                =  self.singleselectionDate

        WebServiceManager.shared.ApplyForLeave(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.leaveMasg = mainData["Message"] as? String ?? ""
                        self.leavesuccess = true
                        let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                        customAlert.delegate = self
                        customAlert.hideBut = true
                        customAlert.logoutBut = false
                        customAlert.onofflineBut = false
                        customAlert.modalPresentationStyle = .overCurrentContext
                        customAlert.providesPresentationContextTransitionStyle = true
                        customAlert.modalTransitionStyle = .crossDissolve
                        customAlert.titlestring = "Alert"
                        customAlert.massage = self.leaveMasg
                        self.present(customAlert, animated: true, completion: nil)
                        ActivityView.hide(self.view)
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
    
    func callApplyMultipleLeavesService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callApplyMultipleLeavesService()
            }
            return
        }
 
        ActivityView.show(self.view)
        params["connectionKey"]              = "SAMS"
        params["Json"]                = self.LeaveJson.toJSONString
        print(params)
        WebServiceManager.shared.ApplyMultipleLeaves(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        
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

