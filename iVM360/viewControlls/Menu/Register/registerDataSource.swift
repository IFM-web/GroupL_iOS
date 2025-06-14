//
//  registerDataSource.swift
//  iVM360
//
//  Created by 1707 on 17/07/24.
//

//import UIKit
//extension RegisterVC: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//     
//            if tableView == self.regsitetableview{
//                return 4
//            }else{
//                return 4
//            }
//        }
//        
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            if tableView == self.regsitetableview {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterTableCell", for: indexPath) as! RegisterTableCell
//                self.regsitetableview.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
//                cell.selectionStyle = .none
//                //            cell.shiftsNamelist.text = shiftsList[indexPath.row].shiftName
//                return cell
//                
//            }else{
//                let cell2 = tableView.dequeueReusableCell(withIdentifier: "unwantedTableCell", for: indexPath) as! unwantedTableCell
//                return cell2
//            }
//        }
//        
//        
//}
