//
//  IntegratedFM_VC.swift
//  iVM360
//
//  Created by 1707 on 02/08/24.
//

import UIKit
import DropDown
class IntegratedFM_VC: UIViewController, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    

    @IBOutlet weak var momsiteBackgroundView: UIView!
    @IBOutlet weak var textviewBackgroundView: UIView!
    @IBOutlet weak var textviewdetails: UITextView!
    @IBOutlet weak var selectSiteBtnn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    let dropDownSiteMOMType = DropDown()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true

        self.momsiteBackgroundView.layer.cornerRadius = 10
        self.textviewBackgroundView.layer.cornerRadius = 10
        self.textviewdetails.layer.cornerRadius = 10
        self.textviewdetails.layer.borderWidth = 1
        self.textviewdetails.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.5)
        self.selectSiteBtnn.layer.cornerRadius = 5
        self.submitBtn.layer.cornerRadius = 5
        dropDownSiteMOMType.cornerRadius = 5
        dropDownSiteMOMType.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDownSiteMOMType.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDownSiteMOMType.anchorView = self.selectSiteBtnn
        dropDownSiteMOMType.bottomOffset = CGPoint(x: -1, y: self.selectSiteBtnn.bounds.height)
        dropDownSiteMOMType.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectSiteBtnn.setTitle(item, for: .normal)
//                        self.ClientCodeFromVisitSite = self.visitSiteData[index].ClientCode
//                        self.AsmtIdfromSite = self.visitSiteData[index].AsmtId
//                        self.CompanyCodefromSite = self.visitSiteData[index].CompanyCode
//                         self.callGetVisitTypeSmartFMService()
//                         self.isSiteSelection = true
            
        }
        
    }
    

}
extension IntegratedFM_VC{
    @available(iOS 13.0, *)
    func callInsertVisitChecklistMOMSmartFMService(){
        var params: [String: Any] = [:]
        
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callInsertVisitChecklistMOMSmartFMService()
            }
            return
        }
        
        ActivityView.show(self.view)
        params["connectionKey"]              = "SAMS"
        params["empID"]                     = AppSession.user?.EmpNumber
        params["empName"]                   = AppSession.user?.EmpName
        params["Designation"]               = AppSession.user?.Designation
        params["LocationAutoid"]              = AppSession.user?.LocationAutoID
        params["Remarks"]    = ""
        params["ClientCode"]                 = "self.clintCodeFromBackk"
        params["asmtID"]                     = "self.AsmtIdfromSiteFromBackk"
        params["CompanyCode"]                = "self.CompanyCodefromSiteFromBackk"
        params["VisitType"]                 = "self.siteTypeNameFromBackk"
        print(params)
        WebServiceManager.shared.InsertVisitChecklistMOMSmartFM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.navigationController?.popViewController(animated: true)
                        
                        
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
