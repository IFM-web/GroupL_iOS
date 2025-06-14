//
//  DriverDashBoardServices.swift
//  DexgoHousekeeping
//
//  Created by 1707 on 10/04/24.
//

//import UIKit
extension DriverDashBoardVC {
    func callgetRunnerTripsService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callgetRunnerTripsService()
            }
            return
        }
        ActivityView.show(self.view)
        params["token"]             = AppSession.user?.UserSessionID
        WebServiceManager.shared.getRunnerTrips(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                 ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    print(json)
//                    if json["status"] as? Bool == true {
                        if let data = json["data"] as? [[String:Any]]{
                          print(data)
                            self.Trip_ListData = data.compactMap({Trip_List(withData: $0)})
                            print(self.Trip_ListData)
                            self.drivernewwdashBoardTableview.reloadData()
                            
                        }
//                    }else{
////                        AlertView.show(message: json["msg"] as? String)
//                    }
                }else{
                    
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
                   self.callgetRunnerTripsService()
                }
            default:
                print("hjghj")
                ActivityView.hide(self.view)
            }
        }
    }
    
    func callstopRunnerTripService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callstopRunnerTripService()
            }
            return
        }
        ActivityView.show(self.view)
//        params["token"]             = AppSession.user?.UserSessionID
        
        params["endKilometer"]             = ""
        params["image"]             = ""
        params["totalDistance"]             = ""
        params["tripId"]             = self.trip_Id
        params["remark"]             = ""
        if let location         = LocationManager.shared.currentLocation {
            params["latitude"]  = location.coordinate.latitude.string
            params["longitude"] = location.coordinate.longitude.string
        }
        
        WebServiceManager.shared.stopRunnerTrip(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                 ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    print(json)
//                    if json["status"] as? Bool == true {
                        if let data = json["data"] as? [[String:Any]]{
                          print(data)
                            self.callgetRunnerTripsService()
//                            self.Trip_ListData = data.compactMap({Trip_List(withData: $0)})
//                            print(self.Trip_ListData)
//                            self.drivernewwdashBoardTableview.reloadData()
                            
                        }
//                    }else{
////                        AlertView.show(message: json["msg"] as? String)
//                    }
                }else{
                    
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
                   self.callstopRunnerTripService()
                }
            default:
                print("hjghj")
                ActivityView.hide(self.view)
            }
        }
    }
    
//    func callupdateDriverRequestStatusService(){
//        var params: [String: Any] = [:]
//        guard Connectivity.isInternetConnected else {
//            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
//                guard let `self` = self else {return}
//                self.callupdateDriverRequestStatusService()
//            }
//            return
//        }
//        ActivityView.show(self.view)
//        params["tripId"]              = self.DriverTripID
//        if let location         = LocationManager.shared.currentLocation {
//            params["latitude"]  = location.coordinate.latitude.string
//            params["longitude"] = location.coordinate.longitude.string
//        }
//        
//        if self.DriverTripStatus == "29001"{
//            params["tripStatus"]             = "29002"
//        }else if self.DriverTripStatus == "29002"{
//            params["tripStatus"]             = "29003"
//        }
//        print(params)
//        WebServiceManager.shared.updateDriverRequestStatus(params) { (status, json) in
//            switch status {
//            case ServiceConst.Status.success,
//                 ServiceConst.Status.internalServerError:
//                if json.isEmpty == false {
//                    print(json)
//                    if json["status"] as? Bool == true {
//                        if let data = json["data"] as? [[String:Any]]{
//                          print(data)
//                            self.tripStatusData = data.compactMap({TripStatusModel(withData: $0)})
//                            print(self.tripStatusData)
//                            for statusData in self.tripStatusData {
//                                self.tripstatuss = statusData.tripStatus
//                            }
//
//                            self.callgetDriverRequestService()
////
//                        }
//                    }else{
////                        AlertView.show(message: json["msg"] as? String)
//                    }
//                }
//               ActivityView.hide(self.view)
//            case ServiceConst.Status.bedRequest:
//               AlertView.show(message: json["message"] as? String)
//                ActivityView.hide(self.view)
//           case ServiceConst.Status.unauthorized:
//               ActivityView.hide(self.view)
////                let customAlert : AlertVC = AlertVC.instance()
////                    customAlert.delegate = self
////                    customAlert.hideBut = true
////                    customAlert.logoutBut = false
////                    customAlert.onofflineBut = false
////                    customAlert.modalPresentationStyle = .overCurrentContext
////                    customAlert.providesPresentationContextTransitionStyle = true
////                    customAlert.modalTransitionStyle = .crossDissolve
////                    customAlert.titlestring = "Alert!"
////                    customAlert.massage = json["message"] as? String
////                    self.present(customAlert, animated: true, completion: nil)
//          case ServiceConst.Status.fail:
//                ActivityView.hide(self.view)
//               AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
//                    guard let `self` = self else {return}
//                   self.callupdateDriverRequestStatusService()
//                }
//            default:
//                print("hjghj")
//                ActivityView.hide(self.view)
//            }
//        }
//    }
//    
//    func callgetHospitalComplaintListService(){
//        var params: [String: Any] = [:]
//        guard Connectivity.isInternetConnected else {
//            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
//                guard let `self` = self else {return}
//                self.callgetHospitalComplaintListService()
//            }
//            return
//        }
////        let deviceToken = UserDefaults.standard.string(forKey: "Token")
//        ActivityView.show(self.view)
//        params["hospitalId"]             = AppSession.user?.hospitalId
//        WebServiceManager.shared.getHospitalComplaintList(params) { (status, json) in
//            switch status {
//            case ServiceConst.Status.success,
//                 ServiceConst.Status.internalServerError:
//                if json.isEmpty == false {
//                    print(json)
//                    if json["status"] as? Bool == true {
//                        if let data = json["data"] as? [[String:Any]]{
//                          print(data)
//                            self.Complaint_listDetail_Data = data.compactMap({Complaintlist_Modal(withData: $0)})
//                            print(self.Complaint_listDetail_Data)
//                            
//                            self.listNotaviableLbl.isHidden = true
//                            self.drivernewwdashBoardTableview.isHidden = false
//                            self.drivernewwdashBoardTableview.reloadData()
////                            if self.DriverListData.count == 0{
////                                self.listNotaviableLbl.isHidden = false
////                                self.drivernewwdashBoardTableview.isHidden = true
////                                self.listNotaviableLbl.text = "You currently do not have any Trips"
////                            }else{
////                                self.listNotaviableLbl.isHidden = true
////                                self.drivernewwdashBoardTableview.isHidden = false
////                                self.drivernewwdashBoardTableview.reloadData()
////                            }
////                            
//                        }
//                    }else{
////                        AlertView.show(message: json["msg"] as? String)
//                    }
//                }else{
//                    
//                }
//               ActivityView.hide(self.view)
//            case ServiceConst.Status.bedRequest:
//               AlertView.show(message: json["message"] as? String)
//                ActivityView.hide(self.view)
//           case ServiceConst.Status.unauthorized:
//               ActivityView.hide(self.view)
//                let customAlert : AlertVC = AlertVC.instance()
//                    customAlert.delegate = self
//                    customAlert.hideBut = true
//                    customAlert.logoutBut = false
//                    customAlert.onofflineBut = false
//                    customAlert.modalPresentationStyle = .overCurrentContext
//                    customAlert.providesPresentationContextTransitionStyle = true
//                    customAlert.modalTransitionStyle = .crossDissolve
//                    customAlert.titlestring = "Alert!"
//                    customAlert.massage = json["message"] as? String
//                    self.present(customAlert, animated: true, completion: nil)
//          case ServiceConst.Status.fail:
//                ActivityView.hide(self.view)
//               AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
//                    guard let `self` = self else {return}
//                   self.callgetHospitalComplaintListService()
//                }
//            default:
//                print("hjghj")
//                ActivityView.hide(self.view)
//            }
//        }
//    }
//    
}
