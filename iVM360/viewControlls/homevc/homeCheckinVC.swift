//
//  homeCheckinVC.swift
//  iVM360
//
//  Created by 1707 on 16/07/24.
//

import UIKit
import DropDown
class homeCheckinVC: UIViewController, CustomAlertDelegate {
    
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    @IBOutlet weak var empIdName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var ProfilePost: UILabel!
    
    @IBOutlet weak var checkInTimeLbl: UILabel!
    @IBOutlet weak var checkOutTimeLbl: UILabel!
    
    @IBOutlet weak var checkInMonthLbl: UILabel!
    @IBOutlet weak var checkOutMonthLbl: UILabel!
    
    @IBOutlet weak var checkInmonthsLbl: UILabel!
    @IBOutlet weak var checkOutMonthsLbl: UILabel!
    
    @IBOutlet weak var shiftStartTimeLbl: UILabel!
    @IBOutlet weak var shiftendTimeLbl: UILabel!
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var sitetablebackgroundView: UIView!
    @IBOutlet weak var siteHight: NSLayoutConstraint!
    @IBOutlet weak var shiftTableHight: NSLayoutConstraint!
    @IBOutlet weak var siteBtn: UIButton!
    @IBOutlet weak var shiftBtn: UIButton!
    @IBOutlet weak var sitetableview: UITableView!
    @IBOutlet weak var unwantedtableview: UITableView!
    @IBOutlet weak var shifttableview: UITableView!
    @IBOutlet weak var shiftBackgroundView:UIView!
    @IBOutlet weak var checkinBtn: UIButton!
    @IBOutlet weak var checkoutBtn: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imagelogo: UIImageView!
    @IBOutlet weak var starttimeBackgroundView:UIView!
    @IBOutlet weak var endTimeBackgroundView:UIView!
    @IBOutlet weak var timeBackgroundView:UIView!
    @IBOutlet weak var logoutBtn: UIButton!
    
    let dropDown = DropDown()
    let dropDownShift = DropDown()
    var SiteListData = [SitesList]()
    var siteNamelist = [String]()
    
    var clintCodeArray = [String]()
    var AsmtIdArray = [String]()
    var locationAutoId = [String]()
    
    
    var shiftNameList = [String]()
    var checkinTimeArray = [String]()
    var checkOutTimeArray = [String]()
    var shiftCodeArray = [String]()
    
    
    
    var ShiftListData = [ShiftsfList]()
    var filterShiftListData = [ShiftsfList]()
    var sitePostData = [SitePostCheckinModal]()
    var visitSiteData_attendance = [Sites_VisitModal]()
    
    var shift_detaislData = [shift_deatils]()
    var time_detailsData = [time_deatils]()
    var AsmtIDFromSite = String()
    var ClientCodeFromSite = String()
    var clientSiteName = String()
    var ShiftCode = String()
    var postId = String()
    
    var checkinTime = String()
    var checkoutTime = String()
    var checkinEnable = String()
    var checkOutEnable = String()
    var savedClintcode = String()
    var savedAsmtId = String()
    var SavedemployeeNumber = String()
    var savedSiteName = String()
    var savedShiftCode = String()
    var submitcheckinenableFromBack = String()
    var submitcheckoutenableFromBack = String()
    var submitcheckInTimeFromBack = String()
    var submitcheckOutTimeFromBack = String()
    var isceheckInsubmittedDone = Bool()
    var ischeckOutfromBack = Bool()
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.siteBtn.isEnabled = true
        self.shiftBtn.isEnabled = true
        self.userName.text = AppSession.user?.EmpName
        self.ProfilePost.text = AppSession.user?.Designation
        self.empIdName.text = AppSession.user?.EmpNumber
        
        self.backGroundView.layer.cornerRadius = 10
//        self.image.isHidden = true
        self.siteBtn.layer.cornerRadius = 5
        self.shiftBtn.layer.cornerRadius = 5
        self.starttimeBackgroundView.layer.cornerRadius = 5
        self.endTimeBackgroundView.layer.cornerRadius = 5
        self.timeBackgroundView.layer.cornerRadius = 10
        self.logoutBtn.layer.cornerRadius = 10
        self.checkinBtn.layer.cornerRadius = 5
        self.checkoutBtn.layer.cornerRadius = 5
        self.isceheckInsubmittedDone = false
        
        
        let date = Date()
        let time = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d MMM"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let currentTime = timeFormatter.string(from: time)
       let savedTime = UserDefaultUtility().getShiftEndTime()
        let formattedDate = dateFormatter.string(from: date)
        self.checkInMonthLbl.text = formattedDate
        self.checkOutMonthLbl.text = formattedDate
        self.checkInmonthsLbl.text = formattedDate
        self.checkOutMonthsLbl.text = formattedDate
        if UserDefaultUtility().getEmpNumber() == AppSession.user?.EmpNumber{
            if UserDefaultUtility().getCheckInEnable() == "0" && UserDefaultUtility().getCheckOutEnable() == "1" && UserDefaultUtility().getDate() == formattedDate{
                if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
                    self.callGetGeoMappedSitesSmartFMService()
                }else{
                    self.callGetEmpMappedSitesService()
                }
               
                self.callGetEmployeeAttendanceDailyWithShiftService()
            }else{
                if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
                    self.callGetGeoMappedSitesSmartFMService()
                }else{
                    self.callGetEmpMappedSitesService()
                }
                UserDefaultUtility().removeDate()
                UserDefaultUtility().removeShiftEndTime()
            }
        }else{
            if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
                self.callGetGeoMappedSitesSmartFMService()
            }else{
                self.callGetEmpMappedSitesService()
            }
            UserDefaultUtility().removeDate()
            UserDefaultUtility().removeShiftEndTime()
        }
        
       
       
        dropDown.cornerRadius = 5
    dropDown.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown.anchorView = self.siteBtn
        dropDown.bottomOffset = CGPoint(x: -1, y: self.siteBtn.bounds.height)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                   self.siteBtn.setTitle(item, for: .normal)
            self.siteBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
            
            if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
                self.AsmtIDFromSite = self.visitSiteData_attendance[index].AsmtId
                self.ClientCodeFromSite = self.visitSiteData_attendance[index].ClientCode
                self.clientSiteName = self.visitSiteData_attendance[index].SiteName
                UserDefaultUtility().saveLocationAutoID(fcmToken: self.visitSiteData_attendance[index].LocationAutoID)
            }else{
                self.AsmtIDFromSite = self.SiteListData[index].AsmtId
                self.ClientCodeFromSite = self.SiteListData[index].ClientCode
                self.clientSiteName = self.SiteListData[index].ClientSiteName
            }
           
            self.callGetEmployeeAttendanceDailyWithShiftService()
            UserDefaultUtility().saveAsmtId(AsmtId: self.AsmtIDFromSite)
            UserDefaultUtility().saveClientCode(ClientCode: self.ClientCodeFromSite)
            UserDefaultUtility().saveClientSiteName(ClientSiteName: self.clientSiteName)
          
               }
        
        
        if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
            dropDownShift.cornerRadius = 5
            dropDownShift.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            dropDownShift.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            dropDownShift.anchorView = self.shiftBtn
            dropDownShift.bottomOffset = CGPoint(x: -1, y: self.shiftBtn.bounds.height)
            dropDownShift.selectionAction = { [unowned self] (index: Int, item: String) in
                self.shiftBtn.setTitle(item, for: .normal)
                self.shiftBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
                self.ShiftCode = self.shift_detaislData[index].ShiftCode
                UserDefaultUtility().saveShiftCode(ShiftCode: self.ShiftCode)
                self.callGetEmployeeAttendanceDailyInternalService()
            }
        }else{
            dropDownShift.cornerRadius = 5
            dropDownShift.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            dropDownShift.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            dropDownShift.anchorView = self.shiftBtn
            dropDownShift.bottomOffset = CGPoint(x: -1, y: self.shiftBtn.bounds.height)
            dropDownShift.selectionAction = { [unowned self] (index: Int, item: String) in
                       self.shiftBtn.setTitle(item, for: .normal)
                self.shiftBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
                self.ShiftCode = self.ShiftListData[index].ShiftCode
                self.checkinTime = self.ShiftListData[index].InTime
                self.checkoutTime = self.ShiftListData[index].OutTime
                UserDefaultUtility().saveShiftCode(ShiftCode: self.ShiftCode)
                if self.ShiftListData[index].CheckInEnable == "1" && self.ShiftListData[index].CheckOutEnable == "0"{
                    self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                    self.checkinBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
                    self.checkinBtn.isEnabled = true
                    self.checkoutBtn.isEnabled = false
                }else if self.ShiftListData[index].CheckInEnable == "0" && self.ShiftListData[index].CheckOutEnable == "1"{
                    self.checkoutBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
                    self.checkinBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                    self.checkinBtn.isEnabled = false
                    self.checkoutBtn.isEnabled = true
                    
                }else if self.ShiftListData[index].CheckInEnable == "0" && self.ShiftListData[index].CheckOutEnable == "0"{
                    self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                    self.checkinBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                    self.checkinBtn.isEnabled = false
                    self.checkoutBtn.isEnabled = false
                }

                
                let shiftDetails = self.ShiftListData[index].ShiftDetails
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
                        self.checkInTimeLbl.text = startTime
                        self.checkOutTimeLbl.text = endTime
                    }
                }
                if self.ShiftListData[index].InTime != "" && self.ShiftListData[index].OutTime == ""{
                    self.shiftStartTimeLbl.text = self.ShiftListData[index].InTime
                    self.shiftendTimeLbl.text = "----"
                }else if self.ShiftListData[index].InTime != "" && self.ShiftListData[index].OutTime != ""{
                    self.shiftStartTimeLbl.text = self.ShiftListData[index].InTime
                    self.shiftendTimeLbl.text = self.ShiftListData[index].OutTime
                }else if self.ShiftListData[index].InTime == "" && self.ShiftListData[index].OutTime == ""{
                    self.shiftStartTimeLbl.text = "----"
                    self.shiftendTimeLbl.text = "----"
                }
                
                   }
          
        }
        
       


    }


    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        if self.isceheckInsubmittedDone == true {
            if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
                self.callGetGeoMappedSitesSmartFMService()
            }else{
                self.callGetEmpMappedSitesService()
            }
//            self.callGetEmployeeAttendanceDailyWithShiftService()
           
        }else if self.ischeckOutfromBack == true{
            self.siteBtn.isEnabled = true
            self.shiftBtn.isEnabled = true
            self.checkinBtn.isEnabled = false
            self.checkoutBtn.isEnabled = false
            self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
            self.checkinBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
            if AppSession.user?.CompanyCode == "GroupL-InternalN" || AppSession.user?.CompanyCode == "MMPL"{
                self.callGetGeoMappedSitesSmartFMService()
            }else{
                self.callGetEmpMappedSitesService()
            }
        }
        

      
      }
    
    @IBAction func clickCheckInBtn(_ sender: Any){
        self.callGetSitesPostService()


    }
    @IBAction func clickCheckOutBtn(_ sender: Any){
        self.callGetSitesPostService()


    }
    @IBAction func clickSitesBtn(_ sender: Any){
        dropDown.show()

    }
    @IBAction func clickShiftssBtn(_ sender: Any){
        dropDownShift.show()

    }
    @IBAction func clickLogOutBtn(_ sender: Any){
        UserDefaultUtility().saveEmpNumber(EmpNumber: AppSession.user?.EmpNumber ?? "")
//        UserDefaults.standard.removeObject(forKey: "isLogin")
        let scanvc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginByPIN_VC") as? LoginByPIN_VC
        self.navigationController?.pushViewController(scanvc!, animated: true)
        
    }
    func animateshift(toogle: Bool) {
        if toogle {
            UIView.animate(withDuration: 0.3) {
                self.shifttableview.isHidden = false
             
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                self.shifttableview.isHidden = true
               
            }
        }
    }
    func animatesite(toogles: Bool) {
        if toogles {
            UIView.animate(withDuration: 0.3) {
                self.sitetableview.isHidden = false
               
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                self.sitetableview.isHidden = true
              
            }
        }
    }
}
