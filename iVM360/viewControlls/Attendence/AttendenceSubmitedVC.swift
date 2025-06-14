//
//  AttendenceSubmitedVC.swift
//  iVM360
//
//  Created by 1707 on 22/07/24.
//

import UIKit

class AttendenceSubmitedVC: UIViewController, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    @IBOutlet weak var submitUserName: UILabel!
    @IBOutlet weak var submitProfilePost: UILabel!
    @IBOutlet weak var submitTimeBackGroundView: UIView!
    @IBOutlet weak var submitlocationBackGroundView: UIView!
    @IBOutlet weak var submitLocationLbl: UILabel!
    @IBOutlet weak var submitTimeLbl: UILabel!
    @IBOutlet weak var submitPostRankLbl: UILabel!
    @IBOutlet weak var submitLatLongLbl: UILabel!
    @IBOutlet weak var sbumbitINOutTimeLbl: UILabel!
    @IBOutlet weak var submitSuccessAlertLbl: UILabel!
    @IBOutlet weak var submitphotoimageView: UIImageView!
    @IBOutlet weak var submitRightImage: UIImageView!
    
    var ShiftListData = [ShiftsfList]()
    var latfromBack = String()
    var longFromBack = String()
    var checkListmarklastImgFromBack = UIImage()
    var shiftStartTime = String()
    var shiftEndTime = String()
    var currentLocationFromBack = String()
    var checkinenableFromBack = String()
    var checkoutenableFromBack = String()
    var checkInTime = String()
    var checkOutTime = String()
    var isscannerVCFromBackk = Bool()
    var ischeckinSuccess = Bool()
    var CurrentAddressFromBack = String()
    var ischeckOut = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.submitphotoimageView.layer.cornerRadius = 25
        self.callGetEmployeeAttendanceDailyWithShiftService()
        self.submitUserName.text = AppSession.user?.EmpName
        self.submitProfilePost.text = AppSession.user?.Designation
        self.submitLatLongLbl.text = "Lat: " + "\(self.latfromBack)" + ", "  + "Long: " + "\(self.longFromBack)"
        self.submitTimeLbl.text = "Shift " + UserDefaultUtility().getShiftCode() + " | " + self.shiftStartTime + "|" + self.shiftEndTime
        self.sbumbitINOutTimeLbl.text = "Duty in" + self.checkInTime + "|" + "Duty Out" + self.checkOutTime
        self.submitPostRankLbl.text = AppSession.user?.Designation
        let image = self.checkListmarklastImgFromBack
        self.submitLocationLbl.text = self.CurrentAddressFromBack
        self.configure(with: image)
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(goBack), userInfo: nil, repeats: false)
        }

        @objc func goBack() {

            if let navigationController = self.navigationController {
                        let viewControllers = navigationController.viewControllers
                if self.isscannerVCFromBackk == true{
                    let targetIndex = viewControllers.count - 4
                     if targetIndex >= 0 {
                         let targetViewController = viewControllers[targetIndex] as? homeCheckinVC
                         if let targetViewController = targetViewController {

                             targetViewController.isceheckInsubmittedDone = self.ischeckinSuccess
                             targetViewController.ischeckOutfromBack = self.ischeckOut
                             
                         }
                         navigationController.popToViewController(targetViewController!, animated: true)
                     }
                }else{
                    let targetIndex = viewControllers.count - 3
                     if targetIndex >= 0 {
                         let targetViewController = viewControllers[targetIndex] as? homeCheckinVC
                         if let targetViewController = targetViewController {
                             targetViewController.isceheckInsubmittedDone = self.ischeckinSuccess
                             targetViewController.ischeckOutfromBack = self.ischeckOut

                         }
                         navigationController.popToViewController(targetViewController!, animated: true)
                     }
                }

                    }
        }
    func configure(with image: UIImage) {
        submitphotoimageView.image = image
            }
    }

extension AttendenceSubmitedVC{
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
            params["ClientCode"]             = UserDefaultUtility().getClientCode()
            params["AsmtId"]                = UserDefaultUtility().getAsmtId()
//         params["LocationAutoID"]        = AppSession.user?.LocationAutoID
        if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
            params["LocationAutoID"]        = UserDefaultUtility().getLocationAutoID()
        }else{
            params["LocationAutoID"]        = AppSession.user?.LocationAutoID
        }
        print(params)
        WebServiceManager.shared.GetEmployeeAttendanceDailyWithShift(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.ShiftListData = data.compactMap({ShiftsfList(withData: $0)})
                        for shiftlist in self.ShiftListData{
                            if shiftlist.InTime != "" && shiftlist.OutTime == "" {
                            self.checkInTime = shiftlist.InTime
                            self.checkOutTime = "----"
                }else if shiftlist.OutTime != "" && shiftlist.InTime != ""{
                    self.checkInTime = shiftlist.InTime
                    self.checkOutTime = shiftlist.OutTime
                }else if shiftlist.OutTime == "" && shiftlist.InTime == ""{
                    self.checkInTime = "----"
                    self.checkOutTime = "----"
                }
        let shiftDetails = shiftlist.ShiftDetails
        if let range = shiftDetails.range(of: "\\((.*?)\\)", options: .regularExpression) {
            let timeDetails = shiftDetails[range].dropFirst(2).dropLast(2)
            print(timeDetails)
            // Split the time details by hyphen
            let times = timeDetails.components(separatedBy: "-")
            print(times)
            print(times.count)
            if times.count == 2 {
                let startTime = times[0].trimmingCharacters(in: .whitespaces)
                let endTime = times[1].trimmingCharacters(in: .whitespaces)
                self.shiftStartTime = startTime
                self.shiftEndTime = endTime
                
            }
        }
                        }
                        
                        if UserDefaultUtility().getCheckInEnable() == "0" && UserDefaultUtility().getCheckOutEnable() == "1"{
                            UserDefaultUtility().removeCheckinEnable()
                            UserDefaultUtility().removeCheckOutEnable()
                            UserDefaultUtility().removeEmpNumber()
                            UserDefaultUtility().removeDate()
                            UserDefaultUtility().removeShiftEndTime()
                            self.ischeckOut = true
                            self.ischeckinSuccess = false
                            
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
    



