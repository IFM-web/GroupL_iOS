//
//  RegisterVC.swift
//  iVM360
//
//  Created by 1707 on 16/07/24.
//

import UIKit
import DropDown

class RegisterVC: UIViewController, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    @IBOutlet weak var regbackGroundView: UIView!
    @IBOutlet weak var regsitetablebackgroundView: UIView!
    @IBOutlet weak var regsiteHight: NSLayoutConstraint!
    @IBOutlet weak var regsiteBtn: UIButton!
    @IBOutlet weak var regsitetableview: UITableView!
    @IBOutlet weak var regunwantedtableview: UITableView!
    @IBOutlet weak var regimagelogo: UIImageView!
    @IBOutlet weak var regNameFld: UITextField!
    @IBOutlet weak var regperposeFld: UITextField!
    @IBOutlet weak var regNumberFld: UITextField!
    @IBOutlet weak var addPhoto: UIButton!
    @IBOutlet weak var register_Submit_Btn: UIButton!
    let Register_dropDownIFMSite = DropDown()
    var Register_visitSiteData = [Sites_VisitModal]()
    var Register_visitSitesNameList = [String]()
    
    var Register_ClientCodeFromVisitSite = String()
    var siteType = String()
    var Register_LocationAutoIdfromSite = String()
    var Register_siteNameFromGeoSite = String()
    
    var Register_checkListmarklastImg = UIImage()
    var Register_checkListmarkbased64VPhoto  = ""
    var Register_checkListmarkimgColBase64 = [String]()
    var Register_checkListmarkaddImages = [UIImage]()
    var name = String()
    var purpose = String()
    var moile = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.regsiteBtn.layer.cornerRadius = 5
        self.register_Submit_Btn.layer.cornerRadius = 5
        self.addPhoto.layer.borderWidth = 2
        self.addPhoto.layer.borderColor = #colorLiteral(red: 0.9882352941, green: 0.2117647059, blue: 0, alpha: 1)
        self.addPhoto.layer.cornerRadius = 22.5
        self.callGetGeoMappedSitesSmartFMService()
        Register_dropDownIFMSite.cornerRadius = 5
        Register_dropDownIFMSite.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Register_dropDownIFMSite.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Register_dropDownIFMSite.anchorView = self.regsiteBtn
        Register_dropDownIFMSite.bottomOffset = CGPoint(x: -1, y: self.regsiteBtn.bounds.height)
        Register_dropDownIFMSite.selectionAction = { [unowned self] (index: Int, item: String) in
            self.regsiteBtn.setTitle(item, for: .normal)
                        self.Register_ClientCodeFromVisitSite = self.Register_visitSiteData[index].ClientCode
                        self.Register_LocationAutoIdfromSite = self.Register_visitSiteData[index].LocationAutoID
                        self.Register_siteNameFromGeoSite = self.Register_visitSiteData[index].SiteName

            
        }
        
    }
    
    @IBAction func clickBackBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickSubmitBtn(_ sender: Any){
   
        self.name = self.regNameFld.text ?? ""
        self.purpose = self.regperposeFld.text ?? ""
        self.moile = self.regNumberFld.text ?? ""
        
        if self.Register_ClientCodeFromVisitSite.isEmpty == false && self.Register_checkListmarkbased64VPhoto.isEmpty == false &&  self.name.isEmpty == false && self.purpose.isEmpty == false && self.moile.isEmpty == false {
            self.callInsertRegisterEntryService()
        }else{
            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "give all details"
            self.present(customAlert, animated: true, completion: nil)
        }
       
    }
    
    @IBAction func clickregSitesBtn(_ sender: Any){
        Register_dropDownIFMSite.show()
    }
    
    @IBAction func clickaddPhotoBtn(_ sender: Any){
       showAlert()
    }
    
    
    
    func resizeImage(_ image: UIImage, newSize: CGSize) -> UIImage {
            UIGraphicsBeginImageContext(newSize)
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage ?? image
        }
    
    
    
    
    func callGetGeoMappedSitesSmartFMService(){
        var params: [String: Any] = [:]
        
        
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetGeoMappedSitesSmartFMService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["LocationAutoId"]      = AppSession.user?.LocationAutoID
        if let location         = LocationManager.shared.currentLocation {
            params["latitude"]  = location.coordinate.latitude.string
            params["longitude"] = location.coordinate.longitude.string
        }
       
        print(params)
        WebServiceManager.shared.GetGeoMappedSitesSmartFM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.Register_visitSiteData = data.compactMap({Sites_VisitModal(withData: $0)})
                        self.Register_visitSitesNameList.removeAll()
                        for VisitSitelists in self.Register_visitSiteData{
                            self.Register_visitSitesNameList.append(VisitSitelists.SiteName)
                        }
                        self.Register_dropDownIFMSite.dataSource = self.Register_visitSitesNameList

                       
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
    
    
    func callInsertRegisterEntryService(){
        var params: [String: Any] = [:]
        
      
        
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callInsertRegisterEntryService()
            }
            return
        }
        //       let deviceToken = UserDefaults.standard.string(forKey: "Token")
        ActivityView.show(self.view)
        params["connectionKey"]  = "SAMS"
        params["LocationAutoId"]      = self.Register_LocationAutoIdfromSite
        params["ClientCode"]      = self.Register_ClientCodeFromVisitSite
        params["EmployeeID"]  = AppSession.user?.EmpNumber
        params["EmployeeName"] = AppSession.user?.EmpName
        params["VisitorImageBase64"]  = Register_checkListmarkbased64VPhoto
        params["VisitorName"] = self.name
        params["Purpose"]  = self.purpose
        params["Mobile"] = self.moile
        
       
        print(params)
        WebServiceManager.shared.InsertRegisterEntry(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
//                        let messageID = mainData["MessageID"] as? Int
                        let messageString = mainData["MessageString"] as? String
                        if messageString == "Sucessfully Inserted" {
                            self.navigationController?.popViewController(animated: true)
                        }else{
                            let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                            customAlert.delegate = self
                            customAlert.hideBut = true
                            customAlert.logoutBut = false
                            customAlert.onofflineBut = false
                            customAlert.modalPresentationStyle = .overCurrentContext
                            customAlert.providesPresentationContextTransitionStyle = true
                            customAlert.modalTransitionStyle = .crossDissolve
                            customAlert.titlestring = "Alert"
                            customAlert.massage = messageString
                            self.present(customAlert, animated: true, completion: nil)
                            ActivityView.hide(self.view)
                        }
                       


                       
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


extension RegisterVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: - showAlert Function
    func showAlert() {
        let alert = UIAlertController(title:  "", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) in
            self.photoFromCamera()
        })
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {(alert: UIAlertAction!) in })
        alert.addAction(cameraAction)
        alert.addAction(cancel)
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
            if let currentPopoverpresentioncontroller = alert.popoverPresentationController{
                currentPopoverpresentioncontroller.sourceView = self.tabBarController?.tabBar
                currentPopoverpresentioncontroller.sourceRect = self.view.bounds
                currentPopoverpresentioncontroller.permittedArrowDirections = UIPopoverArrowDirection.down;
                self.present(alert, animated: true, completion: nil)
            }
        }else {
            self.present(alert, animated: true, completion: nil)
        }
    }


    //MARK: - photoFromCamera Function
    func photoFromCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.cameraDevice = .front
            picker.modalPresentationStyle = .fullScreen
            picker.allowsEditing = false
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)

        } else {
            let alert = UIAlertController(title: "Alert", message: "Camera is not available in simulator", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }

    //MARK: - UIImagePicker DelegateMethod's:------
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //MARK: imagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        DispatchQueue.main.async() {
            guard let images = info[.originalImage] as? UIImage else {
                print("No image found")
                return
            }
        
            let resizedImage = self.resizeImage(images, newSize: CGSize(width: 400, height: 200))
            let compressedImage = resizedImage.compress(toKB: 200)
            self.Register_checkListmarkaddImages.append(compressedImage ??  UIImage())
//            self.checkListimageCollectionView.reloadData()
            var filename = ""
            var extImg = ""
            if  picker.sourceType == UIImagePickerController.SourceType.camera {
                filename = "Camera_Image.png"
                extImg = "PNG"
            } else {
                guard let url = info[.imageURL] as? NSURL else { return }
                filename = url.lastPathComponent!
                extImg = url.pathExtension ?? ""
                print("filename",filename, "extImg",extImg)
            }

            DispatchQueue.main.async {
                let imgData = NSData(data: compressedImage?.jpegData(compressionQuality: 0.03125)! ?? Data())
                let imageSize: Int = imgData.count
                print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
                let images = UIImage(data: imgData as Data)

                func convertImageToBase64String (img: UIImage) -> String {
                    let imageData:NSData = img.pngData()! as NSData
                    let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
                    return imgString
                }
                
                self.Register_checkListmarklastImg = images ?? UIImage()
                self.Register_checkListmarkbased64VPhoto = images?.toBase64() ?? ""
                self.Register_checkListmarkimgColBase64.append("data:image/png;base64," + self.Register_checkListmarkbased64VPhoto)
                let image = self.Register_checkListmarklastImg
                self.regimagelogo.image = image

            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
