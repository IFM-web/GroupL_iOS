//
//  Ticket_DetailsVC.swift
//  iVM360
//
//  Created by 1707 on 07/08/24.
//

import UIKit

class Ticket_DetailsVC: UIViewController, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    @IBOutlet weak var ticktDetailBackGroundView: UIView!
    @IBOutlet weak var clientNameBackGroundView: UIView!
    @IBOutlet weak var siteNamebackgoundView: UIView!
    @IBOutlet weak var ticketNumerbackgoundView: UIView!
    @IBOutlet weak var ticketTypebackgoundView: UIView!
    @IBOutlet weak var ticketCategorybackgoundView: UIView!
    @IBOutlet weak var ticketDiscriptionbackgoundView: UIView!
    @IBOutlet weak var ticketprioritybackgoundView: UIView!
    @IBOutlet weak var ticketDatebackgoundView: UIView!
    @IBOutlet weak var clientNameLbl: UILabel!
    @IBOutlet weak var siteNameLbl: UILabel!
    @IBOutlet weak var ticketNumberLbl: UILabel!
    @IBOutlet weak var ticketTypeNameLbl: UILabel!
    @IBOutlet weak var ticketCategoryLbl: UILabel!
    @IBOutlet weak var ticketDiscriptionLbl: UILabel!
    @IBOutlet weak var ticketAssignmentDateLbl: UILabel!
    @IBOutlet weak var ticketPriorityLbl: UILabel!
    @IBOutlet weak var openTicketImageView: UIImageView!
    @IBOutlet weak var contineuBtn: UIButton!
  
    var TicketNumberFromBack = String()
    var TicketDetailsData = [TicketDetails_modal]()
    var ImageString_base64 = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callGetTicketDetailsService()
        self.ticktDetailBackGroundView.layer.cornerRadius = 10
        self.clientNameBackGroundView.layer.cornerRadius = 5
        self.siteNamebackgoundView.layer.cornerRadius = 5
        self.ticketDatebackgoundView.layer.cornerRadius = 5
        self.ticketNumerbackgoundView.layer.cornerRadius = 5
        self.ticketTypebackgoundView.layer.cornerRadius = 5
        self.ticketCategorybackgoundView.layer.cornerRadius = 5
        self.ticketDiscriptionbackgoundView.layer.cornerRadius = 5
        self.ticketprioritybackgoundView.layer.cornerRadius = 5
        self.contineuBtn.layer.cornerRadius = 5
        self.openTicketImageView.layer.cornerRadius = 10
        
    }
    
    @IBAction func continueBtn(_ sender: Any){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Close_TicketVC") as? Close_TicketVC
        vc?.TicketNumberFromBackk = self.TicketNumberFromBack
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func detailBackClickBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }

}
