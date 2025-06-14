//
//  Close_TicketVC.swift
//  iVM360
//
//  Created by 1707 on 07/08/24.
//

import UIKit

class Close_TicketVC: UIViewController {
    @IBOutlet weak var contineuBtn: UIButton!
    @IBOutlet weak var imageUploadBtn: UIButton!
    @IBOutlet weak var imgBackGroundView: UIView!
    @IBOutlet weak var imagView: UIImageView!
    
    
    
    var checkListmarklastImg = UIImage()
    var checkListImagebased64VPhoto  = ""
    var checkListmarkimgColBase64 = [String]()
    var checkListmarkaddImages = [UIImage]()
    
    var TicketNumberFromBackk = String()
    var isTicketClose = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgBackGroundView.layer.cornerRadius = 10
        self.imagView.layer.cornerRadius = 10
        self.contineuBtn.layer.cornerRadius = 5
        self.imageUploadBtn.layer.cornerRadius = 5
    }
      
    @IBAction func closeContineuBtn(_ sender: Any){
        self.isTicketClose = true
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Ticket_GenrateVC") as? Ticket_GenrateVC
        vc?.TicketNumberFromBackkk = self.TicketNumberFromBackk
        vc?.isTicketCloseBack = self.isTicketClose
        vc?.imgBase64FromBack = self.checkListImagebased64VPhoto
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func configure(with image: UIImage) {
        self.imagView.image = image
            }

    @IBAction func UploadClichBtn(_ sender: Any){
        showAlert()
    }
    @IBAction func CloseBackClickBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func resizeImage(_ image: UIImage, newSize: CGSize) -> UIImage {
            UIGraphicsBeginImageContext(newSize)
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage ?? image
        }

}
extension Close_TicketVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
                self.checkListmarkimgColBase64.append("data:image/png;base64," + self.checkListImagebased64VPhoto)
                let image = self.checkListmarklastImg
                self.configure(with: image)

            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
