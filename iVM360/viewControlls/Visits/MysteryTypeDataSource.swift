//
//  MysteryTypeDataSource.swift
//  SMCApp
//
//  Created by 1707 on 25/01/24.
//

import Foundation
import UIKit
extension MysteryTypeFormVC{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VisitCheckListNameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MysteryTypeTableCell", for: indexPath) as! MysteryTypeTableCell
        cell.selectionStyle = .none
        self.mysteryTableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        cell.yesBTN.tag = indexPath.row
        cell.noBTN.tag = indexPath.row
//        self.VisitCheckListNameData[indexPath.row].remarks = cell.mysteryremarkDetailTextView.text
//
       
    
          let data = VisitCheckListNameData[indexPath.row]
              cell.mysteryremarkDetailTextView.text = data.remarks.isEmpty ? "Enter Remarks" : data.remarks
              cell.mysteryremarkDetailTextView.textColor = data.remarks.isEmpty ? UIColor.lightGray : UIColor.black
              cell.mysteryremarkDetailTextView.tag = indexPath.row
              cell.mysteryremarkDetailTextView.delegate = self
        
        cell.noBTN.addTarget(self, action: #selector(clickViewPhotoBtn), for: .touchUpInside)
        cell.yesBTN.addTarget(self, action: #selector(clickAddPhotoBtn), for: .touchUpInside)
        cell.mysterySerialNumberLbl.text = "\(indexPath.row+1)" + "."
        cell.yesBTN.layer.cornerRadius = 10
        cell.yesBTN.layer.borderWidth = 1
        cell.yesBTN.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.noBTN.layer.cornerRadius = 10
        cell.mysteryremarkBackgroundView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.mysteryremarkBackgroundView.layer.borderWidth = 1
        cell.mysteryremarkBackgroundView.layer.cornerRadius = 10
        cell.backgroundViewvisits.layer.cornerRadius = 10
        cell.mysteryquestionLbl.text = self.VisitCheckListNameData[indexPath.row].ChecklistName
        
        return cell
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.text == "Enter Remarks" {
               textView.text = ""
               textView.textColor = UIColor.black
           }
       }

       func textViewDidChange(_ textView: UITextView) {
           let index = textView.tag
           VisitCheckListNameData[index].remarks = textView.text
       }

       func textViewDidEndEditing(_ textView: UITextView) {
           let index = textView.tag
           VisitCheckListNameData[index].remarks = textView.text
       }
}
extension MysteryTypeFormVC{
    
    @objc func clickAddPhotoBtn(sender: UIButton){
        self.isCameraopenshowImage = false
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImagesVC") as? ImagesVC
        if self.isScheduleWorkmatched == true{
            vc?.isScheduleworkdone = self.isScheduleWorkmatched
            vc?.AutoIdfromCheckList = self.VisitCheckListNameData[sender.tag].AutoID
            vc?.AsmtIdfromSiteFromBackk = self.AsmtIdfromSiteFromBack
            vc?.clintCodeFromBackk = self.clintCodeFromBack
            vc?.CompanyCodefromSiteFromBackk = self.CompanyCodefromSiteFromBack
            vc?.siteTypeNameFromBackk = self.siteTypeNameFromBack
            vc?.iscameraOpen = self.isCameraopenshowImage
            vc?.LocationIDFromBackk = self.LocationAutoIDFromBack
            vc?.checkListIDFromBackk = self.checklistIDFromBack
            
        }else{
            vc?.AutoIdfromCheckList = self.VisitCheckListNameData[sender.tag].AutoID
            vc?.AsmtIdfromSiteFromBackk = self.AsmtIdfromSiteFromBack
            vc?.clintCodeFromBackk = self.clintCodeFromBack
            vc?.CompanyCodefromSiteFromBackk = self.CompanyCodefromSiteFromBack
            vc?.siteTypeNameFromBackk = self.siteTypeNameFromBack
            vc?.iscameraOpen = self.isCameraopenshowImage
            vc?.LocationIDFromBackk = self.LocationAutoIDFromBack
           
        }
      
        self.navigationController?.pushViewController(vc!, animated: false)
        
        
    }
    @objc func clickViewPhotoBtn(sender: UIButton){
        self.isCameraopenshowImage = true
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImagesVC") as? ImagesVC
//        vc?.AutoIdfromCheckList = self.VisitCheckListNameData[sender.tag].AutoID
//        vc?.AsmtIdfromSiteFromBackk = self.AsmtIdfromSiteFromBack
//        vc?.clintCodeFromBackk = self.clintCodeFromBack
//        vc?.CompanyCodefromSiteFromBackk = self.CompanyCodefromSiteFromBack
//        vc?.siteTypeNameFromBackk = self.siteTypeNameFromBack
//        vc?.iscameraOpen = self.isCameraopenshowImage
//        vc?.isScheduleworkdone = self.isScheduleWorkmatched
//        vc?.checkListIDFromBackk = self.checklistIDFromBack
//        vc?.LocationIDFromBackk = self.LocationAutoIDFromBack
        
        if self.isScheduleWorkmatched == true{
            vc?.isScheduleworkdone = self.isScheduleWorkmatched
            vc?.AutoIdfromCheckList = self.VisitCheckListNameData[sender.tag].AutoID
            vc?.AsmtIdfromSiteFromBackk = self.AsmtIdfromSiteFromBack
            vc?.clintCodeFromBackk = self.clintCodeFromBack
            vc?.CompanyCodefromSiteFromBackk = self.CompanyCodefromSiteFromBack
            vc?.siteTypeNameFromBackk = self.siteTypeNameFromBack
            vc?.iscameraOpen = self.isCameraopenshowImage
            vc?.LocationIDFromBackk = self.LocationAutoIDFromBack
            vc?.checkListIDFromBackk = self.checklistIDFromBack
            
        }else{
            vc?.AutoIdfromCheckList = self.VisitCheckListNameData[sender.tag].AutoID
            vc?.AsmtIdfromSiteFromBackk = self.AsmtIdfromSiteFromBack
            vc?.clintCodeFromBackk = self.clintCodeFromBack
            vc?.CompanyCodefromSiteFromBackk = self.CompanyCodefromSiteFromBack
            vc?.siteTypeNameFromBackk = self.siteTypeNameFromBack
            vc?.iscameraOpen = self.isCameraopenshowImage
            vc?.LocationIDFromBackk = self.LocationAutoIDFromBack
           
        }
        self.navigationController?.pushViewController(vc!, animated: false)
    }

   
}
