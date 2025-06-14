//
//  EngineeringAuditVC.swift
//  SMCApp
//
//  Created by 1707 on 11/01/24.
//

import UIKit

class EngineeringAuditVC: UIViewController, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
   
    
    @IBOutlet weak var engAuditTableView: UITableView!
    @IBOutlet weak var typeTitleLbl: UILabel!
    @IBOutlet weak var proccedeButton: UIButton!
    @IBOutlet weak var fromNumberLbl: UILabel!
    @IBOutlet weak var forwordSlaceLbl: UILabel!
    @IBOutlet weak var totalFromNumberLbl: UILabel!
    
    
    var alljson = [[String:Any]]()
    var auditIDDD = Int()
    var categoryIDD = String()
    var siteTypeIdd = Int()
    var locationIDDD = Int()
    var givenAllAnswer = [String]()
    var UniformDetails_Data = [UniformItemModal]()
//    var EngquestionViewModelData = QuestionViewModel()
//    var questionData = [QuestionresponceData]()
//    var engquestionStatusData = QuestionStatusViewModel()
//    var statusData = [QuestionStatusResponceData]()
//    var EnganswerData = AnswerViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.proccedeButton.layer.cornerRadius = 5
        self.navigationController?.navigationBar.isHidden = true
        let nib = UINib(nibName: "EngAuditTableCell", bundle: nil)
        self.engAuditTableView.register(nib, forCellReuseIdentifier: "EngAuditTableCell")
        self.callGetEmpUniformDetailsService()
       
//        self.EngquestionViewModelData.delegate = self
//        self.EnganswerData.delegate = self
//        self.engquestionStatusData.delegate = self
//        ActivityView.show(self.view)
//        let statusrequest = QuestionStatusRequest(locationId: "\(self.locationIDDD)", auditId: "\(self.auditIDDD)")
//        print(statusrequest)
//        self.engquestionStatusData.QStatus(Requests: statusrequest)
// 
        
    }
    
    @IBAction func proceedClickBtn(_ sender: Any) {
//        self.givenAllAnswer.removeAll()
//        alljson.removeAll()
//        for answer in questionDataMVCPattern{
//            var ans = [String:String]()
//            ans = [
//                "questionId":answer.auditQuestionId,
//                "answer":answer.isAnswer
//            ]
//            alljson.append(ans)
//            self.givenAllAnswer.append(answer.isAnswer)
//        }
//        print(self.givenAllAnswer)
//        let TrueAnsWer = self.givenAllAnswer.compactMap({ Int($0) })
//        if self.givenAllAnswer.count == TrueAnsWer.count{
//            self.callcreateAuditAnswerService()
//        }else{
//            let customAlert : AlertVC = AlertVC.instance()
//                   customAlert.delegate = self
//                   customAlert.hideBut = true
//                   customAlert.logoutBut = false
//                   customAlert.onofflineBut = false
//                   customAlert.modalPresentationStyle = .overCurrentContext
//                   customAlert.providesPresentationContextTransitionStyle = true
//                   customAlert.modalTransitionStyle = .crossDissolve
//                   customAlert.titlestring = "Alert"
//                   customAlert.massage = "plese give all questions answer"
//                   self.present(customAlert, animated: true, completion: nil)
//        }
        
        
    }
    
    @IBAction func backClickBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
      
    }

    
}
