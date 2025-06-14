//
//  EngAuditDataSource.swift
//  SMCApp
//
//  Created by 1707 on 11/01/24.
//

import Foundation
import UIKit

extension EngineeringAuditVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.UniformDetails_Data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EngAuditTableCell", for: indexPath) as! EngAuditTableCell
        cell.selectionStyle = .none
        self.engAuditTableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        cell.yesButton.tag = indexPath.row
        cell.noButton.tag = indexPath.row
        cell.noButton.addTarget(self, action: #selector(clickNoBtn), for: .touchUpInside)
        cell.yesButton.addTarget(self, action: #selector(clickYesBtn), for: .touchUpInside)
        cell.searialLbl.text = "\(indexPath.row+1)" + "."
        cell.questionnLbl.text = self.UniformDetails_Data[indexPath.row].uniformItem
        if self.UniformDetails_Data[indexPath.row].status == "Yes"{
            cell.yesButton.setImage(UIImage(named: "Group 30602.png"), for: .normal)
            cell.noButton.setImage(UIImage(named: "Vector.png"), for: .normal)
        }else{
            cell.yesButton.setImage(UIImage(named: "Vector.png"), for: .normal)
            cell.noButton.setImage(UIImage(named: "Group 30602.png"), for: .normal)
        }
//        if self.UniformDetails_Data[indexPath.row].isYes == true{
//            cell.yesButton.setImage(UIImage(named: "Group 30602.png"), for: .normal)
//            cell.noButton.setImage(UIImage(named: "Vector.png"), for: .normal)
//        }else if self.UniformDetails_Data[indexPath.row].isNo == true{
//            cell.yesButton.setImage(UIImage(named: "Vector.png"), for: .normal)
//            cell.noButton.setImage(UIImage(named: "Group 30602.png"), for: .normal)
//        }else{
//            cell.yesButton.setImage(UIImage(named: "Vector.png"), for: .normal)
//            cell.noButton.setImage(UIImage(named: "Vector.png"), for: .normal)
//        }
        
        return cell
    }
    
    
}
extension EngineeringAuditVC{
    @objc func clickYesBtn(sender: UIButton){
        self.UniformDetails_Data[sender.tag].isYes = true
        self.UniformDetails_Data[sender.tag].isNo = false
//        self.UniformDetails_Data[sender.tag].isAnswer = "1"
        self.engAuditTableView.reloadData()
        
        
    }
    @objc func clickNoBtn(sender: UIButton){
        UniformDetails_Data[sender.tag].isYes = false
        UniformDetails_Data[sender.tag].isNo = true
//        self.UniformDetails_Data[sender.tag].isAnswer = "0"
        self.engAuditTableView.reloadData()
    }
}
