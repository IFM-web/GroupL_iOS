//
//  Create_Ticket_ImageUploadVC.swift
//  iVM360
//
//  Created by 1707 on 06/08/24.
//
import UIKit

class Create_Ticket_ImageUploadVC: UIViewController, CustomAlertDelegate, UITableViewDelegate,UITableViewDataSource {
  
    
    func okTapBtn(islogout: Int, text: String) {
        self.goBack()
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    

    
    @IBOutlet weak var ticketTitleView: UIView!
    @IBOutlet weak var imagesTableView: UITableView!
    @IBOutlet weak var imageUploadBtn: UIButton!
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
    var GenrateTicketJson = [[String:Any]]()
    var genratTicketNumberFromBack = String()
    var imgsumitedMsg = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
       
        let nib = UINib(nibName: "Create_View_MultipleImageTableCell", bundle: nil)
        self.imagesTableView.register(nib, forCellReuseIdentifier: "Create_View_MultipleImageTableCell")
        
        
    }
    
    
    
//    func configure(with image: UIImage) {
//        ShowGetimageView.image = image
//            }
    @objc func goBack() {
        if let navigationController = self.navigationController {
                    let viewControllers = navigationController.viewControllers
                    let targetIndex = viewControllers.count - 4
                    if targetIndex >= 0 {
                        let targetViewController = viewControllers[targetIndex] as? IFMVC
                        if let targetViewController = targetViewController {
                            print("ok")
                        }
                        navigationController.popToViewController(targetViewController!, animated: true)
                    }
                }
    }
    
    
    @IBAction func imagebackkClickBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitClickBtn(_ sender: Any){
        self.GenrateTicketJson.removeAll()
        let Ans = ["TicketID":self.genratTicketNumberFromBack,
                   "TicketImageBase64":self.checkListImagebased64VPhoto] as [String : Any]
        self.GenrateTicketJson.append(Ans)
        self.callInsertTicketImageService()
    }
    
    @IBAction func clickImageUPloadBtn(_ sender: Any){
        showAlert()
    }
  
    
    func resizeImage(_ image: UIImage, newSize: CGSize) -> UIImage {
            UIGraphicsBeginImageContext(newSize)
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage ?? image
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.checkListmarkimgColBase64.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Create_View_MultipleImageTableCell", for: indexPath) as! Create_View_MultipleImageTableCell
        cell.selectionStyle = .none
        self.imagesTableView.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        cell.ticketShowGetimageView.image = self.checkListmarklastImg
        return cell
    }
    
    
    
}


extension Create_Ticket_ImageUploadVC{
    @available(iOS 13.0, *)
    func callInsertTicketImageService(){
        var params: [String: Any] = [:]
       
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callInsertTicketImageService()
            }
            return
        }
      
        ActivityView.show(self.view)
        params["connectionKey"]              = "SAMS"
        params["Json"]                     = self.GenrateTicketJson.toJSONString

        WebServiceManager.shared.InsertTicketImage(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    if let data = json as? [[String: Any]], let mainData = data.first {
                        self.imgsumitedMsg = mainData["Message"] as? String ?? ""
                        let customAlert = self.storyboard?.instantiateViewController(identifier: "AlertVC") as! AlertVC
                            customAlert.delegate = self
                            customAlert.hideBut = true
                            customAlert.logoutBut = false
                            customAlert.onofflineBut = false
                            customAlert.modalPresentationStyle = .overCurrentContext
                            customAlert.providesPresentationContextTransitionStyle = true
                            customAlert.modalTransitionStyle = .crossDissolve
                            customAlert.titlestring = "Alert!"
                            customAlert.massage = self.imgsumitedMsg
                            self.present(customAlert, animated: true, completion: nil)
                            ActivityView.hide(self.view)


                       
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
extension Create_Ticket_ImageUploadVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        
            let resizedImage = self.resizeImage(images, newSize: CGSize(width: 340, height: 250))
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
               
                self.checkListmarkimgColBase64.append(self.checkListImagebased64VPhoto)
                let image = self.checkListmarklastImg
//                self.configure(with: image)
                self.imagesTableView.reloadData()
             

            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
