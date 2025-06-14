//
//  IFMDatasource.swift
//  iVM360
//
//  Created by 1707 on 17/07/24.
//

import UIKit
extension IFMVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == self.fmsitetableview{
            return 4
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == self.fmsitetableview {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FMSiteTableCell", for: indexPath) as! FMSiteTableCell
//            self.fmsitetableview.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            cell.selectionStyle = .none
//            cell.shiftsNamelist.text = shiftsList[indexPath.row].shiftName
            return cell
            
//        }
    }
    
    
}
