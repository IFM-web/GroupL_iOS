//
//  Assign_TicketsVC.swift
//  iVM360
//
//  Created by 1707 on 07/08/24.
//

import UIKit

class Assign_TicketsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
  
    
    @IBOutlet weak var assignTicketListTableView: UITableView!
    
    var AssignedTicketListData = [AssignedTicket_Modal]()
    var TicketNumber_assignTickt = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true 
        self.callGetAssignedTicketListService()
        let nib = UINib(nibName: "AssignTicketTablecell", bundle: nil)
        self.assignTicketListTableView.register(nib, forCellReuseIdentifier: "AssignTicketTablecell")
  
       
    }
    @IBAction func AssignTicketbackkClickBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
      
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.AssignedTicketListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignTicketTablecell", for: indexPath) as! AssignTicketTablecell
        cell.selectionStyle = .none
        self.assignTicketListTableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        cell.assignTicketBackgroundView.layer.cornerRadius = 10
        cell.AssignTicketSerialNumberLbl.text = "\(indexPath.row + 1)"
        cell.clientNameLbl.text = self.AssignedTicketListData[indexPath.row].ClientName
        cell.siteNameLbl.text = self.AssignedTicketListData[indexPath.row].SiteName
        cell.ticketNumberLbl.text = self.AssignedTicketListData[indexPath.row].TicketNo
        cell.ticketTypeLbl.text = self.AssignedTicketListData[indexPath.row].TicketType
        cell.ticketCategoryLbl.text = self.AssignedTicketListData[indexPath.row].TicketCategory
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.TicketNumber_assignTickt = self.AssignedTicketListData[indexPath.row].TicketNo
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Ticket_DetailsVC") as? Ticket_DetailsVC
        vc?.TicketNumberFromBack = self.TicketNumber_assignTickt
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
