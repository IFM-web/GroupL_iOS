//
//  ClientDetail_scheduledWorkVC.swift
//  iVM360
//
//  Created by 1707 on 19/09/24.
//

import UIKit
import SwiftSignatureView

class ClientDetail_scheduledWorkVC: UIViewController,UITextViewDelegate, SwiftSignatureViewDelegate, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        goBack()
        
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
  
    func swiftSignatureViewDidDrawGesture(_ view: ISignatureView, _ tap: UIGestureRecognizer) {
            print("swiftSignatureViewDidDrawGesture")
        }
    
        func swiftSignatureViewDidDraw(_ view: ISignatureView) {
            print("swiftSignatureViewDidDraw")
        }
    
    
    @IBOutlet weak var sign_commentBackGroundViews: UIView!
    @IBOutlet weak var textViewBackGroundViews : UIView!
    @IBOutlet weak var ticketGenrateBackGroundViews: SwiftSignatureView!
    @IBOutlet weak var tickesigntureClearBtns: UIButton!
    @IBOutlet weak var submitBtns: UIButton!
    @IBOutlet weak var commentTextViews: UITextView!
    @IBOutlet weak var ticketCommentTitleLbls: UILabel!
  
    
    
    var TicketTypeNameFromBack         = String()
    var TicketCategoryNameFromBack      = String()
    var ClientCodeFromVisitSiteFromBackk = String()
    var AsmtIdfromSiteFromBackk          = String()
    var CompanyCodefromSiteFromBackk      = String()
    var LocationAutoIdfromSiteFromBackk     = String()
    var priorityName = String()
    var TicketNumberFromBackkk = String()
    var isTicketCloseBack = Bool()
    var taskListremark = String()
    var imgBase64FromBack = String()
    var signbase64 = String()
    var GenrateTicketNumber = String()
   
    
    
    var clintCodeFromBackkk = String()
    var AsmtIdfromSiteFromBackkk = String()
    var CompanyCodefromSiteFromBackkk = String()
    var siteTypeNameFromBackkk = String()
    var AutoIdfromCheckListFromBack = String()
    var autoIdVisitFromBakk = String()
    var designationVisitFromBackk = String()
    var isChecklistShow = Bool()
    var isScheduleWorkShow = Bool()
    var ownersignbase64 = String()
    var clientsignbase64 = String()
    var clinentDesignation = String()
    var checklistIdFromBackk = String()
//    var taskListremark = String()
    let placeholder = "Enter your remarks here"
    var isclingsubmit = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentTextViews.text = placeholder
        self.sign_commentBackGroundViews.layer.cornerRadius = 10
        self.textViewBackGroundViews.layer.cornerRadius = 10
        self.tickesigntureClearBtns.layer.cornerRadius = 5
        self.submitBtns.layer.cornerRadius = 5
        self.ticketGenrateBackGroundViews.layer.cornerRadius = 10
        self.ticketGenrateBackGroundViews.layer.cornerRadius = 10
        self.ticketGenrateBackGroundViews.layer.borderColor = #colorLiteral(red: 0.01176470588, green: 0.6745098039, blue: 0.1725490196, alpha: 1)
        self.commentTextViews.layer.cornerRadius = 10
        self.commentTextViews.layer.borderWidth = 1.5
        self.commentTextViews.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.commentTextViews.delegate = self
       
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
      
            self.commentTextViews.text = ""
                   
                
       
    }
    func textViewDidEndEditing(_ textView: UITextView){
        
           }

    func convertSignatureToBase64(signatureView: SwiftSignatureView) -> String? {
        // Step 1: Render the signature as an image
      
        let signatureImage = signatureView.signature
        guard let imageData = signatureImage?.pngData() else {
            return nil
        }
        
        // Step 3: Encode the Data as Base64
        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
        return base64String
    }
    @objc func goBack() {
        if let navigationController = self.navigationController {
                    let viewControllers = navigationController.viewControllers
                    let targetIndex = viewControllers.count - 4
                    if targetIndex >= 0 {
                        let targetViewController = viewControllers[targetIndex] as? IFMVC
                        if let targetViewController = targetViewController {
                            print("ok")
                        }
                        navigationController.popToViewController(targetViewController!, animated: true)
                    }
                }
    }

   
    @IBAction func backkClickBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapClearSign() {
        self.ticketGenrateBackGroundViews.clear()
    }
    @IBAction func clickSubmitBtn() {
        
        self.signbase64 = self.convertSignatureToBase64(signatureView: self.ticketGenrateBackGroundViews) ?? ""
        self.callInsertScheduledWorkEmpDetailsSmartFMService()
        
        
    }
 

}
extension ClientDetail_scheduledWorkVC{
    
    func callInsertScheduledWorkEmpDetailsSmartFMService(){
//        let name = self.commentTextViews.text
//        let contactNumber = self.contactNumberFld.text
//        let mailid = self.mailIDFld.text
        if self.commentTextViews.text == "Enter your remarks here"{
            self.taskListremark = ""
        }else{
            self.taskListremark = self.commentTextViews.text
        }
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callInsertScheduledWorkEmpDetailsSmartFMService()
            }
            return
        }
      
        ActivityView.show(self.view)
        params["connectionKey"]              = "SAMS"
        params["ClientCode"]                 = self.clintCodeFromBackkk
        params["ChecklistHeaderAutoID"]         = self.checklistIdFromBackk
        params["ChecklistID"]                 = "0"
        params["empID"]                     = AppSession.user?.EmpNumber
        params["empName"]                   = AppSession.user?.EmpName
        params["EmpRemarks"]                = self.taskListremark
        params["EmpSignImageBase64"]         = self.signbase64
        params["LocationAutoid"]              = AppSession.user?.LocationAutoID
        params["asmtID"]                     = self.AsmtIdfromSiteFromBackkk
        params["CompanyCode"]                = self.CompanyCodefromSiteFromBackkk
       
       
        print(params)
        WebServiceManager.shared.InsertScheduledWorkEmpDetailsSmartFM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        let masg = mainData["MessageString"] as? String ?? ""
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
