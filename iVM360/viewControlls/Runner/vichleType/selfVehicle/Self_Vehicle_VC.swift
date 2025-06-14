//
//  Self_Vehicle_VC.swift
//  iVM360
//
//  Created by 1707 on 23/01/25.
//

import UIKit
import DropDown
class Self_Vehicle_VC: UIViewController, UITextViewDelegate, CustomAlertDelegate {
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
    

    @IBOutlet weak var self_Vechile_Type_Btn: UIButton!
    @IBOutlet weak var assigned_By_Fld: UITextField!
    @IBOutlet weak var comment_TextView: UITextView!
    @IBOutlet weak var start_Trip_Btn: UIButton!
    
    
    var vehicle_Type_ListData = [vehicle_Type_Modal]()
    let dropDown_vehicle = DropDown()
    var vehicle_NameList = [String]()
    var vehicleTypeId = Int()
    var vehicleType = Int()
    var taskListremark = "Enter your remarks"
    var assigned_By = String()
    let placeholder = "Enter your remarks here"
    var istrip_Created = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.istrip_Created = false
        self.comment_TextView.text = placeholder
        self.self_Vechile_Type_Btn.setCorner(radius: 10)
        self.assigned_By_Fld.setCorner(radius: 10)
        self.comment_TextView.setCorner(radius: 10)
        self.start_Trip_Btn.setCorner(radius: 10)
        self.callgetVehicleTypesService()
        dropDown_vehicle.cornerRadius = 5
        dropDown_vehicle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown_vehicle.selectionBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dropDown_vehicle.anchorView = self.self_Vechile_Type_Btn
        dropDown_vehicle.bottomOffset = CGPoint(x: -1, y: self.self_Vechile_Type_Btn.bounds.height)
        dropDown_vehicle.selectionAction = { [unowned self] (index: Int, item: String) in
            self.self_Vechile_Type_Btn.setTitle(item, for: .normal)
            self.self_Vechile_Type_Btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
                        self.vehicleTypeId = self.vehicle_Type_ListData[index].vehicleTypeId
                        self.vehicleType = self.vehicle_Type_ListData[index].vehicleType

        }
        self.comment_TextView.delegate = self
    }


    
    func textViewDidBeginEditing(_ textView: UITextView) {
      
            self.comment_TextView.text = ""
       
    }
    func textViewDidEndEditing(_ textView: UITextView){
        
           }
    @IBAction func ClickBack_Button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func click_Vehicle_TypeBtn(_ sender: Any){
        dropDown_vehicle.show()
    }

    @IBAction func click_start_TripBtn(_ sender: Any){
        if (self.taskListremark == "" && self.taskListremark == self.placeholder) && self.assigned_By == ""{
            let customAlert : AlertVC = AlertVC.instance()
                customAlert.delegate = self
                customAlert.hideBut = true
                customAlert.logoutBut = false
                customAlert.onofflineBut = false
                customAlert.modalPresentationStyle = .overCurrentContext
                customAlert.providesPresentationContextTransitionStyle = true
                customAlert.modalTransitionStyle = .crossDissolve
                customAlert.titlestring = "Alert!"
                    customAlert.massage = "inter remark"
                self.present(customAlert, animated: true, completion: nil)
        }else{
            self.callcreateRunnerTripService()
        }
        
    }

}
extension Self_Vehicle_VC{
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
        params["tripTypeId"]             = "23001"
        WebServiceManager.shared.getVehicleTypes(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                 ServiceConst.Status.internalServerError:
                if !json.isEmpty {
                    print(json)
                    if let status = json["status"] as? Bool, status {
                        if let data = json["data"] as? [[String: Any]] {
                            print(data)
                            
                            self.vehicle_Type_ListData = data.compactMap { vehicle_Type_Modal(withData: $0) }
                            self.vehicle_NameList.removeAll()
                            for vehicle in self.vehicle_Type_ListData {
                                self.vehicle_NameList.append(vehicle.vehicleName)
                            }
                            self.dropDown_vehicle.dataSource = self.vehicle_NameList
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
        guard let assignedBy = assigned_By_Fld.text,assignedBy.trimmingCharacters(in: .whitespaces).isEmpty == false else {
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
        self.assigned_By = assignedBy
        
        if self.assigned_By_Fld.text == self.placeholder{
            self.taskListremark = ""
        }else{
            self.taskListremark = self.assigned_By_Fld.text ?? ""
        }
        
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callcreateRunnerTripService()
            }
            return
        }
        ActivityView.show(self.view)
        params["token"]             = AppSession.user?.UserSessionID
        params["tripTypeId"]        = self.vehicleType
        params["image"]             = ""
        params["vehicleTypeId"]     = self.vehicleTypeId
        params["assignedBy"]        = assignedBy
        params["startKilometer"]    = ""
        params["startPoint"]        = ""
        params["destination"]       = ""
        params["remark"]            = self.taskListremark
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
//                if !json.isEmpty {
//                    print(json)
//                    if let status = json["status"] as? Bool, status {
//                        if let data = json["data"] as? [[String: Any]] {
//                            print(data)
//                            
//                            self.vehicle_Type_ListData = data.compactMap { vehicle_Type_Modal(withData: $0) }
//                            self.vehicle_NameList.removeAll()
//                            for vehicle in self.vehicle_Type_ListData {
//                                self.vehicle_NameList.append(vehicle.vehicleName)
//                            }
//                            self.dropDown_vehicle.dataSource = self.vehicle_NameList
//                        } else {
//                            print("Data not found or incorrect format.")
//                        }
//                    } else {
//                        if let message = json["msg"] as? String {
//                            AlertView.show(message: message)
//                        } else {
//                            print("Error: Missing or invalid 'status' in JSON.")
//                        }
//                    }
//                } else {
//                    print("JSON is empty.")
//                }


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
