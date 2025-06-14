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
        return MysteryquestionDataMVCPattern.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MysteryTypeTableCell", for: indexPath) as! MysteryTypeTableCell
        cell.selectionStyle = .none
        self.mysteryTableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        cell.yesBTN.tag = indexPath.row
        cell.noBTN.tag = indexPath.row
        cell.noBTN.addTarget(self, action: #selector(clickNoBtn), for: .touchUpInside)
        cell.yesBTN.addTarget(self, action: #selector(clickYesBtn), for: .touchUpInside)
        cell.mysterySerialNumberLbl.text = "\(indexPath.row+1)" + "."
        cell.mysteryremarkBackgroundView.layer.borderColor = #colorLiteral(red: 1, green: 0.9333333333, blue: 0.3137254902, alpha: 1)
        cell.mysteryremarkBackgroundView.layer.borderWidth = 1
        cell.mysteryremarkBackgroundView.layer.cornerRadius = 10
        cell.mysteryquestionLbl.text = self.MysteryquestionDataMVCPattern[indexPath.row].question
        if self.MysteryquestionDataMVCPattern[indexPath.row].isYes == true{
            cell.yesBTN.setImage(UIImage(named: "Group 30602.png"), for: .normal)
            cell.noBTN.setImage(UIImage(named: "Vector.png"), for: .normal)
        }else if self.MysteryquestionDataMVCPattern[indexPath.row].isNo == true{
            cell.yesBTN.setImage(UIImage(named: "Vector.png"), for: .normal)
            cell.noBTN.setImage(UIImage(named: "Group 30602.png"), for: .normal)
        }else{
            cell.yesBTN.setImage(UIImage(named: "Vector.png"), for: .normal)
            cell.noBTN.setImage(UIImage(named: "Vector.png"), for: .normal)
        }
        
        return cell
    }
}
extension MysteryTypeFormVC{
    @objc func clickYesBtn(sender: UIButton){
        self.MysteryquestionDataMVCPattern[sender.tag].isYes = true
        self.MysteryquestionDataMVCPattern[sender.tag].isNo = false
        self.MysteryquestionDataMVCPattern[sender.tag].isAnswer = "1"
        self.mysteryTableView.reloadData()
        
        
    }
    @objc func clickNoBtn(sender: UIButton){
        MysteryquestionDataMVCPattern[sender.tag].isYes = false
        MysteryquestionDataMVCPattern[sender.tag].isNo = true
        self.MysteryquestionDataMVCPattern[sender.tag].isAnswer = "0"
        self.mysteryTableView.reloadData()
    }
}
