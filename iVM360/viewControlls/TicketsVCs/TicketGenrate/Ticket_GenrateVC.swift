//
//  Ticket_GenrateVC.swift
//  iVM360
//
//  Created by 1707 on 06/08/24.
//

import UIKit
import SwiftSignatureView
import DropDown
class Ticket_GenrateVC: UIViewController, SwiftSignatureViewDelegate, CustomAlertDelegate {
   
    func okTapBtn(islogout: Int, text: String) {
        if isTicketCloseBack == true{
            self.goBack()
        }else{
            print("ok")
        }
       
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
 

    
    @IBOutlet weak var sign_commentBackGroundView: UIView!
    @IBOutlet weak var textViewBackGroundView : UIView!
    @IBOutlet weak var ticketGenrateBackGroundView: SwiftSignatureView!
    @IBOutlet weak var tickesigntureClearBtn: UIButton!
    @IBOutlet weak var selectPreorityBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var ticketCommentTitleLbl: UILabel!
    @IBOutlet weak var selectPriorityTitleLbl: UILabel!
    
   var priorityDropDown = DropDown()
   var Priority = ["Low", "medium", "High"]
    
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
    var GenrateTicketData = [genrrate_Ticket_Modal]()
    var GenrateTicketNumber = String()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if self.isTicketCloseBack == true{
            self.selectPreorityBtn.isHidden = true
            self.selectPriorityTitleLbl.isHidden = true
        }else{
            self.selectPreorityBtn.isHidden = false
            self.selectPriorityTitleLbl.isHidden = false
        }
        self.ticketCommentTitleLbl.isHidden = true
        self.sign_commentBackGroundView.layer.cornerRadius = 10
        self.textViewBackGroundView.layer.cornerRadius = 10
        self.tickesigntureClearBtn.layer.cornerRadius = 5
        self.selectPreorityBtn.layer.cornerRadius = 5
        self.submitBtn.layer.cornerRadius = 5
        self.ticketGenrateBackGroundView.layer.cornerRadius = 10
        self.ticketGenrateBackGroundView.layer.cornerRadius = 10
        self.ticketGenrateBackGroundView.layer.borderColor = #colorLiteral(red: 0.01176470588, green: 0.6745098039, blue: 0.1725490196, alpha: 1)
        self.commentTextView.layer.cornerRadius = 10
        self.commentTextView.layer.borderWidth = 1.5
        self.commentTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.priorityDropDown.dataSource = self.Priority
        priorityDropDown.cornerRadius = 5
        priorityDropDown.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        priorityDropDown.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        priorityDropDown.anchorView = self.selectPreorityBtn
        priorityDropDown.bottomOffset = CGPoint(x: -1, y: self.selectPreorityBtn.bounds.height)
        priorityDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectPreorityBtn.setTitle(item, for: .normal)
            self.priorityName = self.Priority[index]
            
        }
        
        
        
       
    }
    
    
    func convertSignatureToBase64(signatureView: SwiftSignatureView) -> String? {
        // Step 1: Render the signature as an image
      
        let signatureImage = signatureView.signature
        // Step 2: Convert the image to Data (PNG format)
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
                    let targetIndex = viewControllers.count - 6
                    if targetIndex >= 0 {
                        let targetViewController = viewControllers[targetIndex] as? IFMVC
                        if let targetViewController = targetViewController {
                            print("ok")
                        }
                        navigationController.popToViewController(targetViewController!, animated: true)
                    }
                }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
            self.commentTextView.text = ""
                   
       
    }
    @IBAction func backkClickBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapClearSign() {
        self.ticketGenrateBackGroundView.clear()
    }
    @IBAction func clickSubmitBtn() {
        
        self.signbase64 = self.convertSignatureToBase64(signatureView: self.ticketGenrateBackGroundView) ?? ""
        if self.isTicketCloseBack == true{
            self.callCloseTicketService()
           
        }else{
          
            self.callGenerateTicketService()
        }
        
    }
    @IBAction func ClickPreorityBtn() {
        priorityDropDown.show()
    }


    
}
extension Ticket_GenrateVC{
    func callGenerateTicketService(){
        var params: [String: Any] = [:]
        if self.commentTextView.text == "Enter your remarks"{
            self.taskListremark = ""
        }else{
            self.taskListremark = self.commentTextView.text
        }
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGenerateTicketService()
            }
            return
        }
    
        ActivityView.show(self.view)
        params["connectionKey"]             = "SAMS"
        params["empID"]               =  AppSession.user?.EmpNumber
        params["empName"]             = AppSession.user?.EmpName
        params["TicketType"]               =  self.TicketTypeNameFromBack
        params["TicketCategory"]             =  self.TicketCategoryNameFromBack
        params["Description"]             = self.taskListremark
        params["Priority"]               =  self.priorityName
        params["SignBase64"]             = self.signbase64
        
        params["ClientCode"]               =  self.ClientCodeFromVisitSiteFromBackk
        params["asmtID"]                  = self.AsmtIdfromSiteFromBackk
        params["LocationAutoid"]               =  self.LocationAutoIdfromSiteFromBackk
        params["CompanyCode"]             = self.CompanyCodefromSiteFromBackk
        
        print(params)
        WebServiceManager.shared.GenerateTicket(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.GenrateTicketData = data.compactMap({genrrate_Ticket_Modal(withData: $0)})
                      
                        for genTicketData in self.GenrateTicketData{
                            self.GenrateTicketNumber = genTicketData.TicketID
                        }
                       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Create_Ticket_ImageUploadVC") as? Create_Ticket_ImageUploadVC
                        vc?.genratTicketNumberFromBack = self.GenrateTicketNumber
                        self.navigationController?.pushViewController(vc!, animated: true)

                       
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
    
    func callCloseTicketService(){
        var params: [String: Any] = [:]
        if self.commentTextView.text == "Enter your remarks"{
            self.taskListremark = ""
        }else{
            self.taskListremark = self.commentTextView.text
        }
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callCloseTicketService()
            }
            return
        }
    
        ActivityView.show(self.view)
        params["connectionKey"]             = "SAMS"
        params["TicketNo"]               =  self.TicketNumberFromBackkk
        params["Remarks"]             =  self.taskListremark
        params["SignBase64"]               =  self.signbase64
        params["ImageBase64"]               = self.imgBase64FromBack
        
        
        print(params)
        WebServiceManager.shared.CloseTicket(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                            customAlert.delegate = self
                            customAlert.hideBut = true
                            customAlert.logoutBut = false
                            customAlert.onofflineBut = false
                            customAlert.modalPresentationStyle = .overCurrentContext
                            customAlert.providesPresentationContextTransitionStyle = true
                            customAlert.modalTransitionStyle = .crossDissolve
                            customAlert.titlestring = "Alert!"
                            customAlert.massage = "Ticket Closed Sucessfully !!"
                            self.present(customAlert, animated: true, completion: nil)
                            ActivityView.hide(self.view)
//                        self.TicektCategoryData = data.compactMap({Ticket_CategoryModal(withData: $0)})
//                        self.TicketCategoryNameList.removeAll()
//                        for VisitType in self.TicektCategoryData{
//                            self.TicketCategoryNameList.append(VisitType.TicketCategory)
//                        }
//                       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Create_Ticket_ImageUploadVC") as? Create_Ticket_ImageUploadVC
//                        self.navigationController?.pushViewController(vc!, animated: true)

                       
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
