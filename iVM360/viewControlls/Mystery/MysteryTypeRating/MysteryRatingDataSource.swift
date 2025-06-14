//
//  MysteryRatingDataSource.swift
//  SMCApp
//
//  Created by 1707 on 31/01/24.
//

import Foundation
import UIKit
extension MysteryRatingVC: UITableViewDelegate, UITableViewDataSource {
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MysteryRatingquestionDataMVCPattern.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MysteryRatingTableCell", for: indexPath) as! MysteryRatingTableCell
        cell.selectionStyle = .none
        self.mysteryRatingfacilityTableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        cell.MysteryRatingserialNumberLbl.text = "\(indexPath.row+1)" + "."
        cell.MysteryRatingquestionLbl.text = MysteryRatingquestionDataMVCPattern[indexPath.row].question
         return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    
    
    
}
