//
//  Public_Vehicle_VC.swift
//  iVM360
//
//  Created by 1707 on 23/01/25.
//

import UIKit
import DropDown

class Public_Vehicle_VC: UIViewController, CustomAlertDelegate {
    func okTapBtn(islogout: Int, text: String) {
        if self.istrip_Created == true{
            if let targetVC = self.navigationController?.viewControllers.first(where: { $0 is DriverDashBoardVC }) {
                DispatchQueue.main.async {
                    self.navigationController?.popToViewController(targetVC, animated: true)
                }
            }
        }else{
            print("ok")
        }
    }
    
    func canceltapBtn() {
        print("cancel")
    }
    
    @IBOutlet weak var public_Vechile_Type_Btn: UIButton!
    @IBOutlet weak var public_assigned_By_Fld: UITextField!
    @IBOutlet weak var public_vechile_start_By_Fld: UITextField!
    @IBOutlet weak var public_vechile_Destination_By_Fld: UITextField!
    @IBOutlet weak var public_fare_By_Fld: UITextField!
    @IBOutlet weak var public_comment_TextView: UITextView!
    @IBOutlet weak var public_start_Trip_Btn: UIButton!
    
    var public_vehicle_Type_ListData = [vehicle_Type_Modal]()
    let public_dropDown_vehicle = DropDown()
    
    var public_vehicle_NameList = [String]()
    var public_vehicleTypeId = Int()
    var public_vehicleType = Int()
    var public_taskListremark = "Enter your remarks"
    var public_assigned_By = String()
//    let public_placeholder = "Enter your remarks here"
    var public_start_By = String()
//    let public_Destination = "Enter your remarks here"
    var public_Fare_By = String()
    var public_Destination_By = String()
    var istrip_Created = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.istrip_Created = false
        self.callgetVehicleTypesService()
        public_dropDown_vehicle.cornerRadius = 5
        public_dropDown_vehicle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        public_dropDown_vehicle.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        public_dropDown_vehicle.anchorView = self.public_Vechile_Type_Btn
        public_dropDown_vehicle.bottomOffset = CGPoint(x: -1, y: self.public_Vechile_Type_Btn.bounds.height)
        public_dropDown_vehicle.selectionAction = { [unowned self] (index: Int, item: String) in
            self.public_Vechile_Type_Btn.setTitle(item, for: .normal)
            self.public_Vechile_Type_Btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
                        self.public_vehicleTypeId = self.public_vehicle_Type_ListData[index].vehicleTypeId
                        self.public_vehicleType = self.public_vehicle_Type_ListData[index].vehicleType

        }
        
        
        

    }
    
    
    @IBAction func Click_Back_Button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func Click_publicVehicle_Button(_ sender: Any){
        public_dropDown_vehicle.show()
    }
    @IBAction func Click_start_Button(_ sender: Any){
        self.callcreateRunnerTripService()
    }
}
extension Public_Vehicle_VC{
    func callgetVehicleTypesService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callgetVehicleTypesService()
            }
            return
        }
        ActivityView.show(self.view)
        params["token"]             = AppSession.user?.UserSessionID
        params["tripTypeId"]             = "23002"
        WebServiceManager.shared.getVehicleTypes(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                 ServiceConst.Status.internalServerError:
                if !json.isEmpty {
                    print(json)
                    if let status = json["status"] as? Bool, status {
                        if let data = json["data"] as? [[String: Any]] {
                            print(data)
                            
                            self.public_vehicle_Type_ListData = data.compactMap { vehicle_Type_Modal(withData: $0) }
                            self.public_vehicle_NameList.removeAll()
                            for vehicle in self.public_vehicle_Type_ListData {
                                self.public_vehicle_NameList.append(vehicle.vehicleName)
                            }
                            self.public_dropDown_vehicle.dataSource = self.public_vehicle_NameList
                        } else {
                            print("Data not found or incorrect format.")
                        }
                    } else {
                        if let message = json["msg"] as? String {
                            AlertView.show(message: message)
                        } else {
                            print("Error: Missing or invalid 'status' in JSON.")
                        }
                    }
                } else {
                    print("JSON is empty.")
                }


               ActivityView.hide(self.view)
            case ServiceConst.Status.bedRequest:
//               AlertView.show(message: json["message"] as? String)
                ActivityView.hide(self.view)
           case ServiceConst.Status.unauthorized:
               ActivityView.hide(self.view)
                let customAlert : AlertVC = AlertVC.instance()
                    customAlert.delegate = self
                    customAlert.hideBut = true
                    customAlert.logoutBut = false
                    customAlert.onofflineBut = false
                    customAlert.modalPresentationStyle = .overCurrentContext
                    customAlert.providesPresentationContextTransitionStyle = true
                    customAlert.modalTransitionStyle = .crossDissolve
                    customAlert.titlestring = "Alert!"
//                    customAlert.massage = json["message"] as? String
                    self.present(customAlert, animated: true, completion: nil)
          case ServiceConst.Status.fail:
                ActivityView.hide(self.view)
               AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                    guard let `self` = self else {return}
                   self.callgetVehicleTypesService()
                }
            default:
                print("hjghj")
                ActivityView.hide(self.view)
            }
        }
    }
    
    func callcreateRunnerTripService(){
        var params: [String: Any] = [:]
        guard let public_assignedBy = public_assigned_By_Fld.text,public_assignedBy.trimmingCharacters(in: .whitespaces).isEmpty == false else {
            let customAlert : AlertVC = AlertVC.instance()
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "enter assignedBy "
            self.present(customAlert, animated: true, completion: nil)
            ActivityView.hide(self.view)
            return
        }
        guard let public_startPoint = public_vechile_start_By_Fld.text,public_startPoint.trimmingCharacters(in: .whitespaces).isEmpty == false else {
            let customAlert : AlertVC = AlertVC.instance()
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "enter assignedBy "
            self.present(customAlert, animated: true, completion: nil)
            ActivityView.hide(self.view)
            return
        }
        guard let public_Destination = public_vechile_Destination_By_Fld.text,public_Destination.trimmingCharacters(in: .whitespaces).isEmpty == false else {
            let customAlert : AlertVC = AlertVC.instance()
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "enter assignedBy "
            self.present(customAlert, animated: true, completion: nil)
            ActivityView.hide(self.view)
            return
        }
        guard let public_fare = public_fare_By_Fld.text,public_fare.trimmingCharacters(in: .whitespaces).isEmpty == false else {
            let customAlert : AlertVC = AlertVC.instance()
            customAlert.delegate = self
            customAlert.hideBut = true
            customAlert.logoutBut = false
            customAlert.onofflineBut = false
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.modalTransitionStyle = .crossDissolve
            customAlert.titlestring = "Alert"
            customAlert.massage = "enter assignedBy "
            self.present(customAlert, animated: true, completion: nil)
            ActivityView.hide(self.view)
            return
        }
        
        self.public_assigned_By = public_assignedBy
        self.public_start_By = public_startPoint
        self.public_Destination_By = public_Destination
        self.public_Fare_By = public_fare
//        
//        if self.public_assigned_By_Fld.text == self.public_placeholder{
//            self.public_taskListremark = ""
//        }else{
//            self.public_taskListremark = self.public_assigned_By_Fld.text ?? ""
//        }
        
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callcreateRunnerTripService()
            }
            return
        }
        ActivityView.show(self.view)
//        params["token"]             = AppSession.user?.UserSessionID
        params["tripTypeId"]        = self.public_vehicleType
        params["image"]             = ""
        params["vehicleTypeId"]     = self.public_vehicleTypeId
        params["assignedBy"]        = public_assignedBy
        params["startKilometer"]    = ""
        params["startPoint"]        = public_startPoint
        params["destination"]       = public_Destination
        params["remark"]            = self.public_taskListremark
        if let location         = LocationManager.shared.currentLocation {
            params["latitude"]  = location.coordinate.latitude.string
            params["longitude"] = location.coordinate.longitude.string
        }
        
        WebServiceManager.shared.createRunnerTrip(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                 ServiceConst.Status.internalServerError:
                if !json.isEmpty {
                    print(json)
                    
                    if let status = json["status"] as? Int, status == 1 {
                        if let dataArray = json["data"] as? [[String: Any]] {
                            for dataDict in dataArray {
                                if let tripId = dataDict["tripId"] as? String, tripId.lowercased() != "<null>" {
                                    print("Trip ID: \(tripId)")
                                    if let targetVC = self.navigationController?.viewControllers.first(where: { $0 is DriverDashBoardVC }) {
                                        DispatchQueue.main.async {
                                            self.navigationController?.popToViewController(targetVC, animated: true)
                                        }
                                    }
                                    
                                } else {
                                    print("Trip ID is null or not found")
                                    self.istrip_Created = true
                                    DispatchQueue.main.async {
                                        let customAlert: AlertVC = AlertVC.instance()
                                        customAlert.delegate = self
                                        customAlert.hideBut = true
                                        customAlert.logoutBut = false
                                        customAlert.onofflineBut = false
                                        customAlert.modalPresentationStyle = .overCurrentContext
                                        customAlert.providesPresentationContextTransitionStyle = true
                                        customAlert.modalTransitionStyle = .crossDissolve
                                        customAlert.titlestring = "Alert!"
                                        customAlert.massage = "Trip already running"
                                        self.present(customAlert, animated: true, completion: nil)
                                    }
                                }
                            }
                        } else {
                            print("Data not found or incorrect format.")
                        }
                    }
                }


               ActivityView.hide(self.view)
            case ServiceConst.Status.bedRequest:
//               AlertView.show(message: json["message"] as? String)
                ActivityView.hide(self.view)
           case ServiceConst.Status.unauthorized:
               ActivityView.hide(self.view)
                let customAlert : AlertVC = AlertVC.instance()
                    customAlert.delegate = self
                    customAlert.hideBut = true
                    customAlert.logoutBut = false
                    customAlert.onofflineBut = false
                    customAlert.modalPresentationStyle = .overCurrentContext
                    customAlert.providesPresentationContextTransitionStyle = true
                    customAlert.modalTransitionStyle = .crossDissolve
                    customAlert.titlestring = "Alert!"
                    customAlert.massage = json["msg"] as? String
                    self.present(customAlert, animated: true, completion: nil)
          case ServiceConst.Status.fail:
                ActivityView.hide(self.view)
               AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                    guard let `self` = self else {return}
                   self.callcreateRunnerTripService()
                }
            default:
                print("hjghj")
                ActivityView.hide(self.view)
            }
        }
    }
}
