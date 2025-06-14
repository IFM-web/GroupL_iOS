//
//  ScanViewController.swift
//  SMCApp
//
//  Created by 1707 on 26/12/23.
//

import UIKit

class ScanViewController: UIViewController, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
//   let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanViewController") as? ScanViewController
//        vc?.locationName = self.locationName
//        vc?.AuditID = Int(self.AuditID) 
//        vc?.siteType = Int(self.siteType) 
//        vc?.locationID = Int(self.locationID) 
//        vc?.TypeIDD = self.TypeIDD
//        vc?.QrCode_fromBack = self.QrCode_fromBack
//        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    //===========================================================
    //MARK: - IBOutlet
    //===========================================================
    @IBOutlet weak var scanDiscriptionLbl: UILabel!
    @IBOutlet weak var innerscanImageView: UIImageView!
    @IBOutlet weak var titleNameLbl: UILabel!
    @IBOutlet weak var scanImageView: UIImageView!
    @IBOutlet weak var scanImageBackgroundView: UIView!
    @IBOutlet weak var AlerttitleLbl: UILabel!
    @IBOutlet weak var scanDetailLbl: UILabel!
    @IBOutlet weak var procedBtn: UIButton!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var AlertOverallBackgroundView: UIView!
    @IBOutlet weak var butonBackgroundView: UIView!
    var locationName = String()
    var AuditID = Int()
    var siteType = Int()
    var locationID = Int()
    var TypeIDD = Int()
    var QrCode_fromBack = String()
    
    var ScanShiftCodefromBack     = String()
    var ScanClintCodefromBack     = String()
    var ScanAsmtIDfromBack        = String()
    var ScanpostIDFromBack        = String()
    var ScancheckInTimeFromBack   = String()
    var ScancheckOutTimeFromBack   = String()
    var isscanerVC = false
   
    
    
    
    @IBOutlet weak var scannerView: QRScannerView! {
        didSet {
            scannerView.delegate = self
        }
    }
    @IBOutlet weak var scanBtn: UIButton! {
        didSet {
            scanBtn.setTitle("SCAN", for: .normal)
        }
    }
    
    var qrData: QRData? = nil {
        didSet {
            if qrData != nil {
//                let mathString: String = (self.qrData?.codeString)!
                self.performSegue(withIdentifier: "AttendenceVC", sender: self)
//                let numbers = mathString.components(separatedBy: ":")
//                let QR_CODEWithother = numbers[4]
//                let qr_code = QR_CODEWithother.components(separatedBy: " ")
//                if self.QrCode_fromBack == mathString{
//                    self.performSegue(withIdentifier: "ScanAlertViewController", sender: self)
//                }else{
//                    let customAlert : AlertVC = AlertVC.instance()
//                        customAlert.delegate = self
//                        customAlert.hideBut = true
//                        customAlert.logoutBut = false
//                        customAlert.onofflineBut = false
//                        customAlert.modalPresentationStyle = .overCurrentContext
//                        customAlert.providesPresentationContextTransitionStyle = true
//                        customAlert.modalTransitionStyle = .crossDissolve
//                        customAlert.titlestring = "Alert!"
//                        customAlert.massage = "Wrong QR Code"
//                        self.present(customAlert, animated: true, completion: nil)
//                        ActivityView.hide(self.view)
//                        return
//                }
                
            }
        }
    }
    //===========================================================
    //MARK: - create instance
    //===========================================================
    var scan = false
    
    var ClintCodeFromBack = String()
    var SmtIdFromBack = String()
    var clientSiteNameFromback = String()
    var ShiftCodeFromBack = String()
    
    
    
    //===========================================================
    //MARK: - VC Life Cycle
    //===========================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.scannerView.isHidden = true
        print(self.qrData?.codeString ?? 0)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool){
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }
    
    @IBAction func scanClickBTN(_ sender: Any) {
       
        if self.scan == false{
            self.isscanerVC = true
            scannerView.isRunning ? scannerView.startScanning() : scannerView.stopScanning()
            self.scannerView.isHidden = false
            self.scanImageBackgroundView.isHidden = true
            self.scanBtn.isHidden = true
        
        }else if self.scan == true{
            self.scannerView.isHidden = true
            self.scanImageBackgroundView.isHidden = false
            self.scanBtn.isHidden = false
        }
    }

}
extension ScanViewController: QRScannerViewDelegate {
    func qrScanningDidStop() {
        let buttonTitle = scannerView.isRunning ? "" : ""
        scanBtn.setTitle(buttonTitle, for: .normal)
    }

    func qrScanningDidFail() {
        presentAlert(withTitle: "Error", message: "Scanning Failed. Please try again")
    }

    func qrScanningSucceededWithCode(_ str: String?) {
        self.qrData = QRData(codeString: str)
    }
}

extension ScanViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AttendenceVC", let viewController = segue.destination as? AttendenceVC {
            viewController.qrData = self.qrData
            viewController.ShiftCodefromBack      =  self.ScanShiftCodefromBack
            viewController.ClintCodefromBack      = self.ScanClintCodefromBack
            viewController.AsmtIDfromBack        = self.ScanAsmtIDfromBack
//            viewController.postIDFromBack        = self.ScanpostIDFromBack
            viewController.checkInTimeFromBack    = self.ScancheckInTimeFromBack
            viewController.checkOutTimeFromBack   = self.ScancheckOutTimeFromBack
            viewController.isscanerVCFromBack =      self.isscanerVC 
            
            
            
            
        }
    }
}
