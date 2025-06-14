//
//  ImagesVC.swift
//  iVM360
//
//  Created by 1707 on 01/08/24.
//

import UIKit

class ImagesVC: UIViewController, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    

    @IBOutlet weak var ShowGetimageView: UIImageView!
    @IBOutlet weak var TitleView: UIView!
    var imageData = [Images_Modal]()
    var Base64String = String()
    var clintCodeFromBackk  = String()
    var siteTypeNameFromBackk = String()
    var AsmtIdfromSiteFromBackk = String()
    var CompanyCodefromSiteFromBackk = String()
    var AutoIdfromCheckList = String()
    var LocationIDFromBackk = String()
    var checkListIDFromBackk = String()
    
    var checkListmarklastImg = UIImage()
    var checkListImagebased64VPhoto  = ""
    var checkListmarkimgColBase64 = [String]()
    var checkListmarkaddImages = [UIImage]()
    var iscameraOpen = Bool()
    var isScheduleworkdone = Bool()
    var apistatus = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.ShowGetimageView.layer.cornerRadius = 10
        
        if self.iscameraOpen == false{
//            self.TitleView.isHidden = true
            self.ShowGetimageView.isHidden = true
               showAlert()
        }else{
//            self.TitleView.isHidden = false
            self.ShowGetimageView.isHidden = false
            if self.isScheduleworkdone == true{
                self.callGetScheduledWorkChecklistImageSmartFMService()
            }else{
                self.callGetVisitChecklistImageSmartFMService()
            }
           
                     
        }
        
    }
    
    @IBAction func imagebackkClickBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    
//    func configure(with image: UIImage) {
//        ShowGetimageView.image = image
//            }
    
    func resizeImage(_ image: UIImage, newSize: CGSize) -> UIImage {
            UIGraphicsBeginImageContext(newSize)
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage ?? image
        }
}


extension ImagesVC{
    @available(iOS 13.0, *)
    func callInsertVisitChecklistImageSmartFMService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callInsertVisitChecklistImageSmartFMService()
            }
            return
        }
      
        ActivityView.show(self.view)
        params["connectionKey"]              = "SAMS"
        params["empID"]                     = AppSession.user?.EmpNumber
        params["empName"]                   = AppSession.user?.EmpName
        params["Designation"]               = AppSession.user?.Designation
        params["LocationAutoid"]              = AppSession.user?.LocationAutoID
        params["VisitChecklistImageBase64"]    = self.checkListImagebased64VPhoto
        params["ClientCode"]                 = self.clintCodeFromBackk
        params["asmtID"]                     = self.AsmtIdfromSiteFromBackk
        params["CompanyCode"]                = self.CompanyCodefromSiteFromBackk
        params["VisitType"]                 = self.siteTypeNameFromBackk
        params["VisitAutoID"]               = self.AutoIdfromCheckList
        print(params)
        WebServiceManager.shared.InsertVisitChecklistImageSmartFM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.navigationController?.popViewController(animated: true)
//                        self.VisitCheckListNameData = data.compactMap({Visit_CheckListModal(withData: $0)})

                       
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
    
    func callInsertScheduledWorkChecklistImageSmartFMService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callInsertScheduledWorkChecklistImageSmartFMService()
            }
            return
        }
      
        ActivityView.show(self.view)
        params["connectionKey"]              = "SAMS"
        params["empID"]                     = AppSession.user?.EmpNumber
        params["empName"]                   = AppSession.user?.EmpName
        params["ChecklistHeaderAutoID"]       = self.AutoIdfromCheckList
        params["LocationAutoid"]              = AppSession.user?.LocationAutoID
        params["ChecklistImageBase64"]        = self.checkListImagebased64VPhoto
        params["ClientCode"]                 = self.clintCodeFromBackk
        params["asmtID"]                     = self.AsmtIdfromSiteFromBackk
        params["CompanyCode"]                = self.CompanyCodefromSiteFromBackk
        params["ChecklistID"]               = self.checkListIDFromBackk
        print(params)
        WebServiceManager.shared.InsertScheduledWorkChecklistImageSmartFM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.navigationController?.popViewController(animated: true)
//                        self.VisitCheckListNameData = data.compactMap({Visit_CheckListModal(withData: $0)})

                       
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
    
    func callGetScheduledWorkChecklistImageSmartFMService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetScheduledWorkChecklistImageSmartFMService()
            }
            return
        }
      
        ActivityView.show(self.view)
        params["connectionKey"]            = "SAMS"
        params["empID"]                     = AppSession.user?.EmpNumber
        params["empName"]                   = AppSession.user?.EmpName
        params["ChecklistHeaderAutoID"]          = self.AutoIdfromCheckList
        params["LocationAutoid"]              = AppSession.user?.LocationAutoID
        params["ClientCode"]               = self.clintCodeFromBackk
        params["ChecklistID"]               = self.checkListIDFromBackk
        params["asmtID"]                     = self.AsmtIdfromSiteFromBackk
        params["CompanyCode"]                = self.CompanyCodefromSiteFromBackk
              
        print(params)
        WebServiceManager.shared.GetScheduledWorkChecklistImageSmartFM(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.imageData = data.compactMap({Images_Modal(withData: $0)})
                        self.Base64String.removeAll()
                        for base64 in self.imageData{
                            self.Base64String = base64.ImageBase64String
                        }
                        if let imageData = Data(base64Encoded: self.Base64String) {
                            if let image = UIImage(data: imageData) {
                                let imageView = UIImageView(image: image)
                                self.ShowGetimageView.image = image
                            } else {
                                print("Failed to create UIImage from data")
                            }
                        } else {
                            print("Failed to decode Base64 string to data")
                        }
                       
                                } else {
                                    print("Data parsing error")
                                }
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
                    customAlert.massage = "image not available"
                    self.present(customAlert, animated: true, completion: nil)
                    ActivityView.hide(self.view)
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
    func callGetVisitChecklistImageSmartFMService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callGetVisitChecklistImageSmartFMService()
            }
            return
        }
      
        ActivityView.show(self.view)
        params["connectionKey"]            = "SAMS"
        params["empID"]                     = AppSession.user?.EmpNumber
        params["empName"]                   = AppSession.user?.EmpName
        params["Designation"]              = AppSession.user?.Designation
        params["LocationAutoid"]              = AppSession.user?.LocationAutoID
        params["ClientCode"]               = self.clintCodeFromBackk
        params["VisitType"]                = self.siteTypeNameFromBackk
        params["VisitAutoID"]               = self.AutoIdfromCheckList
        params["asmtID"]                     = self.AsmtIdfromSiteFromBackk
        params["CompanyCode"]                = self.CompanyCodefromSiteFromBackk

        WebServiceManager.shared.GetVisitChecklistImageSmartFM(params) { (status, json) in
            self.apistatus = status
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.imageData = data.compactMap({Images_Modal(withData: $0)})
                        self.Base64String.removeAll()
                        for base64 in self.imageData{
                            self.Base64String = base64.ImageBase64String
                        }
                        if let imageData = Data(base64Encoded: self.Base64String) {
                            if let image = UIImage(data: imageData) {
                                let imageView = UIImageView(image: image)
                                self.ShowGetimageView.image = image
                            } else {
                                print("Failed to create UIImage from data")
                            }
                        } else {
                            print("Failed to decode Base64 string to data")
                        }
                       
                                } else {
                                    print("Data parsing error")
                                }
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
                    customAlert.massage = "image not available"
                    self.present(customAlert, animated: true, completion: nil)
                    ActivityView.hide(self.view)
                    ActivityView.hide(self.view)
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
extension ImagesVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        
            let resizedImage = self.resizeImage(images, newSize: CGSize(width: 360, height: 250))
            let compressedImage = resizedImage.compress(toKB: 400)
            self.checkListmarkaddImages.append(compressedImage ??  UIImage())
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
                
                self.checkListmarklastImg = images ?? UIImage()
                self.checkListImagebased64VPhoto = images?.toBase64() ?? ""
                if self.isScheduleworkdone == true{
                    self.callInsertScheduledWorkChecklistImageSmartFMService()
                }else{
                    self.callInsertVisitChecklistImageSmartFMService()
                }
               
                self.checkListmarkimgColBase64.append("data:image/png;base64," + self.checkListImagebased64VPhoto)
                let image = self.checkListmarklastImg
//                self.configure(with: image)
             

            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
