//
//  IFMVC.swift
//  iVM360
//
//  Created by 1707 on 16/07/24.
//

import UIKit
import DropDown
import CoreLocation
class IFMVC: UIViewController, CustomAlertDelegate, CLLocationManagerDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    @IBOutlet weak var fmbackGroundView: UIView!
    @IBOutlet weak var fmsitetablebackgroundView: UIView!
    @IBOutlet weak var fmsiteHight: NSLayoutConstraint!
    @IBOutlet weak var fmsiteBtn: UIButton!
    @IBOutlet weak var fmsitetableview: UITableView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var UserPostNameLbl: UILabel!
    
    @IBOutlet weak var empCodeLBL: UILabel!
    
    @IBOutlet weak var fmunwantedtableview: UITableView!
    @IBOutlet weak var fmimage: UIImageView!
    @IBOutlet weak var fmimagelogo: UIImageView!
    @IBOutlet weak var visitsBtn: UIButton!
    @IBOutlet weak var scheduleWorkBtn: UIButton!
    @IBOutlet weak var ticketBtn: UIButton!
    @IBOutlet weak var visitbackgroundView: UIView!
    @IBOutlet weak var visit_backgroundView: UIView!
    @IBOutlet weak var visitselectBtn: UIButton!
    
    
    let dropDownIFMSite = DropDown()
    let dropDownSiteType = DropDown()
    var visitSiteData = [Sites_VisitModal]()
    var visitsTypeData = [Visit_TypeModal]()
    var visitSitesNameList = [String]()
    var VisitTypeNameList = [String]()
    
    var ClientCodeFromVisitSite = String()
    var AsmtIdfromSite = String()
    var CompanyCodefromSite = String()
    var siteType = String()
    var autoIdfromVisit = String()
    var designationFromVisit = String()
    var LocationAutoIdfromSite = String()
    var siteNameFromGeoSite = String()
    var isvisitSelection = false
    var isSiteSelection = false
    
    var locManager = CLLocationManager()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var ClientCodeFromVisitSiteArray      = [String]()
    var AsmtIdfromSiteArray               = [String]()
    var CompanyCodefromSiteArray          = [String]()
    var LocationAutoIdfromSiteArray       = [String]()
    var siteNameFromGeoSiteArray           = [String]()
    
    var siteTypeArray                = [String]()
    var autoIdfromVisitArray         = [String]()
    var designationFromVisitArray    = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNameLbl.text = AppSession.user?.EmpName
        self.UserPostNameLbl.text = AppSession.user?.EmpNumber
        self.empCodeLBL.text = AppSession.user?.Designation
        self.visitbackgroundView.isHidden = true
        self.callGetGeoMappedSitesSmartFMService()
        dropDownIFMSite.cornerRadius = 5
        dropDownIFMSite.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDownIFMSite.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDownIFMSite.anchorView = self.fmsiteBtn
        dropDownIFMSite.bottomOffset = CGPoint(x: -1, y: self.fmsiteBtn.bounds.height)
        dropDownIFMSite.selectionAction = { [unowned self] (index: Int, item: String) in
            self.fmsiteBtn.setTitle(item, for: .normal)
                        self.ClientCodeFromVisitSite = self.visitSiteData[index].ClientCode
                        self.AsmtIdfromSite = self.visitSiteData[index].AsmtId
                        self.CompanyCodefromSite = self.visitSiteData[index].CompanyCode
                        self.LocationAutoIdfromSite = self.visitSiteData[index].LocationAutoID
                        self.siteNameFromGeoSite = self.visitSiteData[index].SiteName
                         self.callGetVisitTypeSmartFMService()
                         self.isSiteSelection = true
            
        }
        dropDownSiteType.cornerRadius = 5
        dropDownSiteType.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDownSiteType.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDownSiteType.anchorView = self.visitselectBtn
        dropDownSiteType.bottomOffset = CGPoint(x: -1, y: self.visitselectBtn.bounds.height)
        dropDownSiteType.selectionAction = { [unowned self] (index: Int, item: String) in
            self.visitselectBtn.setTitle(item, for: .normal)
            self.isvisitSelection = true
            self.siteType = self.visitsTypeData[index].ChecklistHeader
            self.autoIdfromVisit = self.visitsTypeData[index].AutoID
            self.designationFromVisit = self.visitsTypeData[index].Designation
            
        }
        // -----------------------------------------------------
        // Mark:- for latitude and longitude in viewdidload
        //------------------------------------------------------
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager = CLLocationManager()
        }
        
        self.tabBarController?.tabBar.isHidden = false
        self.visit_backgroundView.layer.cornerRadius = 5
        self.fmbackGroundView.layer.cornerRadius = 10
        self.fmsiteBtn.layer.cornerRadius = 5
        self.visitsBtn.layer.cornerRadius = 5
        self.scheduleWorkBtn.layer.cornerRadius = 5
        self.ticketBtn.layer.cornerRadius = 5
        //        self.fmsitetableview.isHidden = true
        //        self.fmunwantedtableview.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.visitbackgroundView.isHidden = true
//        self.isvisitSelection = false
//        self.isSiteSelection = false
        
    }
    
    
    @IBAction func clickFMSitesBtn(_ sender: Any){
        if self.visitSiteData.count == 1{
            if self.visitSiteData.first?.MessageString == "No Site available within the current location !!"{
                let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                customAlert.delegate = self
                customAlert.hideBut = true
                customAlert.logoutBut = false
                customAlert.onofflineBut = false
                customAlert.modalPresentationStyle = .overCurrentContext
                customAlert.providesPresentationContextTransitionStyle = true
                customAlert.modalTransitionStyle = .crossDissolve
                customAlert.titlestring = "Alert"
                customAlert.massage = "No Site available within the current location !!"
                self.present(customAlert, animated: true, completion: nil)
                ActivityView.hide(self.view)
            }else{
                dropDownIFMSite.show()
            }
            
        }else{
            dropDownIFMSite.show()

        }
       
        
    }
    @IBAction func clickVisitselectBtn(_ sender: Any){
        dropDownSiteType.show()
}
    
    @IBAction func clickOKtBtn(_ sender: Any){
        if self.isvisitSelection == true{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MysteryTypeFormVC") as? MysteryTypeFormVC
            vc?.clintCodeFromBack = self.ClientCodeFromVisitSite
            vc?.siteTypeNameFromBack = self.siteType
            vc?.AsmtIdfromSiteFromBack = self.AsmtIdfromSite
            vc?.CompanyCodefromSiteFromBack = self.CompanyCodefromSite
            vc?.LocationAutoIDFromBack = self.LocationAutoIdfromSite
            vc?.siteNameFromGeoFromBack = self.siteNameFromGeoSite
            vc?.autoIdVisitFromBak = self.autoIdfromVisit
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "Select Visit Type"
            self.present(customAlert, animated: true, completion: nil)
        }
               
    }
    @IBAction func clickCancelBtn(_ sender: Any){
        self.visitbackgroundView.isHidden = true
    }
    
    
    
    
    
    
    func animatesite(toogles: Bool) {
        if toogles {
            UIView.animate(withDuration: 0.3) {
                self.fmsitetableview.isHidden = false
               
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                self.fmsitetableview.isHidden = true
              
            }
        }
    }
    @IBAction func clickVisitsBtn(_ sender: Any){
        if  self.isSiteSelection == true{
            self.visitbackgroundView.isHidden = false
        }else{
            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "Select Site"
            self.present(customAlert, animated: true, completion: nil)
        }
        
        
    }
    @IBAction func clicksheduledTaskBtn(_ sender: Any){
        if  self.isSiteSelection == true{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "sheduledTask_VC") as? sheduledTask_VC
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "Select Site"
            self.present(customAlert, animated: true, completion: nil)
        }
       
    }
    @IBAction func clickTicketBtn(_ sender: Any){
        if  self.isSiteSelection == true{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "create_ViewTickets_VC") as? create_ViewTickets_VC
            vc?.ClientCodeFromVisitSitefromBack = self.ClientCodeFromVisitSite
            vc?.AsmtIdfromSitefromBack = self.AsmtIdfromSite
            vc?.CompanyCodefromSitefromBack = self.CompanyCodefromSite
            vc?.LocationAutoIdfromSitefromBack = self.LocationAutoIdfromSite
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "Select Site"
            self.present(customAlert, animated: true, completion: nil)
        }
       
    }

}
