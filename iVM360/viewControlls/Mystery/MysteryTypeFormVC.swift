//
//  MysteryTypeFormVC.swift
//  SMCApp
//
//  Created by 1707 on 25/01/24.
//

import UIKit

class MysteryTypeFormVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
//===========================================================
//MARK: - IBOutlet
//===========================================================
    @IBOutlet weak var mysteryTableView: UITableView!
    @IBOutlet weak var mysteryTitleLbl: UILabel!
    @IBOutlet weak var mysteryproceedeBtn: UIButton!
    @IBOutlet weak var mysteryFromNumberLbl: UILabel!
    @IBOutlet weak var mysteryTotalFromLbl: UILabel!
//===========================================================
//MARK: - create instance
//===========================================================
    var MysteryAuditIDD  = Int()
    var MysterySiteTypeID = Int()
    var MysteryLocationIDD = Int()
    var mysteryCategoryID = String()
    var MYsteryTypeID = Int()
    
    var MysteryquestionStatusData = QuestionStatusViewModel()
    var MysterystatusData = [QuestionStatusResponceData]()
    var MysteryquestionDataMVCPattern = [QuestionDetailmodel]()
//===========================================================
//MARK: - VC Life Cycle
//===========================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mysteryproceedeBtn.layer.cornerRadius = 5
        let nib = UINib(nibName: "MysteryTypeTableCell", bundle: nil)
        self.mysteryTableView.register(nib, forCellReuseIdentifier: "MysteryTypeTableCell")
        
        if self.MYsteryTypeID == 12001{
            self.mysteryTotalFromLbl.text = "35"
        }else if self.MYsteryTypeID == 12002 {
            self.mysteryTotalFromLbl.text = "30"
        }
        
        self.MysteryquestionStatusData.delegate = self
        ActivityView.show(self.view)
        let statusrequest = QuestionStatusRequest(locationId: "\(self.MysteryLocationIDD)", auditId: "\(self.MysteryAuditIDD)")
        print(statusrequest)
        self.MysteryquestionStatusData.QStatus(Requests: statusrequest)

    }
    @IBAction func mysteryproceedClickBtn(_ sender: Any){
        
//        self.callcreateMysteryAuditAnswerService()
        
    }
    @IBAction func mysterybackkClickBtn(_ sender: Any){
        
    }
    


}
