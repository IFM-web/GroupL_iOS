//
//  ClientDetaisVC.swift
//  iVM360
//
//  Created by 1707 on 31/07/24.
//

import UIKit
import SwiftSignatureView
import Cosmos
class ClientDetaisVC: UIViewController, UITextViewDelegate, SwiftSignatureViewDelegate, CustomAlertDelegate{
    
    func okTapBtn(islogout: Int, text: String) {
        if self.isclingsubmit == true{
            if let navigationController = self.navigationController {
                let viewControllers = navigationController.viewControllers
                let targetIndex = viewControllers.count - 3
                 if targetIndex >= 0 {
                     let targetViewController = viewControllers[targetIndex] as? IFMVC
                     if let targetViewController = targetViewController {
                        print("ok")

                     }
                     navigationController.popToViewController(targetViewController!, animated: true)
                 }

            }
        }else{
            
        }
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
//  
    func swiftSignatureViewDidDrawGesture(_ view: ISignatureView, _ tap: UIGestureRecognizer) {
//        if tap.state == .ended {
//              // Enable scrolling after the gesture ends (signature is completed)
//              self.mainTableView.isScrollEnabled = true
//              print("Gesture ended, re-enabling scrolling")
//          }
          print("swiftSignatureViewDidDrawGesture")
          
        }
    
        func swiftSignatureViewDidDraw(_ view: ISignatureView) {
            // Disable scrolling while drawing
//                self.mainTableView.isScrollEnabled = false
            print("swiftSignatureViewDidDraw")
        }
    

    
    @IBOutlet weak var clientDetailsBackGroundView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var signatureClientBackGroundView : UIView!
    @IBOutlet weak var signatureOwnerBackGroundView: UIView!
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var clientCommentBackGroundView: UIView!
    
    @IBOutlet weak var ownerCommentBackGroundView: UIView!
    @IBOutlet weak var clientCommentTitleLbl: UILabel!
    @IBOutlet weak var ownerCommentTitleLbl: UILabel!
    @IBOutlet weak var ownersignatureBackGroundView: SwiftSignatureView!
    @IBOutlet weak var clientSignatureBackGroundView: SwiftSignatureView!
    @IBOutlet weak var CommentBackGroundView: UIView!
    @IBOutlet weak var signtureClearBtn: UIButton!
    @IBOutlet weak var ownsignatureClearBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var nametextFld: UITextField!
    @IBOutlet weak var mailIDFld: UITextField!
    @IBOutlet weak var contactNumberFld: UITextField!
    @IBOutlet weak var msgFld: UITextField!
    @IBOutlet weak var ratingBtn: UIButton!
    @IBOutlet weak var addremarkDetailetextView: UITextView!
    
    
    
    
    
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
    var taskListremark = String()
    let placeholder = "Enter your remarks here"
    var isclingsubmit = false
    var ratingd = Double()
    var cosmosView: CosmosView!
    var name = String()
    var number = String()
    var email = String()
    var designation = String()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//     Rating -----------------------------------------------------------
        let cosmosView = CosmosView()
        cosmosView.frame = self.ratingView.bounds
        cosmosView.settings.totalStars = 10
        cosmosView.settings.starSize = 25
        cosmosView.settings.fillMode = .full
        cosmosView.rating = 0
        cosmosView.didTouchCosmos = { rating in
            self.ratingd = rating
            print("Rating: \(rating)")
        }
        view.addSubview(cosmosView)
        // Add the CosmosView as a subview
              ratingView.addSubview(cosmosView)

              // Optional: Adjust autoresizing masks or constraints if needed
              cosmosView.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([
                  cosmosView.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor),
                  cosmosView.trailingAnchor.constraint(equalTo: ratingView.trailingAnchor),
                  cosmosView.topAnchor.constraint(equalTo: ratingView.topAnchor),
                  cosmosView.bottomAnchor.constraint(equalTo: ratingView.bottomAnchor)
              ])
// -----------------------------------------------------------------
        self.addremarkDetailetextView.text = placeholder
        self.clientSignatureBackGroundView.clear(cache: true)
        self.ownersignatureBackGroundView.clear(cache: true)

        if let clientSignatureView = clientSignatureBackGroundView, let ownerSignatureView = ownersignatureBackGroundView {
            clientSignatureView.delegate = self
            ownerSignatureView.delegate = self
        } else {
            // Handle the case where one or both views are nil
            print("Signature background views are nil")
        }
//        self.clientSignatureBackGroundView.image = nil
        self.ownersignbase64 = ""
        self.clientsignbase64 = ""
//        
    
             
        if self.isScheduleWorkShow == true{
            self.nametextFld.isHidden = true
            self.mailIDFld.isHidden = true
            self.contactNumberFld.isHidden = true
            self.msgFld.isHidden = true
            self.signtureClearBtn.isHidden = true
            self.signatureClientBackGroundView.isHidden = true
            self.ownerCommentBackGroundView.isHidden = false
            self.clientCommentTitleLbl.isHidden = false
            
            
            
        }else{
            self.nametextFld.isHidden = false
            self.mailIDFld.isHidden = false
            self.contactNumberFld.isHidden = false
            self.msgFld.isHidden = false
            self.signtureClearBtn.isHidden = false
            self.signatureClientBackGroundView.isHidden = false
            self.clientCommentTitleLbl.isHidden = false
            self.ownerCommentBackGroundView.isHidden = true
            self.clientCommentTitleLbl.isHidden = true
        }
        self.clientDetailsBackGroundView.layer.cornerRadius = 10
        self.clientSignatureBackGroundView.layer.cornerRadius = 10
        self.ownersignatureBackGroundView.layer.cornerRadius = 10
        self.clientSignatureBackGroundView.layer.borderWidth = 1.5
        self.clientSignatureBackGroundView.layer.borderColor = #colorLiteral(red: 0, green: 0.7139031291, blue: 0.225849092, alpha: 1)
        self.clientSignatureBackGroundView.backgroundColor = #colorLiteral(red: 0, green: 0.7139031291, blue: 0.225849092, alpha: 0.25)
        self.ownersignatureBackGroundView.backgroundColor = #colorLiteral(red: 0, green: 0.7139031291, blue: 0.225849092, alpha: 0.25)
        
        self.ownersignatureBackGroundView.layer.borderWidth = 1.5
        self.ownersignatureBackGroundView.layer.borderColor = #colorLiteral(red: 0, green: 0.7139031291, blue: 0.225849092, alpha: 1)
        self.CommentBackGroundView.layer.cornerRadius = 5
        self.CommentBackGroundView.layer.borderWidth = 1.5
        self.CommentBackGroundView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)

//        signatureClientBackGroundView.delegate = self
//        signatureOwnerBackGroundView.delegate = self
        // Add gesture recognizers to signature views
              
        
        self.addremarkDetailetextView.delegate = self
        
    }

    
    //------------------------------
    //    text view
    //------------------------------
        func textViewDidBeginEditing(_ textView: UITextView) {
          
                self.addremarkDetailetextView.text = ""
                       
                    
           
        }
        func textViewDidEndEditing(_ textView: UITextView){
            
               }
    
  
    
    func convertSignatureToBase64(signatureView: SwiftSignatureView) -> String? {
        // Step 1: Check if the signature has been drawn
        guard !signatureView.isEmpty else {
            return nil // No signature drawn
        }

        // Step 2: Get the signature image
        guard let signatureImage = signatureView.signature else {
            return nil // No signature present
        }

        // Step 3: Convert the image to Data (PNG format)
        guard let imageData = signatureImage.pngData() else {
            return nil
        }

        // Step 4: Encode the Data as Base64
        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)

        return base64String
    }

//
    
    
    @IBAction func mysterybackkClickBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapClearemp() {
        self.clientSignatureBackGroundView.clear()
        self.clientSignatureBackGroundView.clear(cache: true)
      
        self.ownersignbase64 = ""
        self.clientsignbase64 = ""
    }
    @IBAction func didTapClearown() {
        self.ownersignatureBackGroundView.clear()
        self.ownersignatureBackGroundView.clear(cache: true)
        self.ownersignbase64 = ""
        self.clientsignbase64 = ""
    }
    
    @IBAction func clicksubmitBButton(_ sender: Any){
      
        self.ownersignbase64 = self.convertSignatureToBase64(signatureView: self.ownersignatureBackGroundView) ?? ""
        self.clientsignbase64 = self.convertSignatureToBase64(signatureView: self.clientSignatureBackGroundView) ?? ""
       
       if self.isScheduleWorkShow == true{
           self.callInsertScheduledWorkEmpDetailsSmartFMService()
       }else{
           
           self.name = self.nametextFld.text ?? ""
           self.number = self.contactNumberFld.text ?? ""
           self.email = self.mailIDFld.text ?? ""
           self.designation = self.msgFld.text ?? ""
           if self.addremarkDetailetextView.text == "Enter your remarks here"{
               self.taskListremark = ""
           }else{
               self.taskListremark = self.addremarkDetailetextView.text
           }
           if self.ratingd > 0.0 && self.taskListremark.isEmpty == false && self.name.isEmpty == false && self.email.isEmpty == false && self.number.isEmpty == false && self.designation.isEmpty == false && self.ownersignbase64.isEmpty == false && self.clientsignbase64.isEmpty == false {
               self.callInsertVisitChecklistClientDetailsSmartFMService()
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
               customAlert.massage = "please give all detail"
               self.present(customAlert, animated: true, completion: nil)
               ActivityView.hide(self.view)
           }
               
          
       }
        
    }
    

}
extension ClientDetaisVC {
    @available(iOS 13.0, *)

    func callInsertVisitChecklistClientDetailsSmartFMService(){
       
       
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callInsertVisitChecklistClientDetailsSmartFMService()
            }
            return
        }
      
        ActivityView.show(self.view)
        params["connectionKey"]              = "SAMS"
        params["empID"]                     = AppSession.user?.EmpNumber
        params["empName"]                   = AppSession.user?.EmpName
        params["Designation"]               = AppSession.user?.Designation
        params["LocationAutoid"]              = AppSession.user?.LocationAutoID
        params["ClientCode"]                 = self.clintCodeFromBackkk
        params["asmtID"]                     = self.AsmtIdfromSiteFromBackkk
        params["CompanyCode"]                = self.CompanyCodefromSiteFromBackkk
        params["VisitType"]                 = self.siteTypeNameFromBackkk
        params["VisitAutoID"]               = self.AutoIdfromCheckListFromBack
        params["EmpSignImageBase64"]         = self.ownersignbase64
        params["ClientSignImageBase64"]       = self.clientsignbase64
        params["ClientName"]                 = self.name
        params["ClientPhone"]                 = self.number
        params["ClientEmail"]                = self.email
        params["ClientDesignation"]            = self.designation
        params["ClientRating"]               = self.ratingd
        params["ClientRemarks"]                = self.taskListremark
       
       
        print(params)
        WebServiceManager.shared.InsertVisitChecklistClientDetailsSmartFM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        let submitMsg = mainData["MessageString"] as? String ?? ""
                        self.isclingsubmit = true
                        self.ownersignbase64 = ""
                        self.clientsignbase64 = ""
//                        "Details Submitted Sucessfully !!"
                        let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                        customAlert.delegate = self
                        customAlert.hideBut = true
                        customAlert.logoutBut = false
                        customAlert.onofflineBut = false
                        customAlert.modalPresentationStyle = .overCurrentContext
                        customAlert.providesPresentationContextTransitionStyle = true
                        customAlert.modalTransitionStyle = .crossDissolve
                        customAlert.titlestring = "Alert"
                        customAlert.massage = submitMsg
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
    func callInsertScheduledWorkEmpDetailsSmartFMService(){
        let name = self.nametextFld.text
        let contactNumber = self.contactNumberFld.text
        let mailid = self.mailIDFld.text
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
        params["empID"]                     = AppSession.user?.EmpNumber
        params["empName"]                   = AppSession.user?.EmpName
        params["Designation"]               = AppSession.user?.Designation
        params["LocationAutoid"]              = AppSession.user?.LocationAutoID
        params["ClientCode"]                 = self.clintCodeFromBackkk
        params["asmtID"]                     = self.AsmtIdfromSiteFromBackkk
        params["CompanyCode"]                = self.CompanyCodefromSiteFromBackkk
        params["VisitType"]                 = self.siteTypeNameFromBackkk
        params["VisitAutoID"]               = self.AutoIdfromCheckListFromBack
        params["EmpSignImageBase64"]         = self.ownersignbase64
        params["ClientSignImageBase64"]       = self.clientsignbase64
        params["ClientName"]                 = name
        params["ClientPhone"]                = contactNumber
        params["ClientEmail"]                = mailid
        params["ClientDesignation"]                 = self.designationVisitFromBackk
        params["ClientRating"]               = "3.5"
        params["ClientRemarks"]                = ""
       
       
        print(params)
        WebServiceManager.shared.InsertScheduledWorkEmpDetailsSmartFM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
//                        self.navigationController?.popViewController(animated: true)
//                        self.VisitCheckListNameData = data.compactMap({Visit_CheckListModal(withData: $0)})

                       
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
