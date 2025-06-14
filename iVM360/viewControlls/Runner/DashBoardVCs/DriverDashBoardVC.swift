//
//  DriverDashBoardVC.swift
//  DexgoHousekeeping
//
//  Created by 1707 on 09/04/24.
//

import UIKit
import CoreLocation

class DriverDashBoardVC: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        print("ok")
        self.callstopRunnerTripService()
//        if self.DriverTripStatus == "29003"{
//            print("ok")
//        }else{
//            let loginVC : LoginViewController = LoginViewController.instance()
//            self.navigationController?.pushViewController(loginVC, animated: true)
//        }
        
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    @IBOutlet weak var driver_NameLbl: UILabel!
    
    @IBOutlet weak var drivervewDashboardHight: NSLayoutConstraint!
    @IBOutlet weak var driverTotalTimeLbl: UILabel!
    @IBOutlet weak var driverTotalTimeperiodLbl: UILabel!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var driverTripTimeLbl: UILabel!
    @IBOutlet weak var drivernewwdashBoardTableview: UITableView!
    @IBOutlet weak var driverRecentTripTitleLBL: UILabel!
    @IBOutlet weak var driverTripTitleView: UIView!
    @IBOutlet weak var driverOnlineOfflineBtn: UIButton!
    @IBOutlet weak var driverdashBoardTableview:  UITableView!
    @IBOutlet weak var driverdashBoardtableHight: NSLayoutConstraint!
    @IBOutlet weak var driverNoDataLbl: UILabel!
    @IBOutlet weak var listNotaviableLbl: UILabel!
    
    
    @IBOutlet weak var totalTimeTitleLbl: UILabel!
    @IBOutlet weak var pendingTitleLbl: UILabel!
    
    
    var refreshControl = UIRefreshControl()
    var Trip_ListData = [Trip_List]()
//    var driverlistStartEndData = DriverListModel()
//    var tripStatusData = [TripStatusModel]()
//    var Complaint_listDetail_Data = [Complaintlist_Modal]()
    var DriverTripID = String()
    var tripstatuss = String()
    var trip_Id = Int()
    var DriverTripStatus = String()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    @IBAction func backBtn(_ sender: Any) {
//        let loginVC : LoginViewController = LoginViewController.instance()
//        UserDefaults.standard.removeObject(forKey: "isLogin")
//        UserDefaults.standard.removeObject(forKey: "isDriver")
//        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func submit_Btn(_ sender: Any) {
//        if AppSession.user?.typeId == GocrewUserType.GrievanceTypeGocrew{
            let vehicleType : vichle_Type_VC = vichle_Type_VC.instance()
            self.navigationController?.pushViewController(vehicleType, animated: true)
//        }else{
//            print("Driver submit action ")
//        }
    }
    
    
    
    @IBAction func logOut_DriverBtn(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.driverOnlineOfflineBtn.layer.cornerRadius = 25
//        self.driverTripTitleView.layer.cornerRadius = 15
        self.listNotaviableLbl.isHidden = true
        self.driverTripTitleView.layer.cornerRadius = 10
        self.driver_NameLbl.text = AppSession.user?.EmpName
        self.callgetRunnerTripsService()
        
//        if AppSession.user?.typeId == GocrewUserType.GrievanceTypeGocrew{
//            self.driverNameLbl.text = AppSession.user?.firstName
//            self.driverRecentTripTitleLBL.text = "Recent Grievances"
//            self.driverOnlineOfflineBtn.setTitle("Submit Grievance", for: .normal)
//            self.pendingTitleLbl.text = "Pending Grievances"
//            self.totalTimeTitleLbl.text = "Total Grievances"
////            self.callgetHospitalComplaintListService()
//            
//        }else{
//            self.driverNameLbl.text = AppSession.user?.firstName
//            self.driverRecentTripTitleLBL.text = "Recent Trip"
//            self.driverOnlineOfflineBtn.setTitle("Go Online", for: .normal)
//            self.pendingTitleLbl.text = "Total time"
//            self.totalTimeTitleLbl.text = "Total Trips"
////            self.callgetDriverRequestService()
//        }
      
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action:  #selector(refresh), for: .valueChanged)
      self.drivernewwdashBoardTableview.addSubview(refreshControl)
        
        
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
   
    }
   
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.callgetRunnerTripsService()
//    }
    @objc func refresh(_ sender: Any) {
            self.callgetRunnerTripsService()
            refreshControl.endRefreshing()
        
    }
    public func setNotification(address_id: [String], check_status: String){
//        if AppSession.user?.typeId == GocrewUserType.GrievanceTypeGocrew{
//           print("grievance list api call")
//        }else{
////            self.callgetDriverRequestService()
//        }
    }
    
    
//    override func viewWillLayoutSubviews() {
//      super.updateViewConstraints()
//      self.drivervewDashboardHight?.constant = self.drivernewwdashBoardTableview.contentSize.height
//
//  }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent // Change this to .default for black text color
     }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        setNeedsStatusBarAppearanceUpdate()
        self.callgetRunnerTripsService()
    }

    @objc func startEndDetailBtn(sender: UIButton){
        let List_data = self.Trip_ListData[sender.tag]
        self.trip_Id = List_data.tripId
        if List_data.tripStatus == 2005{
            let customAlert : AlertVC = AlertVC.instance()
                customAlert.delegate = self
                customAlert.hideBut = false
                customAlert.logoutBut = false
                customAlert.onofflineBut = true
                customAlert.modalPresentationStyle = .overCurrentContext
                customAlert.providesPresentationContextTransitionStyle = true
                customAlert.modalTransitionStyle = .crossDissolve
                customAlert.titlestring = "Alert!"
                customAlert.massage = "Are you sure, you want to end your trip"
                self.present(customAlert, animated: true, completion: nil)

        }else{
            let tripDetails : TicketDetailVC = TicketDetailVC.instance()
            tripDetails.tripID_FromBack = self.trip_Id
            self.navigationController?.pushViewController(tripDetails, animated: true)
        }
               
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Trip_ListData.count
//        if AppSession.user?.typeId == GocrewUserType.GrievanceTypeGocrew{
//            return self.Complaint_listDetail_Data.count
//        }else{
//            return self.DriverListData.count
//        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverDashboardTableCell", for: indexPath) as! DriverDashboardTableCell
        self.drivernewwdashBoardTableview.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            cell.selectionStyle = .none
        cell.driverStartendBtn.layer.cornerRadius = 5
        cell.listSerialNumberView.layer.cornerRadius = 20
        cell.listSerialNumberView.isHidden = true
        cell.listBackGroundView.layer.cornerRadius = 10
        cell.timeDateIdLbl.text = self.Trip_ListData[indexPath.row].createdDate
        cell.addressLbl.text = self.Trip_ListData[indexPath.row].startPoint
        cell.listDetailLbl.text = "abc"
        cell.jobStatusLbl.isHidden = true
        cell.doneimageView.isHidden = true
//        cell.notDoneImageView.isHidden = true
        cell.rejectImageView.isHidden = true
        cell.extraImageView.isHidden = true
        cell.addExpansesBtn.layer.cornerRadius = 5
        cell.startLocationLbl.text = self.Trip_ListData[indexPath.row].startTripComment
        if self.Trip_ListData[indexPath.row].tripStatus == 2005 && self.Trip_ListData[indexPath.row].tripTypeId == 23001 {
            cell.driverStartendBtn.isHidden = false
            cell.addExpansesBtn.isHidden = true
            cell.doneimageView.isHidden = true
//            cell.notDoneImageView.isHidden = true
            cell.rejectImageView.isHidden = true
            cell.extraImageView.isHidden = true
            cell.driverStartendBtn.tag = indexPath.row
            cell.driverStartendBtn.addTarget(self, action: #selector(startEndDetailBtn), for: .touchUpInside)
            cell.driverStartendBtn.setTitle("End Trip", for: .normal)
            cell.driverStartendBtn.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        }else if self.Trip_ListData[indexPath.row].tripStatus == 2006{
            cell.addExpansesBtn.isHidden = true
            cell.driverStartendBtn.isHidden = false
            cell.doneimageView.isHidden = false
//            cell.notDoneImageView.isHidden = true
            cell.rejectImageView.isHidden = true
            cell.extraImageView.isHidden = true
            cell.driverStartendBtn.tag = indexPath.row
            cell.driverStartendBtn.addTarget(self, action: #selector(startEndDetailBtn), for: .touchUpInside)
            cell.driverStartendBtn.setTitle("Trip Details", for: .normal)
            cell.driverStartendBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }else if self.Trip_ListData[indexPath.row].tripStatus == 2005 && self.Trip_ListData[indexPath.row].tripTypeId == 23002{
            cell.addExpansesBtn.isHidden = false
            cell.driverStartendBtn.isHidden = false
            cell.doneimageView.isHidden = true
//            cell.notDoneImageView.isHidden = true
            cell.rejectImageView.isHidden = true
            cell.extraImageView.isHidden = true
            cell.driverStartendBtn.tag = indexPath.row
            cell.driverStartendBtn.addTarget(self, action: #selector(startEndDetailBtn), for: .touchUpInside)
            cell.addExpansesBtn.setTitle("Add expanses", for: .normal)
            cell.addExpansesBtn.backgroundColor = #colorLiteral(red: 0, green: 0.1504378021, blue: 0.270124495, alpha: 1)
            cell.driverStartendBtn.setTitle("End Trip", for: .normal)
            cell.driverStartendBtn.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        }
       
        
//        if AppSession.user?.typeId == GocrewUserType.GrievanceTypeGocrew{
//            cell.driverStartendBtn.setTitle("Details", for: .normal)
//            cell.driverStartendBtn.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2117647059, blue: 0, alpha: 1)
//            cell.listSerialNumberView.isHidden = true
//            cell.doneimageView.isHidden = true
//            cell.rejectImageView.isHidden = true
//            cell.extraImageView.isHidden = true
//            cell.jobStatusLbl.isHidden = false
//            cell.driverStartendBtn.tag = indexPath.row
//            cell.driverStartendBtn.addTarget(self, action: #selector(startEndDetailBtn), for: .touchUpInside)
//            cell.timeDateIdLbl.text = "\(self.Complaint_listDetail_Data[indexPath.row].submittedFeedbackId)" + " " + "|" + " " + self.Complaint_listDetail_Data[indexPath.row].complainDate
//            cell.addressLbl.text = self.Complaint_listDetail_Data[indexPath.row].addressName
//            cell.listDetailLbl.text = self.Complaint_listDetail_Data[indexPath.row].complainRemark
//            cell.jobStatusLbl.text = self.Complaint_listDetail_Data[indexPath.row].jobStatusText
//            cell.startLocationLbl.text = self.Complaint_listDetail_Data[indexPath.row].serviceTypeText
//         
//
//        }else{
//            cell.listSerialNumberView.isHidden = false
//            cell.jobStatusLbl.isHidden = true
//            cell.timeDateIdLbl.text = self.DriverListData[indexPath.row].allotUserId + " " + "|" + " " + self.DriverListData[indexPath.row].startDate
//            cell.addressLbl.text = self.DriverListData[indexPath.row].destination
//            cell.startLocationLbl.text = "Start:" + " " + self.DriverListData[indexPath.row].pickUpLocation
//            cell.listDetailLbl.text = self.DriverListData[indexPath.row].remark
           
//
//            if self.DriverListData[indexPath.row].tripStatus == "29002" {
//                cell.driverStartendBtn.setTitle("End", for: .normal)
//                cell.driverStartendBtn.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2117647059, blue: 0, alpha: 1)
//                cell.driverStartendBtn.tintColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
//                cell.extraImageView.isHidden = true
//                cell.doneimageView.isHidden = true
//                cell.rejectImageView.isHidden = true
//                cell.listSerialNumberView.isHidden = false
//            } else if self.DriverListData[indexPath.row].tripStatus == "29003" {
//                cell.driverStartendBtn.setTitle("Details", for: .normal)
//                cell.driverStartendBtn.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
//                cell.driverStartendBtn.tintColor = #colorLiteral(red: 0.3058823529, green: 0.3490196078, blue: 0.3960784314, alpha: 1)
//                cell.extraImageView.isHidden = true
//                cell.doneimageView.isHidden = false
//                cell.rejectImageView.isHidden = true
//                cell.listSerialNumberView.isHidden = true
//            }else if self.DriverListData[indexPath.row].tripStatus == "29001" {
//                cell.driverStartendBtn.setTitle("Start", for: .normal)
//                cell.driverStartendBtn.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2117647059, blue: 0, alpha: 1)
//                cell.driverStartendBtn.tintColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
//                cell.extraImageView.isHidden = true
//                cell.doneimageView.isHidden = true
//                cell.rejectImageView.isHidden = true
//                cell.listSerialNumberView.isHidden = false
//            }
//            
//        }
     
        
        return cell
    }

}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

