//
//  MysteryRatingVC.swift
//  SMCApp
//
//  Created by 1707 on 31/01/24.
//

import UIKit

class MysteryRatingVC: UIViewController {
    //===========================================================
    //MARK: - IBOutlet
    //===========================================================
    @IBOutlet weak var mysteryRatingbackButton: UIButton!
    @IBOutlet weak var mysteryRatingscreenTitleLbl: UILabel!
    @IBOutlet weak var mysteryRatingfacilityTableView: UITableView!
    @IBOutlet weak var mysteryRatingfacillityProcedeBtn: UIButton!
    @IBOutlet weak var mysteryRatingquestionfromNumberLbl: UILabel!
    @IBOutlet weak var mysteryRatingtotalQuestionfromLbl: UILabel!
    @IBOutlet weak var mysteryRatingslaceLbl: UILabel!
    
    var MYRatingAuditIDD = Int()
    var MYRatingSiteTypeID = Int()
    var MYRatingLocationIDD = Int()
    var MYRatingcategoryIDd = String()
    var MYsteryRatingTypeID = Int()
    var MysteryRatingquestionDataMVCPattern = [QuestionDetailmodel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mysteryRatingfacillityProcedeBtn.layer.cornerRadius = 5
        self.navigationController?.navigationBar.isHidden = true
        if self.MYsteryRatingTypeID == 12001{
            self.mysteryRatingtotalQuestionfromLbl.text = "35"
            self.mysteryRatingquestionfromNumberLbl.text = "35"
            self.callgetAuditQuestionDetailsService()
            
        }else if self.MYsteryRatingTypeID == 12002 {
            self.mysteryRatingtotalQuestionfromLbl.text = "30"
            self.mysteryRatingquestionfromNumberLbl.text = "30"
            self.callgetAuditQuestionDetailsService()
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func mysteryRatingfacilityProcedeClickBtn(_ sender: Any) {
        
    }
    @IBAction func mysteryRatingfacilityBackBtn(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
    }
    


}
