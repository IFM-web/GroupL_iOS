//
//  Profile_VC.swift
//  iVM360
//
//  Created by 1707 on 26/02/25.
//

import UIKit

class Profile_VC: UIViewController, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    @IBOutlet weak var data_BackGroundView: UIView!
    @IBOutlet weak var logo_ImageView: UIImageView!
    @IBOutlet weak var profile_Photo: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var degination_Lbl: UILabel!
    @IBOutlet weak var employee_CodeLbl: UILabel!
    @IBOutlet weak var contactNumber_Lbl: UILabel!
    @IBOutlet weak var client_NameLbl: UILabel!
    @IBOutlet weak var Site_NameLbl: UILabel!
    @IBOutlet weak var takePhoto_Btn: UIButton!
    @IBOutlet weak var submit_Btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.data_BackGroundView.layer.cornerRadius = 10
        self.takePhoto_Btn.layer.cornerRadius = 5
        self.submit_Btn.layer.cornerRadius = 5
        self.takePhoto_Btn.isHidden = true
        self.submit_Btn.isHidden = true
        self.data_BackGroundView.isHidden = true
        self.callGetEmpProfileService()
    }
    @IBAction func clickBack_Btn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clicktakePhotoBtn(_ sender: Any){
//        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickSubmitBtn(_ sender: Any){
//        self.navigationController?.popViewController(animated: true)
    }

}
extension Profile_VC{
    func callGetEmpProfileService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetEmpProfileService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
        params["EmpID"]  = AppSession.user?.EmpNumber
           
       
        print(params)
        WebServiceManager.shared.GetEmpProfile(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        
                        let designation = mainData["Designation"] as? String
                        let contactNumber = mainData["ContactNo"] as? String
                        let EmpNmae = mainData["EmpName"] as? String
                        let clientName = mainData["ClientName"] as? String
                        let Siteaddress = mainData["AsmtAddress"] as? String
                        let EmpCode = mainData["EmpID"] as? String
//                        let image_String = mainData["EmpID"] as? String
                        let base64String = mainData["ImageBase64String"] as? String
                        if let image = convertBase64ToImage(base64String: base64String ?? "") {
                            self.profile_Photo.image = image
                        } else {
                            print("Failed to convert Base64 to UIImage")
                        }
                        
                        self.data_BackGroundView.isHidden = false
                        self.nameLbl.text = EmpNmae
                        self.degination_Lbl.text = designation
                        self.employee_CodeLbl.text = EmpCode
                        self.contactNumber_Lbl.text = contactNumber
                        self.client_NameLbl.text = clientName
                        self.Site_NameLbl.text = Siteaddress
                        

                                } else {
                                    print("Data parsing error")
                                }
                }
                ActivityView.hide(self.view)
            case ServiceConst.Status.unauthorized:
               // AlertView.show(message: json["Message"] as? String)
                ActivityView.hide(self.view)
            default:
                let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                customAlert.delegate = self
                customAlert.hideBut = true
                customAlert.logoutBut = false
                customAlert.onofflineBut = false
                customAlert.modalPresentationStyle = .overCurrentContext
                customAlert.providesPresentationContextTransitionStyle = true
                customAlert.modalTransitionStyle = .crossDissolve
                customAlert.titlestring = "Alert"
               // customAlert.massage = json["message"] as? String
                self.present(customAlert, animated: true, completion: nil)
                ActivityView.hide(self.view)
            }
        }
    }
}
func convertBase64ToImage(base64String: String) -> UIImage? {
    guard let imageData = Data(base64Encoded: base64String) else {
        return nil
    }
    return UIImage(data: imageData)
}
