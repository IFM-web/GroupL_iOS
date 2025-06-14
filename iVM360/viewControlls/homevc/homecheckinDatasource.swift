//
//  homecheckinDatasource.swift
//  iVM360
//
//  Created by 1707 on 16/07/24.
//

import UIKit
extension homeCheckinVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.sitetableview{
            return self.SiteListData.count
        }else if tableView == self.shifttableview{
            return self.ShiftListData.count
        }else{
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.sitetableview {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sitetableCell", for: indexPath) as! sitetableCell
            self.sitetableview.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            cell.selectionStyle = .none
            cell.sitesNamelist.text = "  " + self.SiteListData[indexPath.row].ClientSiteName
            return cell
            
        }else if tableView == self.shifttableview {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "ShiftTableCell", for: indexPath) as! ShiftTableCell
            self.shifttableview.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            cell1.selectionStyle = .none
            cell1.shiftSelectimageView.isHidden = true
            cell1.serialshiftLbl.isHidden = true
            cell1.shiftsNamelist.text = "  " + self.ShiftListData[indexPath.row].ShiftDetails

            return cell1
           
        }else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "unwantedTableCell", for: indexPath) as! unwantedTableCell
        return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.sitetableview{
            self.siteBtn.setTitle("  " + "\(self.SiteListData[indexPath.row].ClientSiteName)", for: .normal)
            animatesite(toogles: false)
            self.AsmtIDFromSite = self.SiteListData[indexPath.row].AsmtId
            self.ClientCodeFromSite = self.SiteListData[indexPath.row].ClientCode
            self.callGetEmployeeAttendanceDailyWithShiftService()
           
            
        }else if tableView == self.shifttableview{
            self.shiftBtn.setTitle("  " + "\(self.ShiftListData[indexPath.row].ShiftDetails)", for: .normal)
            animateshift(toogle: false)
            self.ShiftCode = self.ShiftListData[indexPath.row].ShiftCode
            self.checkinTime = self.ShiftListData[indexPath.row].InTime
            self.checkoutTime = self.ShiftListData[indexPath.row].OutTime
            if self.checkinTime.isEmpty == false && self.checkoutTime.isEmpty == true{
                self.checkoutBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
                self.checkinBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
            } else if self.checkinTime.isEmpty == true && self.checkoutTime.isEmpty == true{
                self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                self.checkinBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2078431373, alpha: 1)
            }else if self.checkinTime.isEmpty == false && self.checkoutTime.isEmpty == false{
                self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
                self.checkinBtn.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
            }
            
        }
        
    }
}
