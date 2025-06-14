//
//  Constants.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//
import UIKit
//===========================================================
//MARK: - ServiceURLs
//===========================================================
struct ServiceConst {
    
//Batse rider app usertypeId
    static let UserTypeId        = "1001"
    static let typeId            = "1008"
    static let authorization           = ""
    static let tokenDex           = "token"
                                        
     static let mainUrl                 = "https://ifm360.in/GroupL/webservices/GroupLApp.asmx/"
    static let shiftUrl                 = "https://app.dexgo.co:3000/api/"
    static let Genration               = "https://groupllettermodule.maxus.co.in/api/AuthToken/"
    static let salarySlip                 = "https://groupllettermodule.maxus.co.in/api/GetSalarySlip/"
    static let letterView                 = "https://groupllettermodule.maxus.co.in/api/Letter/"
   
    #if Prod
   
    #elseif Dev
    static let mainUrl                 = "http://52.13.215.4"
    #endif
    static let base2Url                = ServiceConst.shiftUrl
    static let baseUrl                 = ServiceConst.mainUrl
    static let baseUrl_Genration        = ServiceConst.Genration
    static let baseUrl_SalarySlip       = ServiceConst.salarySlip
    static let baseUrl_letterView       = ServiceConst.letterView
    
    
    
    
    static let aboutUs                 = ServiceConst.mainUrl
    
    static let registration            = ServiceConst.mainUrl+"/web/driver/signup"
    static let termsCondition          = ServiceConst.baseUrl+"/terms"
    static let privacyPolicy           = ServiceConst.baseUrl+"/privacy-policy"
   // static let googleDirectionUrl      = "https://maps.googleapis.com/maps/api/directions/json?key=\(GoogleConst.webApiKey)"
    static let timeOut                 = 20.0

    static let snipeComplaintsUrl           =  "https://www.batse.cr/batsecr/ErrorSinpe?"
    static let snipeOtherBankUrl = "https://www.batse.cr/batsecr/sinpe"
    
    //batse rider
    static let faq = "https://www.batse.cr/place2pay_faq.php"
     static let ppurl = "https://www.placetopay.com/web/"
    
    struct Status {
        static let fail                = 0
        static let success             = 200
        static let bedRequest          = 400
        static let unauthorized        = 401
        static let forbidden           = 403
        static let conflict            = 409
        static let internalServerError  = 500
    }
}
struct AlertMsg{
    static let InternectDisconnectError = "Sorry, no internet connectivity detected. Please reconnect and try again.".localized
    static let serverError              = "Sorry, Some thing went wrong. Please try again.".localized
    static let logoutMessage            = "Do you want to log out?".localized
    static let deleteMessage            = "Do you want to delete?".localized
    static let alertTitle               = "ALERT".localized
    static let noestimate               =  "No estimated cost available for this service. Please choose another service.".localized
    static let noService                =  "There is no driver available at this moment, Please try again after some time.".localized
    static let desti                    = "Choose Destination".localized
    static let noDriver                 =   "Sorry no driver Availble to accept your request try again later".localized
    static let invalidCard              = "invalid card info".localized
    static let invalidcompliant              = "select complaint type".localized
    static let invalidAge              = "Please enter  valid age".localized
    
}
//===========================================================
//MARK: - Order Status Code
//===========================================================

//struct OrderStatus {
//
//   static let NEW_ORDER = 112000
//   static let ACCEPTED_BY_OUTLET = 112001
//   static let BEING_PREPARED = 112002
//   static let READY = 112003
//   static let AUTO_CANCLE = 112014
//   static let DISPATCHED = 112004
//   static let ON_THE_WAY = 112005
//   static let DELIVERED = 112006
//   static let COMPLETED = 112007
//   static let CANCELLED = 112008
//   static let RETURNED = 112009
//   static let ORDER_PICKED_UP = 112010
//   static let ORDER_REQUEST_ACCEPTED_RIDER = 112011
//   static let ARRIVED_AT_RESTAURANT = 112012
//   static let REACHED_AT_LOCATION = 112013
//   static let CANCELLED_BY_CUSTOMER = 112015
//
//}
//struct OrderPyamentCode {
//    static let WALLET_CODE = 6003
//    static let CARD_CODE = 6002
//}
//===========================================================
//MARK: - Alert Constants
//===========================================================
struct AlertConst {
    struct Header {
        static let alert                    = "Alert"
        static let success                  = "Alert.Header.Success"
        static let location                 = "Alert.Header.Location"
        static let call                     = "Alert.Header.Call"
        static let language                 = "Alert.Header.Language"
    }
    struct Msg {
        static let undefined                = "Alert.Msg.Undefined"
        static let internectDisconnectError   = "Request Time Out"
        static let timeOut                  = "Alert.Msg.TimeOut"
        static let logoutMessage            = "Alert.Msg.LogoutMessage"
        static let deleteMessage            = "Alert.Msg.DeleteMessage"
        static let noDataFound              = "Alert.Msg.NoDataFound"
        static let cancelTrip               = "Alert.Msg.CancelTrip"
        static let noCarAvailable           = "Alert.Msg.NoCarAvailable"
        static let selectPaymentOption      = "Alert.Msg.SelectPaymentOption"
    }
    struct RequiedMsg {
        static let body                     = "Requied.Body"
        static let subject                  = "Requied.Subject"
        static let username                 = "Requied.UserName"
        static let firstname                = "Requied.FirstName"
        static let lastname                 = "Requied.LastName"
        static let fullname                 = "Requied.FullName"
        static let block                    = "Enter.Block/Tower/Unit/Phase"
        static let email                    = "Requied.Email"
        static let contactNumber            = "Requied.MobileNumber"
        static let amount                   = "Enter.Amount"
        static let currentpassword          = "Requied.CurrentPassword"
        static let password                 = "Requied.Password"
        static let confirmPassword          = "Requied.ConfirmPassword"
        static let flat                     = "Enter.Flat Number"
        static let nickName                 = "Enter.NickName"
        static let state                    = "Requied.State"
        static let city                     = "Requied.City"
        static let society                  = "Requied.society"
        static let pack                     = "select.Pack"
        static let car                      = "Select.Car"
        static let location                = "Select.ParkingLocation"
        static let checkBox                 = "Requied.CheckBox"
        static let gender                   = "Select.Gender"
        static let fuel                   = "Select.FuelType"
        static let brand                   = "Select.brand"
        static let model                   = "Select.Model"
        //Card Const
        static let cardNumber               = "Requied.CardNumber"
        static let nameOnCard               = "Requied.NameOnCard"
        static let expiry                   = "Requied.ExpiryDate"
        static let cvv                      = "Requied.CVV"
        
    }
    struct ValidMsg {
        static let email                    = "Valid.Email"
        static let oldPassword              = "Valid.OldPassword"
        static let confirmPassword          = "Valid.ConfirmPassword"
        static let contactNumber            = "Valid.ContactNumber"
        static let location                 = "Valid.Location"
        static let address                  = "Valid.Address"
        static let verificationCode         = "Valid.VerificationCode"
        
        //Card Const
        static let cardNumber               = "Valid.CardNumber"
        static let expiry                   = "Valid.ExpiryDate"
        static let cvv                      = "Valid.CVV"
        
        static let passwordLength           = "Valid.PasswordLength"
    }
    struct LocationMsg {
        static let notDetermine             = "LocationService.NotDetermine"
        static let disable                  = "LocationService.Disable"
    }
}
struct SegueConst {
    struct Show {
        static let constroller = "ShowViewController"
    }
    struct Hide {
        static let controller  = "HideViewController"
    }
}
//===========================================================
//MARK: - Button Caption
//===========================================================
struct ButtonCaption {
    static let ok         = "ButtonCaption.Ok"
    static let cancel     = "ButtonCaption.Cancel"
    static let `continue` = "ButtonCaption.Continue"
    static let save       = "ButtonCaption.Ok"
    static let retry      = "Retry"
    static let logout     = "ButtonCaption.Logout"
    static let setting    = "ButtonCaption.Setting"
    static let call       = "ButtonCaption.Call"
}
//===========================================================
//MARK: - LocationManager Const
//===========================================================
struct LocationConst {
    static let minMetersBetweenLocations: Double = 10.0
    static let minMetersLocationAccuracy: Double = 10.0
    static let minMetersForEquivalent: Double    = 20.0
}

//status code
struct JobStatus {
    
    static let Job_new                    = 21001
    static let Job_Acknowledged           = 21002
    static let Job_IN_Progress            = 21003
    static let Job_Resolved               = 21004
    static let Job_Rejected               = 21005
    
}
struct addressStatus {
    static let Add_Building                    = 17001
    static let Add_Floor                       = 17002
    static let Address                       = 17003
    static let Add_Build_Floor                  = ([17001,17002].map{String($0)}).joined(separator: ",")
    
}




struct PorterStatus {
    
    static let PORTER_ONLINE              = 3002
    static let PORTER_ONDUTY              = 3003
    static let PORTER_OFFLINE             = 3006
    static let NEW                       = 26001
    static let ACCEPTED                   = 26002
    static let ARRIVED_NURSE_STATION        = 26003
    static let ARRIVED_PICKUP              = 26004
    static let STARTED                    = 26005
    static let END                        = 26006
    static let completed_overDue            = ([26006,26007].map{String($0)}).joined(separator: ",")
    static let CANCELLED                  = 2007
    static let SUSPICIOUS                 = 2015
    static let RUNNING                    = ([26001,26002,26003,26004,26005].map{String($0)}).joined(separator: ",")
    static let supervisor_list              = ([26006,26007,26009].map{String($0)}).joined(separator: ",")
    static let Verifyed_Task                 = 26009
    
    static let DESTINATION_START            = 14001
    static let DESTINATION_END              = 14002
    static let HOSPITAL_ADMIN_TYPE_CODE       = 1003
    static let PORTER_TYPE_CODE               = 1004
    static let HOSPITAL_STAFF_TYPE_CODE       = 1005
    static let Login                      = 3001
    static let TRIP_TYPE_DROP_OFF         = 3002
    static let TRIP_TYPE_OTHER            = 0
    static let EMP_CHECKIN_CODE           = 4001
    static let EMP_CHECKOUT_CODE          = 4002
    static let TRIP_CATEGORY_SHIFT        = 5001
    static let TRIP_CATEGORY_SPECIAL      = 5002
    static let TRIP_CATEGORY_ROUTINE      = 5003
    static let TRIP_CATEGORY_FIX_CAB      = 5004
    static let DIALOG_NONE                = 8001
    static let DIALOG_LAST                = 8002
    static let DIALOG_ALL                 = 8003
    static let broadCastReceiverPendingIntentRequestCode = 989
    static let SERVICE_TIMEOUT_MILLISECONDS = 90000
    static let UPLOAD_TO_SERVER_TIME_DELAY  = 10000
    static let INSERT_INTO_DB_TIME_DELAY    = 3000
    static let NOTIFICATION_TYPE_NEW        = 10001
    static let NOTIFICATION_TYPE_UPDATE     = 10002
    static let NOTIFICATION_TYPE_RESEND     = 10003

}
public extension UIDevice {

    /// pares the deveice name as the standard name
    var modelName: String {

        #if targetEnvironment(simulator)
            let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
        #else
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        #endif

        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPod9,1":                                 return "iPod touch (7th generation)"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone12,1":                              return "iPhone 11"
        case "iPhone12,3":                              return "iPhone 11 Pro"
        case "iPhone12,5":                              return "iPhone 11 Pro Max"
        case "iPhone12,8":                              return "iPhone SE (2nd generation)"
        case "iPhone13,1":                              return "iPhone 12 mini"
        case "iPhone13,2":                              return "iPhone 12"
        case "iPhone13,3":                              return "iPhone 12 Pro"
        case "iPhone13,4":                              return "iPhone 12 Pro Max"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad7,5", "iPad7,6":                      return "iPad 6"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
        case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        default:                                        return identifier
        }
    }
}

