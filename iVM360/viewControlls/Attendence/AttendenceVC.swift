//
//  AttendenceVC.swift
//  iVM360
//
//  Created by 1707 on 22/07/24.
//

import UIKit
import CoreLocation
class AttendenceVC: UIViewController, CustomAlertDelegate, CLLocationManagerDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    @IBOutlet weak var attendanceUserName: UILabel!
    @IBOutlet weak var attendanceProfilePost: UILabel!
    @IBOutlet weak var attendanceBackGroundView: UIView!
    @IBOutlet weak var shiftNameLblBackground: UIView!
    @IBOutlet weak var photoimageView: UIImageView!
    @IBOutlet weak var attendanceProfileimageView: UIImageView!
    @IBOutlet weak var retakeImageBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var shiftNmaelbl: UILabel!
    @IBOutlet weak var locationNameLbl: UILabel!
    @IBOutlet weak var latitudeLbl: UILabel!
    @IBOutlet weak var logitudeLbl: UILabel!
   
    
    
    var checkInTimeFromBack = String()
    var checkOutTimeFromBack = String()
    var AsmtIDfromBack = String()
    var ClintCodefromBack = String()
    var ShiftCodefromBack = String()
    var postIDFromBack = String()
    var locManager = CLLocationManager()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var lat = String()
    var long = String()
    var clientSiteNameFromBack = String()
    var currentDateTiem = String()
    var ShiftListData = [ShiftsfList]()
    var checkinenable = String()
    var checkoutenable = String()
    var checkInTime = String()
    var checkOutTime = String()
    
    var checkListmarklastImg = UIImage()
    var checkListmarkbased64VPhoto  = ""
    var checkListmarkimgColBase64 = [String]()
    var checkListmarkaddImages = [UIImage]()
    var currentAddress = String()
    
    var QRCode = String()
    var qrData: QRData?
    var savedclientCodeAttendance = String()
    var savedEmpNumberAttendance = String()
    var savedAsmtidAttendance = String()
    var isscanerVCFromBack = Bool()
    var ischeckin = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
self.savedclientCodeAttendance =  defaults.value(forKey: "ClientCode") as? String ?? ""
print(self.savedclientCodeAttendance)
     let defaults1 = UserDefaults.standard
self.savedAsmtidAttendance = defaults1.value(forKey: "AsmtId") as? String ?? ""
print(self.savedAsmtidAttendance)
let defaults2 = UserDefaults.standard
self.savedEmpNumberAttendance = defaults2.value(forKey: "EmpNumber") as? String ?? ""
print(self.savedEmpNumberAttendance)
        print(self.qrData?.codeString! ?? 0)
        self.QRCode = self.qrData?.codeString! ?? ""
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.attendanceBackGroundView.layer.cornerRadius = 10
        self.shiftNameLblBackground.layer.cornerRadius = 5
        self.photoimageView.layer.cornerRadius = 10
        self.retakeImageBtn.layer.cornerRadius = 5
        self.submitBtn.layer.cornerRadius = 5
        self.attendanceUserName.text = AppSession.user?.EmpName
        self.attendanceProfilePost.text = AppSession.user?.Designation
        self.shiftNmaelbl.text = self.ShiftCodefromBack
        self.currentDateTiem = Date.getCurrentDate()
       
        // -----------------------------------------------------
        // Mark:- for latitude and longitude in viewdidload
        //------------------------------------------------------
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager = CLLocationManager()
        }
       
        if let location         = LocationManager.shared.currentLocation {
            self.long = location.coordinate.longitude.string
            self.lat = location.coordinate.latitude.string
        }else{
            print("ok")
        }
        
        self.latitudeLbl.text = "Latitude: " + self.lat
        self.logitudeLbl.text = "Longitude: " + self.long
        
        getAddressFromLatLon(latitude:  Double(self.lat)!, longitude: Double(self.long)!)

    }
    
    // CLLocationManagerDelegate method - location updates
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         guard let location = locations.last else {
             print("Failed to get the location")
             return
         }

       

         // Reverse geocoding to get the address
         getAddressFromLatLon(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

         // Stop updating location to save battery
         locationManager.stopUpdatingLocation()
     }

     // Get address from latitude and longitude using reverse geocoding
     func getAddressFromLatLon(latitude: Double, longitude: Double) {
         let geocoder = CLGeocoder()
         let location = CLLocation(latitude: latitude, longitude: longitude)

         geocoder.reverseGeocodeLocation(location) { placemarks, error in
             if let error = error {
                 print("Error retrieving address: \(error.localizedDescription)")
                 return
             }

             guard let placemark = placemarks?.first else {
                 print("No placemark found")
                 return
             }
             let subThoroughfare = placemark.subThoroughfare ?? ""  // Building number
                    let thoroughfare = placemark.thoroughfare ?? ""        // Street name
                    let subLocality = placemark.subLocality ?? ""          // Block/Neighborhood
                    let locality = placemark.locality ?? ""                // City
                    let subAdministrativeArea = placemark.subAdministrativeArea ?? ""  // District or additional locality
                    let administrativeArea = placemark.administrativeArea ?? ""  // State/Province
                    let postalCode = placemark.postalCode ?? ""            // Postal Code
                    let country = placemark.country ?? ""                  // Country

                    // Construct the complete address
                    let addressComponents = [subThoroughfare, thoroughfare, subLocality, locality, subAdministrativeArea, administrativeArea, postalCode, country]
                    let address = addressComponents.filter { !$0.isEmpty }.joined(separator: ", ")
             print(address)
//             let address = "\(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
            
             // Ensure UI updates happen on the main thread
             DispatchQueue.main.async {
                 self.locationNameLbl.numberOfLines = 0
                 self.locationNameLbl.lineBreakMode = .byWordWrapping
                 self.locationNameLbl.text = address
                 self.currentAddress = address

//                 print("Address: \(address)")
             }

//             print("Address: \(address)")
         }
     }

     // Handle location authorization status change
     func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
         switch status {
         case .authorizedWhenInUse, .authorizedAlways:
             locationManager.startUpdatingLocation()
         case .denied, .restricted:
             print("Location access denied")
         default:
             break
         }
     }

     // Handle location manager failure
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("Failed to get location: \(error.localizedDescription)")
     }

    
    
    func configure(with image: UIImage) {
        photoimageView.image = image
            }
    @IBAction func retakeClickBtn(_ sender: Any) {
        showAlert()
        
    }
    @IBAction func submittClickBtn(_ sender: Any) {
        self.ischeckin = true
        self.callInsertEmployeeAttendanceService()
        
    }
    
    @IBAction func cameraOpenBtn(_ sender: Any) {
        showAlert()
        
    }
    func resizeImage(_ image: UIImage, newSize: CGSize) -> UIImage {
            UIGraphicsBeginImageContext(newSize)
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage ?? image
        }
}
extension AttendenceVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        
            let resizedImage = self.resizeImage(images, newSize: CGSize(width: 300, height: 300))
            let compressedImage = resizedImage.compress(toKB: 200)
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
                self.checkListmarkbased64VPhoto = images?.toBase64() ?? ""
                self.checkListmarkimgColBase64.append("data:image/png;base64," + self.checkListmarkbased64VPhoto)
                let image = self.checkListmarklastImg
                self.configure(with: image)

            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
}
extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd,hh:mm a"
        return dateFormatter.string(from: Date())
    }
}
extension UIImage {
    func compress(toKB maxSizeKB: Int) -> UIImage? {
        guard let imageData = self.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        
        var compression: CGFloat = 1.0
        let maxBytes = maxSizeKB * 1024
        
        var resizedImageData = imageData
        while resizedImageData.count > maxBytes && compression > 0 {
            compression -= 0.1
            if let newImageData = self.jpegData(compressionQuality: compression) {
                resizedImageData = newImageData
            }
        }
        
        return UIImage(data: resizedImageData)
    }
}
