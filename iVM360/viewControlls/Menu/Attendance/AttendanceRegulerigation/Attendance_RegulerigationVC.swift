//
//  Attendance_RegulerigationVC.swift
//  iVM360
//
//  Created by 1707 on 09/08/24.
//

import UIKit
import DropDown
import FSCalendar
class Attendance_RegulerigationVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, CustomAlertDelegate{
    func okTapBtn(islogout: Int, text: String) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MenuVC") as? MenuVC
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func canceltapBtn() {
        print("ok")
    }
    

    @IBOutlet weak var continueBtN: UIButton!
    @IBOutlet weak var calendarBtn: UIButton!
    @IBOutlet weak var attendSiteBtn: UIButton!
    @IBOutlet weak var attendShiftBtn: UIButton!
    @IBOutlet weak var fristFld: UITextField!
    @IBOutlet weak var secondFld: UITextField!
    @IBOutlet weak var attendBackgroundView: UIView!
    @IBOutlet weak var attendTextView: UITextView!
    @IBOutlet weak var textviewTitle: UILabel!
    
    var calendar = FSCalendar()
    let dropDown_Site = DropDown()
    let dropDown_Shift = DropDown()
    var RegSiteListData = [SitesList]()
    var RegShiftListData = [ShiftsfList]()
    var RegsiteNamelist = [String]()
    var RegshiftNameList = [String]()

    var SelectedSiteNameLIst = SitesList()
    var SelectedShiftsNameLIst = ShiftsfList()
    var dateGiven = String()
    var siteName = String()
    var shiftName = String()
    var firstFldName = String()
    var secondFldName = String()
    var remarks = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        calendar = FSCalendar(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 300))
               calendar.delegate = self
               calendar.dataSource = self
                calendar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
               self.view.addSubview(calendar)
              calendar.scrollEnabled = false
        
        self.textviewTitle.isHidden = true
        self.attendBackgroundView.layer.cornerRadius = 10
        self.continueBtN.layer.cornerRadius = 5
        self.calendarBtn.layer.cornerRadius = 5
        self.calendarBtn.layer.borderWidth = 1.5
        self.calendarBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.7139031291, blue: 0.225849092, alpha: 1)
        let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "calendar")
            imageAttachment.bounds = CGRect(x: 0, y: -3.0, width: 25, height: 25)
            let imageString = NSAttributedString(attachment: imageAttachment)
            let initialTitle = NSMutableAttributedString()
            initialTitle.append(imageString)
            calendarBtn.setAttributedTitle(initialTitle, for: .normal)
        self.attendSiteBtn.layer.cornerRadius = 5
        self.attendShiftBtn.layer.cornerRadius = 5
        self.attendTextView.layer.cornerRadius = 5
        self.attendTextView.layer.borderWidth = 1.5
        self.attendTextView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.callGetEmpMappedSitesService()
//        self.dropDown_Site.dataSource = self.SiteNameLIst
//        self.dropDown_Shift.dataSource = self.ShiftsNameLIst
        dropDown_Site.cornerRadius = 5
        dropDown_Site.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown_Site.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown_Site.anchorView = self.attendSiteBtn
        dropDown_Site.bottomOffset = CGPoint(x: -1, y: self.attendSiteBtn.bounds.height)
        dropDown_Site.selectionAction = { [unowned self] (index: Int, item: String) in
            self.attendSiteBtn.setTitle(item, for: .normal)
            self.SelectedSiteNameLIst = self.RegSiteListData[index]
            self.callGetEmployeeAttendanceDailyWithShiftService()
        }
        
        dropDown_Shift.cornerRadius = 5
        dropDown_Shift.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown_Shift.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown_Shift.anchorView = self.attendShiftBtn
        dropDown_Shift.bottomOffset = CGPoint(x: -1, y: self.attendShiftBtn.bounds.height)
        dropDown_Shift.selectionAction = { [unowned self] (index: Int, item: String) in
            self.attendShiftBtn.setTitle(item, for: .normal)
            self.SelectedShiftsNameLIst = self.RegShiftListData[index]
        }
  
    }
   
    @objc func showCalendar() {
        let targetOriginY = self.calendarBtn.frame.maxY
            let calendarHeight: CGFloat = 300
            let calendarWidth = self.view.frame.width
        self.calendar.frame = CGRect(x: 0, y: targetOriginY + 110, width: calendarWidth, height: calendarHeight)
              
            UIView.animate(withDuration: 0.3) {
                self.calendar.frame = CGRect(x:0, y: targetOriginY + 110 , width: calendarWidth, height: calendarHeight)
            }
                
//            UIView.animate(withDuration: 0.3) {
//                self.calendar.frame = CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300)
//            }
        }
    
    // FSCalendar Delegate Methods
//        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//            print("Selected date: \(date)")
//            let formatter = DateFormatter()
//               formatter.dateFormat = "dd MMM yyyy"
//            let formattedDateString = formatter.string(from: date)
//            self.dateGiven = "\(formattedDateString)"
//              // Create an image attachment
//               let imageAttachment = NSTextAttachment()
//               imageAttachment.image = UIImage(systemName: "calendar") // Replace with your desired image
//               
//            let imageSize: CGFloat = 20
//                let imageOffsetY: CGFloat = -2.0 // Adjust vertical positioning if needed
//                imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageSize, height: imageSize)
//            
//            let imageString = NSAttributedString(attachment: imageAttachment)
//                let dateString = NSAttributedString(string: " \(formattedDateString)", attributes: [
//                    .foregroundColor: UIColor.black,
//                    .font: UIFont.systemFont(ofSize: 16) // Set font size to 18
//                ])
//            
//            
//               // Combine the image and the text
//               let fullString = NSMutableAttributedString()
//               fullString.append(imageString)
//               fullString.append(dateString)
//               // Set the button's title with the combined image and text
//               self.calendarBtn.setAttributedTitle(fullString, for: .normal)
//            self.calendarBtn.setTitleColor(.black, for: .normal)
//            UIView.animate(withDuration: 0.3) {
//                self.calendar.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300)
//            }
//        }
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        print("Selected date: \(date)")
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd MMM yyyy"
//        let formattedDateString = formatter.string(from: date)
//        self.dateGiven = formattedDateString
//        
//        // Ensure the calendar always stays on the current month
//        if monthPosition != .current {
//            calendar.setCurrentPage(date, animated: true)
//        }
//
//        // Create an image attachment
//        let imageAttachment = NSTextAttachment()
//        imageAttachment.image = UIImage(systemName: "calendar") // Replace with your desired image
//        
//        let imageSize: CGFloat = 20
//        let imageOffsetY: CGFloat = -2.0 // Adjust vertical positioning if needed
//        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageSize, height: imageSize)
//        
//        let imageString = NSAttributedString(attachment: imageAttachment)
//        let dateString = NSAttributedString(string: " \(formattedDateString)", attributes: [
//            .foregroundColor: UIColor.black,
//            .font: UIFont.systemFont(ofSize: 16)
//        ])
//        
//        // Combine the image and the text
//        let fullString = NSMutableAttributedString()
//        fullString.append(imageString)
//        fullString.append(dateString)
//        
//        // Set the button's title with the combined image and text
//        self.calendarBtn.setAttributedTitle(fullString, for: .normal)
//        self.calendarBtn.setTitleColor(.black, for: .normal)
//        
//        UIView.animate(withDuration: 0.3) {
//            self.calendar.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300)
//        }
//    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected date: \(date)")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let formattedDateString = formatter.string(from: date)
        self.dateGiven = formattedDateString

        // Ensure the calendar always stays on the current month
        if monthPosition != .current {
            calendar.setCurrentPage(date, animated: true)
        }

        // Disable calendar scrolling
        calendar.scrollEnabled = false

        // Create an image attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "calendar") // Replace with your desired image
        
        let imageSize: CGFloat = 20
        let imageOffsetY: CGFloat = -2.0 // Adjust vertical positioning if needed
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageSize, height: imageSize)
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        let dateString = NSAttributedString(string: " \(formattedDateString)", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16)
        ])
        
        // Combine the image and the text
        let fullString = NSMutableAttributedString()
        fullString.append(imageString)
        fullString.append(dateString)
        
        // Set the button's title with the combined image and text
        self.calendarBtn.setAttributedTitle(fullString, for: .normal)
        self.calendarBtn.setTitleColor(.black, for: .normal)
        
        UIView.animate(withDuration: 0.3) {
            self.calendar.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300)
        }
    }

    @IBAction func LeaveClickBtn(_ sender: Any) {
        self.callAttendanceRegularizationService()
    }
    @IBAction func CalendarClickBtn(_ sender: Any) {
        showCalendar()
    }
    
    @IBAction func siteDropDownClick(_ sender: Any) {
        dropDown_Site.show()
    }
    @IBAction func shiftDropDwonClick(_ sender: Any) {
        dropDown_Shift.show()
    }
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
extension Attendance_RegulerigationVC{
    func callAttendanceRegularizationService(){
        var params: [String: Any] = [:]
        if self.attendTextView.text == "Enter your remarks"{
            self.remarks = ""
        }else{
            self.remarks = self.attendTextView.text
        }
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callAttendanceRegularizationService()
            }
            return
        }
    
        ActivityView.show(self.view)
        params["connectionKey"]             = "SAMS"
        params["ClientCode"]                  =  self.SelectedSiteNameLIst.ClientCode
        params["AsmtID"]                 =  self.SelectedSiteNameLIst.AsmtId
        params["ClientSiteName"]               =  self.SelectedSiteNameLIst.ClientSiteName
        params["EmployeeID"]               = AppSession.user?.EmpNumber
        params["EmployeeName"]                  =  AppSession.user?.EmpName
        params["Designation"]                =  AppSession.user?.Designation
        params["LocationAutoId"]               =  AppSession.user?.LocationAutoID
        params["Date"]                    = self.dateGiven
        params["FromTime"]               = self.fristFld.text
        params["ToTime"]                  =  self.secondFld.text
        params["Remarks"]                =  self.remarks
        params["ShiftCode"]               =  self.SelectedShiftsNameLIst.ShiftCode
        params["ShiftDetails"]               = self.SelectedShiftsNameLIst.ShiftDetails
        
        
        print(params)
        WebServiceManager.shared.AttendanceRegularization(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        let msgg = mainData["Message"] as? String ?? ""
                        let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                            customAlert.delegate = self
                            customAlert.hideBut = true
                            customAlert.logoutBut = false
                            customAlert.onofflineBut = false
                            customAlert.modalPresentationStyle = .overCurrentContext
                            customAlert.providesPresentationContextTransitionStyle = true
                            customAlert.modalTransitionStyle = .crossDissolve
                            customAlert.titlestring = "Alert!"
                            customAlert.massage = msgg
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
    
    func callGetEmpMappedSitesService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetEmpMappedSitesService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["EmpID"]              = AppSession.user?.EmpNumber
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
        params["connectionKey"]  = "SAMS"
        print(params)
        WebServiceManager.shared.GetEmpMappedSites(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.RegSiteListData = data.compactMap({SitesList(withData: $0)})
                        self.RegsiteNamelist.removeAll()
                        for sitelists in self.RegSiteListData{
                            self.RegsiteNamelist.append(sitelists.ClientSiteName)
                        }
                        self.attendSiteBtn.isEnabled = true
                        self.dropDown_Site.dataSource = self.RegsiteNamelist

                       
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
    func callGetEmployeeAttendanceDailyWithShiftService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetEmployeeAttendanceDailyWithShiftService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]          = "SAMS"
        params["EmployeeNumber"]         = AppSession.user?.EmpNumber
        params["ClientCode"]             = self.SelectedSiteNameLIst.ClientCode
        params["AsmtId"]                = self.SelectedSiteNameLIst.AsmtId
         params["LocationAutoID"]        = AppSession.user?.LocationAutoID
        print(params)
        WebServiceManager.shared.GetEmployeeAttendanceDailyWithShift(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.RegShiftListData = data.compactMap({ShiftsfList(withData: $0)})
                        self.RegshiftNameList.removeAll()
                        for shiftlist in self.RegShiftListData{
                            self.RegshiftNameList.append(shiftlist.ShiftCode)
                        }
                        self.dropDown_Shift.dataSource = self.RegshiftNameList
                                           
                       
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
