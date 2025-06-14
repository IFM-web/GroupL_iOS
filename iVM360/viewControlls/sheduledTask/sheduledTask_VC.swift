//
//  sheduledTask_VC.swift
//  iVM360
//
//  Created by 1707 on 02/08/24.
//

import UIKit
import DropDown
class sheduledTask_VC: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("ok")
    }
    
  
    
    @IBOutlet weak var loactionNsmeTableView: UITableView!
    @IBOutlet weak var selectsitbackgoundView: UIView!
    @IBOutlet weak var selectSite: UIButton!
    @IBOutlet weak var ContinueBTN: UIButton!
    
    
    var ScheduledSiteData = [Sites_VisitModal]()
    var ScheduledSitesNameList = [String]()
    let dropDownScheduledSite = DropDown()
    var ViewScheduledTaskData = [ViewScheduledTask_Modal]()
    var AsmtidfromSite = String()
    var ClientcodefromSite = String()
    var ASmtidFromScheduleWork = String()
    var ClientCodeFromScheduleWork = String()
    var checklistIDFromScheduleWork = String()
    var isScheduleWorkMatch = false
    var companyCodeFromSite = String()
    var LocationAutoIDFromSite = String()
    var ScheduledDateFromWork = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true 
//        self.ContinueBTN.isHidden = true
        self.selectsitbackgoundView.layer.cornerRadius = 10
        self.selectSite.layer.cornerRadius = 10
        self.ContinueBTN.layer.cornerRadius = 5
        self.callGetGeoMappedSitesSmartFMService()
        self.callViewTodayScheduledWorkService()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.loactionNsmeTableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        dropDownScheduledSite.cornerRadius = 5
        dropDownScheduledSite.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDownScheduledSite.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDownScheduledSite.anchorView = self.selectSite
        dropDownScheduledSite.bottomOffset = CGPoint(x: -1, y: self.selectSite.bounds.height)
        dropDownScheduledSite.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectSite.setTitle(item, for: .normal)
            self.AsmtidfromSite = self.ScheduledSiteData[index].AsmtId
            self.ClientcodefromSite = self.ScheduledSiteData[index].ClientCode
            self.companyCodeFromSite = self.ScheduledSiteData[index].CompanyCode
            self.LocationAutoIDFromSite = self.ScheduledSiteData[index].LocationAutoID

        }
        
        
  
    }
    @IBAction func SiteSelectClickBtn(_ sender: Any){
      
        dropDownScheduledSite.show()
    }
    
    @IBAction func todayTaskbackkClickBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
      
    }
    @IBAction func clickcontinuewBTN(_ sender: Any){
        self.callViewTodayScheduledWorkService()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ViewScheduledTaskData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        self.loactionNsmeTableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        
        cell.NameBackgroundView.layer.cornerRadius = 10
        cell.checklistNameLbl.text = self.ViewScheduledTaskData[indexPath.row].ChecklistName
        cell.checkListDateLbl.text = self.ViewScheduledTaskData[indexPath.row].ScheduleDate
        cell.custormerNameLbl.text = self.ViewScheduledTaskData[indexPath.row].ClientCodeName
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.ASmtidFromScheduleWork = self.ViewScheduledTaskData[indexPath.row].AsmtID
        self.ClientCodeFromScheduleWork = self.ViewScheduledTaskData[indexPath.row].ClientCode
        self.isScheduleWorkMatch = true
        self.checklistIDFromScheduleWork =  self.ViewScheduledTaskData[indexPath.row].ChecklistID
        self.ScheduledDateFromWork =  self.ViewScheduledTaskData[indexPath.row].ScheduleDate
        if self.AsmtidfromSite == self.ASmtidFromScheduleWork && self.ClientcodefromSite == self.ClientCodeFromScheduleWork{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MysteryTypeFormVC") as? MysteryTypeFormVC
            vc?.isScheduleWorkmatched = self.isScheduleWorkMatch
            vc?.checklistIDFromBack = self.checklistIDFromScheduleWork
            vc?.clintCodeFromBack = self.ClientCodeFromScheduleWork
            vc?.AsmtIdfromSiteFromBack = self.ASmtidFromScheduleWork
            vc?.CompanyCodefromSiteFromBack = self.ClientcodefromSite
            vc?.LocationAutoIDFromBack = self.LocationAutoIDFromSite
            vc?.SchduledDateFromBack = self.ScheduledDateFromWork
//            vc?.siteTypeNameFromBack = self.siteType
//            vc?.AsmtIdfromSiteFromBack = self.AsmtIdfromSite
//            vc?.CompanyCodefromSiteFromBack = self.CompanyCodefromSite
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
            customAlert.massage = "not Match Site"
            self.present(customAlert, animated: true, completion: nil)
        }
    }

}
