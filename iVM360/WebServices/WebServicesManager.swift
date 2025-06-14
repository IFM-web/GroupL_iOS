//
//  WebServicesManager.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//

import UIKit
import Alamofire

class Connectivity {
    class var isInternetConnected:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
class WebServiceManager: NSObject {

    static let shared         = WebServiceManager()
    typealias CompletionBlock = (Int,[String:Any]) -> Void
    typealias CompletionBlocks = (Int,[[String:Any]]) -> Void
    typealias CompletionBlockGenration = (Int,[String:Any]) -> Void
    private var sessionManager:Session!

    //===========================================================
    //MARK: - Initialization Methods
    //===========================================================
    private override init() {
        super.init()
        self.configureManager()
    }
    static var headers: HTTPHeaders?{
        if let t = AppSession.authToken {
            return [ServiceConst.authorization:t]
        }
        return nil
    }
    static var headersDex: HTTPHeaders?{
        if let t = AppSession.authTokenDex {
            return [ServiceConst.tokenDex:t]
        }
        return nil
    }
    //===========================================================
    //MARK: - Service Methods
    //===========================================================
    //TODO:Configuration
//    func appConfiguration(withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getPassengerAppConfiguration"+"/\(AppInfo.appID)"
//        callGetRequestWithCompleteUrl(url: completeUrl, withCompletionBlock: block)
//    }

    //TODO:WebLogin
//    func LoginByEmpID(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
//        let completeUrl = ServiceConst.baseUrl+"LoginByEmpID"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
    
    func LoginByEmpIDFCM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"LoginByEmpIDFCM"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    func GetEmpMappedSites(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetEmpMappedSites"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetEmployeeAttendanceDailyWithShift(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetEmployeeAttendanceDailyWithShift"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetSitesPost(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetSitesPost"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func InsertEmployeeAttendance(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertEmployeeAttendance"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetGeoMappedSitesSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetGeoMappedSitesSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetVisitTypeSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetVisitTypeSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetVisitChecklistSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetVisitChecklistSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func GetVisitChecklistSmartFMIOS(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetVisitChecklistSmartFMIOS"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    
    func InsertVisitChecklistSmartFMJson(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertVisitChecklistSmartFMJson"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func InsertVisitChecklistImageSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertVisitChecklistImageSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetVisitChecklistImageSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetVisitChecklistImageSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func InsertVisitChecklistClientDetailsSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertVisitChecklistClientDetailsSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func InsertVisitChecklistMOMSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertVisitChecklistMOMSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func ViewTodayScheduledWork(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"ViewTodayScheduledWork"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetScheduledWorkChecklistSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetScheduledWorkChecklistSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func InsertScheduledWorkChecklistSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertScheduledWorkChecklistSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func InsertScheduledWorkChecklistSmartFMJson(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertScheduledWorkChecklistSmartFMJson"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }

    func InsertScheduledWorkChecklistImageSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertScheduledWorkChecklistImageSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetScheduledWorkChecklistImageSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetScheduledWorkChecklistImageSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func InsertScheduledWorkEmpDetailsSmartFM(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertScheduledWorkEmpDetailsSmartFM"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func GetTicketType(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetTicketType"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetTicketCategory(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetTicketCategory"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GenerateTicket(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GenerateTicket"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func InsertTicketImage(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertTicketImage"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetAssignedTicketList(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetAssignedTicketList"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetTicketDetails(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetTicketDetails"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func CloseTicket(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"CloseTicket"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func AttendanceRegularization(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"AttendanceRegularization"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func AttendanceRegularizationStatus(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"AttendanceRegularizationStatus"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func ApplyForLeave(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"ApplyForLeave"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func ApplyMultipleLeaves(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"ApplyMultipleLeaves"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func LeaveApplicationStatus(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"LeaveApplicationStatus"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func LeaveCancellationRequest(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"LeaveCancellationRequest"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func LeaveRecord(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"LeaveRecord"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
//    update version
    func InsertRegisterEntry(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertRegisterEntry"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetEmpProfile(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetEmpProfile"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func InsertEmployeeImage(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertEmployeeImage"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func GetEmpUniformDetails(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetEmpUniformDetails"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func UpdateEmpUniformStatus(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"UpdateEmpUniformStatus"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    
//    add new two api in attandance
    func GetStandardShifts(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetStandardShifts"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func GetEmployeeAttendanceDailyInternal(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetEmployeeAttendanceDailyInternal"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    
    
    
    
    
    
    
    func InsertAppointmentApproval(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"InsertAppointmentApproval"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func GetAppointmentApproval(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"GetAppointmentApproval"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func AttendanceMuster(_ params:[String:Any], withCompletion block:@escaping CompletionBlocks){
        let completeUrl = ServiceConst.baseUrl+"AttendanceMuster"
    
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
//    diffrent api data
    func Generation(_ params:[String:Any], withCompletion block:@escaping CompletionBlockGenration){
        let completeUrl = ServiceConst.baseUrl_Genration+"Generation"
    
        callPostRequestWithCompleteUrlGenration(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func View(_ params:[String:Any], withCompletion block:@escaping CompletionBlockGenration){
        let completeUrl = ServiceConst.baseUrl_letterView+"View"
    
        callPostRequestWithCompleteUrlGenration(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func EmpWise(_ params:[String:Any], withCompletion block:@escaping CompletionBlockGenration){
        let completeUrl = ServiceConst.baseUrl_SalarySlip+"EmpWise"
    
        callPostRequestWithCompleteUrlGenration(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    
    
    

    
    
    
    
    
    
    
    func addRunnerInSession(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.base2Url+"addRunnerInSession"
        callPostRequestWithCompleteUrlDexApi(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    
    
    func getRunnerTrips(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.base2Url+"getRunnerTrips"
        callPostRequestWithCompleteUrlDexApi(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func getVehicleTypes(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.base2Url+"getVehicleTypes"
        callPostRequestWithCompleteUrlDexApi(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func stopRunnerTrip(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.base2Url+"stopRunnerTrip"
        callPostRequestWithCompleteUrlDexApi(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func logoutRunner(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.base2Url+"logoutRunner"
        callPostRequestWithCompleteUrlDexApi(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func getRunnerTripDetails(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.base2Url+"getRunnerTripDetails"
        callPostRequestWithCompleteUrlDexApi(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func createRunnerTrip(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.base2Url+"createRunnerTrip"
        callPostRequestWithCompleteUrlDexApi(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func addRunnerTripExpense(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.base2Url+"addRunnerTripExpense"
        callPostRequestWithCompleteUrlDexApi(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    func updateRunnerTripLocation(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.base2Url+"updateRunnerTripLocation"
        callPostRequestWithCompleteUrlDexApi(url: completeUrl, andData: params, withCompletionBlock: block)
    }
 

    
//    func getBuildingList(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.base2Url+"getBuildingList"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getFloorList(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.base2Url+"getFloorList"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getAddresses(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getAddresses"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getWorkAreaDetail(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getWorkAreaDetail"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//   
//    func getEmployeesForSupervisor(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getEmployeesForSupervisor"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getSupervisorDetails(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getSupervisorDetails"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func employeeCheckinCheckout(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"employeeCheckinCheckout"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getAppConfiguration(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getAppConfiguration"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    
//    func getTicketsForSupervisor(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getTicketsForSupervisor"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//        print(params)
//    }
//    func updateTicketStatus(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"updateTicketStatus"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getHospitalServiceType(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getHospitalServiceType"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func reassignTicket(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"reassignTicket"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    
//    func supervisorCheckInCheckOut(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"supervisorCheckInCheckOut"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    
//    func employeeAllotment(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"employeeAllotment"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getAddressList(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.shiftUrl+"getAddressList"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getCheckList(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getCheckList"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getAddressChecklistByQrCode(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getAddressChecklistByQrCode"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func updateResponseOfCheckListQuestion(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"updateResponseOfCheckListQuestion"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getSubmitImagesAndRemarkByQuestionId(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getSubmitImagesAndRemarkByQuestionId"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    
//    func submitCheckList(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"submitCheckList"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getHouseKeepingPorterRequestListForAddress(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getHouseKeepingPorterRequestListForAddress"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func updateTripStatus(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"updateTripStatus"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func verifyHousekeepingTrip(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"verifyHousekeepingTrip"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getHouseKeepingPorterRequestList(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getHouseKeepingPorterRequestList"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func houseKeepingCheckInCheckOut(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"houseKeepingCheckInCheckOut"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getHouseKeepingUserDetails(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getHouseKeepingUserDetails"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func submitImagesAndRemarkByQuestionId(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"submitImagesAndRemarkByQuestionId"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func getDriverRequest(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getDriverRequest"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    func updateDriverRequestStatus(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"updateDriverRequestStatus"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    
//    
//    
//    
//    
//    //TODO:GetUserAppSetting
//
//    func getUserAppSetting(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getUserAppConfiguration"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    
//    
//    
//    //getOutletOpenCloseStatus
//    func getOutletOpenCloseStatus(_ params:[String:Any],withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"getOutletOpenCloseStatus"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
//    
//    //ResendOtp
//    func resendOtp(_ params:[String:Any],withCompletion block:@escaping CompletionBlock){
//        let completeUrl = ServiceConst.baseUrl+"willUserLoginWithOTP"
//        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
//    }
    
    

    //===========================================================
    //MARK: - Google Servies
    //===========================================================
    func getDireactionFromGoogle(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
   

    }
    //===========================================================
    //MARK: - Alamofire Methods
    //===========================================================
    /**
     *  Configure Alamofire Manger
     */
    private func configureManager() {
        let configuration = URLSessionConfiguration.default
        sessionManager = Alamofire.Session(configuration: configuration)
    }
    /**
     *  This function is use to get data from server using HTTP GET method.
     *  @param completeUrl BaseUrl with ServicePath.
     *  @param dictData    Params in json(NSDictionary).
     *  @param block       CompletionBlock.
     */
    private func callGoogleGetRequestWithCompleteUrl(url:String, andData data:[String:Any]? = nil,withCompletionBlock block:@escaping CompletionBlock) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        sessionManager.request(url, method: .get, parameters: data, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = response.response?.statusCode ?? 0
                    let auth = ["":""]
                    print("RequestUrl:\(url)\nRequestParams:\("")\nAuthorization:\(auth)\nResponseCode:\(statusCode)\nResponseData:\(json))")
                    block(statusCode,json as! [String : Any])
                case .failure(let error):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = response.response?.statusCode ?? 0
                    let auth = WebServiceManager.headers ?? ["":""]
                    print("RequestUrl:\(url)\nRequestParams:\("")\nAuthorization:\(auth)\nResponseCode:\(statusCode)\nError:\(error)")
                    block(statusCode,["error":error])
                }
        }
        //        .responseString { (string) in
        //                print("ResponseString:----> \(string)")
        //        }
    }
    /**
     *  This function is use to get data from server using HTTP GET method.
     *  @param completeUrl BaseUrl with ServicePath.
     *  @param dictData    Params in json(NSDictionary).
     *  @param block       CompletionBlock.
     */
    private func callGetRequestWithCompleteUrl(url:String, andData data:[String:Any]? = nil,withCompletionBlock block:@escaping CompletionBlock) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        AF.request(url, method: .get, parameters: data, encoding: JSONEncoding.default, headers: WebServiceManager.headers)
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = response.response?.statusCode ?? 0
                    let auth = WebServiceManager.headers ?? ["":""]
                    print("RequestUrl:\(url)\nRequestParams:\("")\nAuthorization:\(auth)\nResponseCode:\(statusCode)\nResponseData:\(json))")
                    block(statusCode,json as! [String : Any])
                case .failure(let error):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = response.response?.statusCode ?? 0
                    let auth = WebServiceManager.headers ?? ["":""]
                    print("RequestUrl:\(url)\nRequestParams:\("")\nAuthorization:\(auth)\nResponseCode:\(statusCode)\nError:\(error)")
                    block(statusCode,["error":error])
                }
        }
//                .responseString { (string) in
//                        print("ResponseString:----> \(string)")
//                }
    }
    /**
     *  This function is use to get data from server using HTTP POST method.
     *
     *  @param completeUrl BaseUrl with ServicePath.
     *  @param dictData    Params in json(NSDictionary).
     *  @param block       CompletionBlock.
     */
    
    private func callPostRequestWithCompleteUrl(url: String, andData data: [String: Any], withCompletionBlock block: @escaping CompletionBlocks) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Define headers specific to your .NET API (if needed)
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
           
        ]
        
        // Assuming you're using Alamofire
        AF.request(url, method: .post, parameters: data, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let json):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = response.response?.statusCode ?? 0
                    print("RequestUrl: \(url)\nRequestParams: \(data)\nResponseCode: \(statusCode)\nResponseData: \(json)")
                    block(statusCode, json as? [[String: Any]] ?? []) // Ensure json is cast safely
                case .failure(let error):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = response.response?.statusCode ?? 0
                    print("RequestUrl: \(url)\nRequestParams: \(data)\nResponseCode: \(statusCode)\nError: \(error.localizedDescription)")
                    block(statusCode, error as? [[String: Any]] ?? [])
                   // block(statusCode, ["error": error.localizedDescription])
                }
        }
    }
    
    private func callPostRequestWithCompleteUrlGenration(url: String, andData data: [String: Any], withCompletionBlock block: @escaping CompletionBlockGenration) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        // Define headers specific to your .NET API (if needed)
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        // Assuming you're using Alamofire
        AF.request(url, method: .post, parameters: data, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let json):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = response.response?.statusCode ?? 0
                    print("RequestUrl: \(url)\nRequestParams: \(data)\nResponseCode: \(statusCode)\nResponseData: \(json)")
//                    block(statusCode, json as? [String: Any] ?? [:]) // Ensure json is cast safely
                    block(statusCode, (json as? [String: Any] ?? [:]))
                case .failure(let error):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = response.response?.statusCode ?? 0
                    print("RequestUrl: \(url)\nRequestParams: \(data)\nResponseCode: \(statusCode)\nError: \(error.localizedDescription)")
                    block(statusCode, error as? [String: Any] ?? [:])
                   // block(statusCode, ["error": error.localizedDescription])
                }
        }
    }
    
    
    
    private func callPostRequestWithCompleteUrlDexApi(url:String, andData data:[String:Any],withCompletionBlock block:@escaping CompletionBlock) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        AF.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: WebServiceManager.headersDex)
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = response.response?.statusCode ?? 0
                    let auth = WebServiceManager.headersDex ?? ["":""]
                    print("RequestUrl:\(url)\nRequestParams:\(data)\nAuthorization:\(auth)\nResponseCode:\(statusCode)\nResponseData:\(json))")
                    block(statusCode,json as! [String : Any])
                case .failure(let error):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = response.response?.statusCode ?? 0
                    let auth = WebServiceManager.headersDex ?? ["":""]
                    print("RequestUrl:\(url)\nRequestParams:\(data)\nAuthorization:\(auth)\nResponseCode:\(statusCode)\nError:\(error.localizedDescription)")
                    block(statusCode,["error":error])
                }
        }
        //        .responseString { (string) in
        //            print("ResponseString:----> \(string)")
        //        }
    }
    
    
//    private func callPostRequestWithCompleteUrl(url: String, andData data: [String: Any], withCompletionBlock block: @escaping CompletionBlock) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        sessionManager.request(url, method: .post, parameters: data, encoding: JSONEncoding.default)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let json):
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    let statusCode = response.response?.statusCode ?? 0
//                    print("RequestUrl:\(url)\nRequestParams:\(data)\nResponseCode:\(statusCode)\nResponseData:\(json))")
//                    block(statusCode, json as! [String: Any])
//                case .failure(let error):
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    let statusCode = response.response?.statusCode ?? 0
//                    print("RequestUrl:\(url)\nRequestParams:\(data)\nResponseCode:\(statusCode)\nError:\(error.localizedDescription)")
//                    block(statusCode, ["error": error])
//                }
//        }
//    }
//    private func callPostRequestWithCompleteUrl(url:String, andData data:[String:Any],withCompletionBlock block:@escaping CompletionBlock) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        sessionManager.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: WebServiceManager.headers)
//            .responseJSON { (response) in
//                switch response.result {
//                case .success(let json):
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    let statusCode = response.response?.statusCode ?? 0
//                    let auth = WebServiceManager.headers ?? ["":""]
//                    print("RequestUrl:\(url)\nRequestParams:\(data)\nAuthorization:\(auth)\nResponseCode:\(statusCode)\nResponseData:\(json))")
//                    block(statusCode,json as! [String : Any])
//                case .failure(let error):
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    let statusCode = response.response?.statusCode ?? 0
//                    let auth = WebServiceManager.headers ?? ["":""]
//                    print("RequestUrl:\(url)\nRequestParams:\(data)\nAuthorization:\(auth)\nResponseCode:\(statusCode)\nError:\(error.localizedDescription)")
//                    block(statusCode,["error":error])
//                }
//        }
//        //        .responseString { (string) in
//        //            print("ResponseString:----> \(string)")
//        //        }
//    }
    /**
     *  Cancel All Alamofire Operation.
     */
    func cancelAllOperations() {
        sessionManager.session.getAllTasks { (tasks) in
            let allTask = tasks.dropLast()
            allTask.forEach({$0.cancel()})
        }
    }
    private func calljasonRequestWithCompleteUrl(url:String, andData data:[String:Any],headers : [String : String]?,withCompletionBlock block:@escaping CompletionBlock){
           
           let url = URL(string: url)!
           do {
               let jsonData = try JSONSerialization.data(withJSONObject: data, options:[])
               print(jsonData)
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
               request.httpBody = jsonData
            request.allHTTPHeaderFields = headers
               AF.request(request).responseJSON {
                   (responseObject) -> Void in
                   print(responseObject)
                switch responseObject.result{
                case .success(let json):
                    let statusCode = responseObject.response?.statusCode ?? 0
                 block(statusCode,json as! [String : Any])
                case .failure(let error):
                    let statusCode = responseObject.response?.statusCode ?? 0
                    block(statusCode,["error":error])
                }

               }
           }
           catch {
               print("Failed to serialise and send JSON")
           }
       }
}

