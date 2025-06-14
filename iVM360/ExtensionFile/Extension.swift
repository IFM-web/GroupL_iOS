//
//  Extension.swift
//  Batse Rider
//
//  Created by Navneet on 27/12/21.
//


import UIKit

//Hide keyboard on tap outside
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func fullDateIntoHourNMint(dateAndTime: String) -> String{
    let dateString2 = dateAndTime

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
    dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")

    let dateObj = dateFormatter.date(from: dateString2)
    dateFormatter.dateFormat = "hh:mm"
//    print("Dateobj: \(dateFormatter.string(from: dateObj!))")
        return "\(dateFormatter.string(from: dateObj!))"
    }
    func fullDateIntoHourNMin(dateAndTime: String) -> String{
    let dateString2 = dateAndTime

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm:ss"
    dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")

    let dateObj = dateFormatter.date(from: dateString2)
    dateFormatter.dateFormat = "H:mm:ss"
//    print("Dateobj: \(dateFormatter.string(from: dateObj!))")
        return "\(dateFormatter.string(from: dateObj!))"
    }
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "H:mm"
        
            return dateFormatter.string(from: date)
        }
        return nil
    }
    func UTCToLocale(date:String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat

        return dateFormatter.string(from: dt ?? Date())
    }
}
class DateHelper: NSObject {
    
    public enum TimeZone{
        case local, utc
    }
    
    static let instance = DateHelper()
    private var dateFormatter: DateFormatter!
    
    override private init() {
        dateFormatter = DateFormatter()
        if let languageCode = Locale.current.languageCode {
            switch languageCode {
                //  case "en":
            // handle English
            case "es":
                dateFormatter.locale = Locale(identifier: "es_CR")
                // handle Spanish
                //  case "ar":
            // handle Arabic
            default:
                dateFormatter.locale = Locale(identifier: "en_US")
                // handle others
            }
        }
        
    }
    public  func date(fromString strDate:String, withFormat strDateFormat:String, andTimeZone timezone:TimeZone) -> Date? {
        var date:Date?
        dateFormatter.timeZone = getTimeZone(timezone)
        if strDate.isEmpty == false {
            if strDateFormat.isEmpty == false {
                dateFormatter.dateFormat = strDateFormat
            }
            date = dateFormatter.date(from: strDate)
        }
        return date
    }
    
    public func date(fromDate date:Date, withFormat strDateFormat:String, andTimeZone timezone:TimeZone) -> Date? {
        var dateObj:Date?
        dateFormatter.timeZone = getTimeZone(timezone)
        if strDateFormat.isEmpty == false {
            dateFormatter.dateFormat = strDateFormat
        }
        dateObj = dateFormatter.date(from: dateFormatter.string(from: date))
        return dateObj
    }
    public func string(fromDate date:Date, withFormat strDateFormat:String, andTimeZome timezone:TimeZone) -> String {
        var strDate: String = ""
        dateFormatter.timeZone = getTimeZone(timezone)
        if strDateFormat.isEmpty == false {
            dateFormatter.dateFormat = strDateFormat
        }
        strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    public static func components(fromDate date:Date) -> DateComponents {
        let components = (Calendar.current as NSCalendar).components([.year,.month,.day,.hour,.minute,.second,.weekdayOrdinal,.weekday,.weekOfYear,.weekOfMonth], from: date)
        return components
    }
    
    
    public static func timeInMiliSeconds(fromDate date:Date) -> String {
        let  miliSecond = date.timeIntervalSince1970 * 1000.0
        return String(describing:Int64(miliSecond))
    }
    
    public static func date(FromMiliSeconds miliSec: Double) -> Date? {
        return  Date(timeIntervalSince1970: miliSec / 1000.0)
    }
    
    private func getTimeZone(_ zone:TimeZone) -> Foundation.TimeZone {
        switch zone {
        case .utc:
            return Foundation.TimeZone(abbreviation: "UTC")!
        case .local:
            return Foundation.TimeZone.autoupdatingCurrent
        }
    }
}
extension UIViewController {
    func reloadViewFromNib() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view) // This line causes the view to be reloaded
    }
}
extension Date {
    var weekdayName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "E"
        return formatter.string(from: self as Date)
    }
    var weekdayNameFull: String {
        let formatter = DateFormatter(); formatter.dateFormat = "EEE"
        return formatter.string(from: self as Date)
    }
    var monthName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "MMM"
        return formatter.string(from: self as Date)
    }
    var OnlyYear: String {
        let formatter = DateFormatter(); formatter.dateFormat = "YYYY"
        return formatter.string(from: self as Date)
    }
    var period: String {
        let formatter = DateFormatter(); formatter.dateFormat = "a"
        return formatter.string(from: self as Date)
    }
    var timeOnly: String {
        let formatter = DateFormatter(); formatter.dateFormat = "hh:mm"
        return formatter.string(from: self as Date)
    }
    var timeWithPeriod: String {
        let formatter = DateFormatter(); formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self as Date)
    }
    var datewithtime: String {
        let formatter = DateFormatter(); formatter.dateFormat = "dd:mm:yyyy, hh:mm a"
        return formatter.string(from: self as Date)
    }

    var DatewithMonth: String {
        let formatter = DateFormatter(); formatter.dateStyle = .medium ;        return formatter.string(from: self as Date)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
            return calendar.dateComponents(Set(components), from: self)
        }

        func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
            return calendar.component(component, from: self)
        }
}
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

