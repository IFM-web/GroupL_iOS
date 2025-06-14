//
//  MysteryTypeFormVC.swift
//  SMCApp
//
//  Created by 1707 on 25/01/24.
//

import UIKit
// MysteryType = visits
class MysteryTypeFormVC: UIViewController, UITableViewDataSource,UITableViewDelegate,UITextViewDelegate, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("cancel")
        if self.visitsuccess == true && self.visitJsonMsg == "Checklist Submitted Successfully !!"{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ClientDetaisVC") as? ClientDetaisVC
        vc?.clintCodeFromBackkk = self.clintCodeFromBack
        vc?.AsmtIdfromSiteFromBackkk = self.AsmtIdfromSiteFromBack
        vc?.CompanyCodefromSiteFromBackkk = self.CompanyCodefromSiteFromBack
        vc?.AutoIdfromCheckListFromBack = self.autoIdVisitFromBak
        vc?.designationVisitFromBackk = self.designationVisitFromBack
//        vc?.siteTypeNameFromBackkk = self.siteNameFromGeoFromBack
            vc?.siteTypeNameFromBackkk = self.siteTypeNameFromBack
    self.navigationController?.pushViewController(vc!, animated: true)
        }else if self.scheduleworksuccess == true{
//            self.navigationController?.popViewController(animated: true)
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ClientDetail_scheduledWorkVC") as? ClientDetail_scheduledWorkVC
        vc?.clintCodeFromBackkk = self.clintCodeFromBack
        vc?.AsmtIdfromSiteFromBackkk = self.AsmtIdfromSiteFromBack
        vc?.CompanyCodefromSiteFromBackkk = self.CompanyCodefromSiteFromBack
        vc?.AutoIdfromCheckListFromBack = self.autoIdVisitFromBak
        vc?.designationVisitFromBackk = self.designationVisitFromBack
//        vc?.siteTypeNameFromBackkk = self.siteNameFromGeoFromBack
            vc?.siteTypeNameFromBackkk = self.siteTypeNameFromBack
        vc?.isScheduleWorkShow = self.isScheduleWorkmatched
        vc?.checklistIdFromBackk = self.checklistIDFromBack
    self.navigationController?.pushViewController(vc!, animated: true)
        }
  
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
//===========================================================
//MARK: - IBOutlet
//===========================================================
    @IBOutlet weak var mysteryTableView: UITableView!
    @IBOutlet weak var mysteryTitleLbl: UILabel!
    @IBOutlet weak var mysteryproceedeBtn: UIButton!
    @IBOutlet weak var mysteryFromNumberLbl: UILabel!
    @IBOutlet weak var mysteryTotalFromLbl: UILabel!
//===========================================================
//MARK: - create instance
//===========================================================
    var autoIdVisitFromBak = String()
    var designationVisitFromBack = String()
    var clintCodeFromBack  = String()
    var siteTypeNameFromBack = String()
    var siteNameFromGeoFromBack = String()
    var AsmtIdfromSiteFromBack = String()
    var CompanyCodefromSiteFromBack = String()
    var checklistIDFromBack = String()
    var LocationAutoIDFromBack = String()
    var mysteryCategoryID = String()
    var MYsteryTypeID = Int()
    var isCameraopenshowImage = false
    var isScheduleWorkmatched = Bool()
    var CheckListJson = [[String:Any]]()
    var ScheduleWorkJson = [[String:Any]]()
    var remarksList: [String] = []
    var remarks = String()
    var SchduledDateFromBack = String()
//    var MysteryquestionStatusData = QuestionStatusViewModel()
    var VisitCheckListNameData = [Visit_CheckListModal]()
//    var MysteryquestionDataMVCPattern = [QuestionDetailmodel]()
    var visitJsonMsg = String()
    var visitsuccess = false
    var scheduleworkJsonMsg = String()
    var scheduleworksuccess = false
//===========================================================
//MARK: - VC Life Cycle
//===========================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        if isScheduleWorkmatched == true{
            self.callGetScheduledWorkChecklistSmartFMService()
        }else{
            self.callGetVisitChecklistSmartFMIOSService()
        }
      
        self.mysteryproceedeBtn.layer.cornerRadius = 5
        let nib = UINib(nibName: "MysteryTypeTableCell", bundle: nil)
        self.mysteryTableView.register(nib, forCellReuseIdentifier: "MysteryTypeTableCell")
        

     

    }
    override func viewWillAppear(_ animated: Bool) {
//        if isScheduleWorkmatched == true{
//            self.callGetScheduledWorkChecklistSmartFMService()
//        }else{
//            self.callGetVisitChecklistSmartFMService()
//        }
    }
    @IBAction func mysteryproceedClickBtn(_ sender: Any){
        if isScheduleWorkmatched == true{
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ClientDetaisVC") as? ClientDetaisVC
//    vc?.isScheduleWorkShow = self.isScheduleWorkmatched
//            self.navigationController?.pushViewController(vc!, animated: true)
            self.ScheduleWorkJson.removeAll()
            for remar in self.VisitCheckListNameData{
                var Ans = ["asmtID":self.AsmtIdfromSiteFromBack,
                   "ClientCode":self.clintCodeFromBack,
                   "CompanyCode":self.CompanyCodefromSiteFromBack,
                    "ChecklistID": self.checklistIDFromBack,
                   "empID": AppSession.user?.EmpNumber ?? "",
                   "empName": AppSession.user?.EmpName ?? "",
                   "LocationAutoID": AppSession.user?.LocationAutoID ?? "",
                     "Remarks":remar.remarks,
                     "ChecklistHeaderAutoID":remar.AutoID,
                    "ScheduleDate":self.SchduledDateFromBack]
              self.ScheduleWorkJson.append(Ans)
            }
            
            let remark = self.ScheduleWorkJson.filter { !($0["Remarks"] as? String ?? "").isEmpty }
            if self.VisitCheckListNameData.count == remark.count{
                self.callInsertScheduledWorkChecklistSmartFMJsonService()
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
                customAlert.massage = "Please give all CheckList Remark"
                self.present(customAlert, animated: true, completion: nil)
                ActivityView.hide(self.view)
            }
           
        }else{

            self.CheckListJson.removeAll()
            for remar in self.VisitCheckListNameData{
                let Ans = ["asmtID":self.AsmtIdfromSiteFromBack,
                   "ClientCode":self.clintCodeFromBack,
                   "CompanyCode":self.CompanyCodefromSiteFromBack,
                   "Designation": AppSession.user?.Designation ?? "",
                   "empID": AppSession.user?.EmpNumber ?? "",
                   "empName": AppSession.user?.EmpName ?? "",
                           "LocationAutoID": Int(self.LocationAutoIDFromBack) as Any,
                     "Remarks":remar.remarks,
                           "VisitAutoID":Int(remar.AutoID) as Any,
                           "VisitType":self.siteTypeNameFromBack] as [String : Any]
              self.CheckListJson.append(Ans)
            }
            print(self.VisitCheckListNameData.count)
            print(self.CheckListJson.count)
            let remark = self.CheckListJson.filter { !($0["Remarks"] as? String ?? "").isEmpty }
            print(remark.count)
            if self.VisitCheckListNameData.count == remark.count{
                self.callInsertVisitChecklistSmartFMJsonService()
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
                customAlert.massage = "Please give all CheckList Remark"
                self.present(customAlert, animated: true, completion: nil)
                ActivityView.hide(self.view)
            }
           
        }
       
    }
    @IBAction func mysterybackkClickBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
  
    
    

}
//extension Dictionary {
//    var toJSONString: String {
//        do {
//            let data1 =  try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
//            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
//            return convertedString ?? "not able to convert to JSON String" // <-- here is ur string
//            
//        } catch let myJSONError {
//            print(myJSONError)
//        }
//        return ""
//    }
//}

extension Array where Element == [String: Any] {
    var toJSONString: String {
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data1, encoding: String.Encoding.utf8)
            return convertedString ?? "not able to convert to JSON String"
        } catch let myJSONError {
            print(myJSONError)
        }
        return ""
    }
}
