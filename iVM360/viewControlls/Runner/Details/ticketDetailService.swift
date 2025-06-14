//
//  ticketDetailService.swift
//  DexgoHousekeeping
//
//  Created by Apple on 07/07/23.
//

import UIKit
extension TicketDetailVC {
    func callgetRunnerTripDetailsService(){
        var params: [String: Any] = [:]
        guard Connectivity.isInternetConnected else {
            AlertView.show(message: AlertConst.Msg.internectDisconnectError, cancelButtonText: ButtonCaption.retry) { [weak self](button) in
                guard let `self` = self else {return}
                self.callgetRunnerTripDetailsService()
            }
            return
        }
        ActivityView.show(self.view)
        params["tripId"]             = self.tripID_FromBack
        WebServiceManager.shared.getRunnerTripDetails(params) { (status, json) in
            switch status {
            case ServiceConst.Status.success,
                 ServiceConst.Status.internalServerError:
                if json.isEmpty == false {
                    print(json)
//                    if json["status"] as? Bool == true {
                        if let data = json["data"] as? [[String:Any]]{
                          print(data)
                            self.detaisl_Data = data.compactMap({DetailsModal(withData: $0)})
                          for DetaislData in self.detaisl_Data {
                              self.tripid_DateTimeLbl.text = "TripId: \(DetaislData.tripId), " + DetaislData.startDate
                              self.startPoint_AddressLbl.text = DetaislData.startPoint
                              self.endPoint_AddressLbl.text = DetaislData.endPoint
                              self.assignedByLbl.text = DetaislData.assignedBy
                              self.vehicle_Reading.text = DetaislData.distanceTravelled
                              self.start_TimeLbl.text = DetaislData.totalFare
                              self.ent_TimeLbl.text = DetaislData.endDate
                              self.trip_Name.text = DetaislData.vehicleName
                              self.detailtitle.text = DetaislData.startTripComment
                            }
                            
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
                   self.callgetRunnerTripDetailsService()
                }
            default:
                print("hjghj")
                ActivityView.hide(self.view)
            }
        }
    }
}
