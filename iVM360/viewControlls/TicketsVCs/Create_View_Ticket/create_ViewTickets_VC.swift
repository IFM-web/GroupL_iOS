//
//  create_ViewTickets_VC.swift
//  iVM360
//
//  Created by 1707 on 02/08/24.
//

import UIKit
import DropDown
class create_ViewTickets_VC: UIViewController, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    

    @IBOutlet weak var ticketsbackgoundView: UIView!
    @IBOutlet weak var cteateTicketBtn: UIButton!
    @IBOutlet weak var ViewTicketsBTn: UIButton!
    @IBOutlet weak var TransparentkgoundView: UIView!
    @IBOutlet weak var ticketDropDownbackgoundView: UIView!
    @IBOutlet weak var ticketTypeBtn: UIButton!
    @IBOutlet weak var ticketCategoryBTn: UIButton!
    @IBOutlet weak var selectOKBtn: UIButton!
    @IBOutlet weak var SelectCancelBTn: UIButton!
    
    let dropDown_TicketType = DropDown()
    let dropDown_TicketCategory = DropDown()
    var TicketTypeData = [Ticket_TypeModa]()
    var TicektCategoryData = [Ticket_CategoryModal]()
    var TicketTypeNameList = [String]()
    var TicketCategoryNameList = [String]()
    var TicketTypeName = String()
    var TicketCategoryName = String()
    
    var ClientCodeFromVisitSitefromBack = String()
    var AsmtIdfromSitefromBack = String()
    var CompanyCodefromSitefromBack = String()
    var LocationAutoIdfromSitefromBack = String()
    var isGenerateNewTicket = false
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true 
        self.TransparentkgoundView.isHidden = true
        self.ticketDropDownbackgoundView.layer.cornerRadius = 10
        self.ticketTypeBtn.layer.cornerRadius = 5
        self.ticketCategoryBTn.layer.cornerRadius = 5
        self.ticketsbackgoundView.layer.cornerRadius = 10
        self.ViewTicketsBTn.layer.cornerRadius = 10
        self.cteateTicketBtn.layer.cornerRadius = 10
        self.callGetTicketTypeService()
        dropDown_TicketType.cornerRadius = 5
        dropDown_TicketType.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown_TicketType.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown_TicketType.anchorView = self.ticketTypeBtn
        dropDown_TicketType.bottomOffset = CGPoint(x: -1, y: self.ticketTypeBtn.bounds.height)
        dropDown_TicketType.selectionAction = { [unowned self] (index: Int, item: String) in
            self.ticketTypeBtn.setTitle(item, for: .normal)
            self.TicketTypeName = self.TicketTypeData[index].TicketType
//                        self.AsmtIdfromSite = self.visitSiteData[index].AsmtId
//                        self.CompanyCodefromSite = self.visitSiteData[index].CompanyCode
//                        self.LocationAutoIdfromSite = self.visitSiteData[index].LocationAutoID
                         self.callGetTicketCategoryService()

            
        }
        dropDown_TicketCategory.cornerRadius = 5
        dropDown_TicketCategory.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown_TicketCategory.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown_TicketCategory.anchorView = self.ticketCategoryBTn
        dropDown_TicketCategory.bottomOffset = CGPoint(x: -1, y: self.ticketCategoryBTn.bounds.height)
        dropDown_TicketCategory.selectionAction = { [unowned self] (index: Int, item: String) in
            self.ticketCategoryBTn.setTitle(item, for: .normal)
            self.TicketCategoryName = self.TicektCategoryData[index].TicketCategory
//            self.isvisitSelection = true
//            self.siteType = self.visitsTypeData[index].ChecklistHeader
            
        }
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.TransparentkgoundView.isHidden = true
    }
    
    @IBAction func ViewTicketClickBtn(_ sender: Any){
        self.isGenerateNewTicket = false
        self.TransparentkgoundView.isHidden = false
    }
    @IBAction func createTicketClickBtn(_ sender: Any){
        self.isGenerateNewTicket = true
        self.TransparentkgoundView.isHidden = false
    }
    @IBAction func backTicketClickBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func TicketTypeClickBtn(_ sender: Any){
        dropDown_TicketType.show()
    }
    @IBAction func TicketCategoryClickBtn(_ sender: Any){
        dropDown_TicketCategory.show()
    }
    @IBAction func selectOKClickBtn(_ sender: Any){
        if self.isGenerateNewTicket == true{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Ticket_GenrateVC") as? Ticket_GenrateVC
            vc?.TicketTypeNameFromBack         = self.TicketTypeName
            vc?.TicketCategoryNameFromBack      = self.TicketCategoryName
            vc?.ClientCodeFromVisitSiteFromBackk = self.ClientCodeFromVisitSitefromBack
            vc?.AsmtIdfromSiteFromBackk         = self.AsmtIdfromSitefromBack
            vc?.CompanyCodefromSiteFromBackk    = self.CompanyCodefromSitefromBack
            vc?.LocationAutoIdfromSiteFromBackk  = self.LocationAutoIdfromSitefromBack
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Assign_TicketsVC") as? Assign_TicketsVC
//            vc?.TicketTypeNameFromBack         = self.TicketTypeName
//            vc?.TicketCategoryNameFromBack      = self.TicketCategoryName
//            vc?.ClientCodeFromVisitSiteFromBackk = self.ClientCodeFromVisitSitefromBack
//            vc?.AsmtIdfromSiteFromBackk         = self.AsmtIdfromSitefromBack
//            vc?.CompanyCodefromSiteFromBackk    = self.CompanyCodefromSitefromBack
//            vc?.LocationAutoIdfromSiteFromBackk  = self.LocationAutoIdfromSitefromBack
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    @IBAction func selectCancelClickBtn(_ sender: Any){
        self.TransparentkgoundView.isHidden = true
    }

}

