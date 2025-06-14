//
//  Extention.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//

import UIKit
//import Alamofire
//
////import RxAlamofire
//import RxSwift

 @available(iOS 13.0, *)

//===========================================================
//MARK: - StatusBar Color
//===========================================================
extension AppDelegate {
    
    private struct Holder {
        static var _myComputedProperty:UIStatusBarStyle = .default
    }
    static var statusBarStyle:UIStatusBarStyle {
        get {
            return Holder._myComputedProperty
        }
        set(newValue) {
            Holder._myComputedProperty = newValue
        }
    }
    static func statusBar(color: UIColor) {
        guard let bg = value(forKey: "statusBar") as? UIView else {
            return
        }
        bg.backgroundColor = color
    }
 class var shared: AppDelegate {
       return UIApplication.shared.delegate as! AppDelegate
   }
}
extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
    var retainCount: String {
        return String(describing: CFGetRetainCount(self))
    }
}
//===========================================================
//MARK: - Numbers Extension
//===========================================================
extension Int {
    var bool: Bool {
        return self > 0 ? true : false
    }
    var uInt: UInt {
        return UInt(self)
    }
    var float: Float {
        return Float(self)
    }
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    var string: String {
        return String(describing: self)
    }
    var degreesToRadians: Double {
        return Double.pi * Double(self) / 180.0
    }
    var radiansToDegrees: Double {
        return Double(self) * 180 / Double.pi
    }
}
extension Double {
    var int: Int {
        return Int(self)
    }
    var float: Float {
        return Float(self)
    }
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    var string: String {
        return String(describing: self)
    }
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    var degreesToRadians: Double {
        return Double.pi * self / 180.0
    }
    var radiansToDegrees: Double {
        return self * 180 / Double.pi
    }
}
//===========================================================
//MARK: - String  Extension
//===========================================================
extension String: Error,LocalizedError {
    
    var bool: Bool {
        return self == "true" || self == "1" ? true : false
    }
    public var errorDescription: String? {
        return self
    }
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var isValidEmail: Bool{
        let regex = "^(?:[\\p{L}0-9!#$%\\&'+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'+/=?\\^_`{|}~-]+)|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-][\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-][\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    var url: URL? {
        return URL(string: self)
    }
    var isValidUrl: Bool {
        guard let url = self.url else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
    var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    func openUrl(){
        if self.isValidUrl {
            UIApplication.shared.open(self.url!, options:[:], completionHandler: { (flag) in
                print("\(flag ? "Open" : "Not Open")")
            })
        }
    }
    func call(){
        let urlString = "telprompt://" + self
        if urlString.isValidUrl {
            UIApplication.shared.open(self.url!, options:[:], completionHandler: { (flag) in
                print("\(flag ? "Open" : "Not Open")")
            })
        }
    }
}
//===========================================================
//MARK: - NotificationCenter
//===========================================================
extension Notification.Name {
    static let pageControl = Notification.Name("PageControl")
    static let updateMenu  = Notification.Name("UpdateMenu")
}

extension String {
func toCurrencyFormat() -> String {
    if let doubleValue = Double(self){
        let numberFormatter = NumberFormatter()
        
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        // localize to your grouping and decimal separator
        // currencyFormatter.locale = Locale.current
        return  numberFormatter.string(from: NSNumber(value: doubleValue))!
    }
    return ""
}
}
//extension UIViewController {
//
//   public func getIPAddress() -> String {
//        var address: String?
//        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
//        if getifaddrs(&ifaddr) == 0 {
//            var ptr = ifaddr
//            while ptr != nil {
//                defer { ptr = ptr?.pointee.ifa_next }
//
//                guard let interface = ptr?.pointee else { return "" }
//                let addrFamily = interface.ifa_addr.pointee.sa_family
//                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
//
//                    // wifi = ["en0"]
//                    // wired = ["en2", "en3", "en4"]
//                    // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
//
//                    let name: String = String(cString: (interface.ifa_name))
//                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
//                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
//                        address = String(cString: hostname)
//                    }
//                }
//            }
//            freeifaddrs(ifaddr)
//        }
//        return address ?? ""
//    }
//
//
//    public func alertShow1(title: String, message msg:String) -> Observable<AlertButton> {
//         let alertVC = self.storyboard?.instantiateViewController(withIdentifier: "AlertVC") as! AlertVC
//
//            self.present(alertVC, animated: true) {
//                UIView.animate(withDuration: 0.5, animations: {
//                    alertVC.alertTitleLbl.text = title
//                    alertVC.alertMsgLbl.text = msg
//                    alertVC.cancelBtn.setTitle("OK".localized, for: .normal)
//                    alertVC.otherBtn.isHidden = true
//                    alertVC.alertView.isHidden = false
//                })
//
//            }
//
//        return  alertVC.selectedButton
//
//
//
//    }
//    public func alert(title: String, message msg:String,  buttonText buttonTextString:String? = nil) -> Observable<AlertButton>{
//        let alertVC = self.storyboard?.instantiateViewController(withIdentifier: "AlertVC") as! AlertVC
//        self.present(alertVC, animated: true) {
//            UIView.animate(withDuration: 0.5, animations: {
//                alertVC.alertTitleLbl.text = title
//                alertVC.alertMsgLbl.text = msg
//                alertVC.cancelBtn.setTitle("YES".localized, for: .normal)
//                alertVC.otherBtn.setTitle(buttonTextString?.uppercased(), for: .normal)
//                alertVC.alertView.isHidden = false
//                alertVC.borderView.isHidden = false
//            }
//            )
//        }
//        return  alertVC.selectedButton
//
//    }
//    public func alert(title: String, message msg:String,  buttonText buttonTextString:String? = nil,cancelbuttonText cancelTextString:String? = nil) -> Observable<AlertButton>{
//        let alertVC = self.storyboard?.instantiateViewController(withIdentifier: "AlertVC") as! AlertVC
//        self.present(alertVC, animated: true) {
//            UIView.animate(withDuration: 0.5, animations: {
//                alertVC.alertTitleLbl.text = title
//                alertVC.alertMsgLbl.text = msg
//                alertVC.otherBtn.setTitleColor( #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
//
//                alertVC.otherBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
//
//                alertVC.otherBtn.setTitle(buttonTextString, for: .normal)
//           alertVC.cancelBtn.setTitleColor( #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
//           //   alertVC.cancelBtn.titleLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//                alertVC.cancelBtn.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.1176470588, blue: 0.137254902, alpha: 1)
//               alertVC.cancelBtn.titleLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//                alertVC.cancelBtn.setTitle(cancelTextString, for: .normal)
//                alertVC.alertView.isHidden = false
//                alertVC.borderView.isHidden = false
//            }
//            )
//        }
//        return  alertVC.selectedButton
//
//    }
//
//}
public enum AlertButton: Int{
    case Cancel = 1,Other
}
class StaticHelper: NSObject {
    //MARK: - Check Internet Connectivity
    //===========================================================
    static var isInternetConnected:Bool{
        let reachability =  Reachability()!
        return reachability.isReachable
    }

    static func logOutUser() {
//        UserDefaults.standard.removeObject(forKey: UDConst.User)
//        UserDefaults.standard.removeObject(forKey: UDConst.PaymentType)
//        UserDefaults.standard.removeObject(forKey: UDConst.Payment)
//        UserDefaults.standard.synchronize()
//
//        AppDelegate.shared.setRoot(viewController: .Login)

//        UserDefaults.standard.removeObject(forKey: "deviceToken")
//        UserDefaults.standard.set("", forKey: "userID")
//        UserDefaults.standard.synchronize()
//        let realm = try! Realm()
//        try! realm.write {
//            realm.deleteAll()
//        }
//
//        let vc:SignupViewController = SignupViewController.instantiate()
//       // vc.itemDetail = self.itemDetail
//        self.navigationController?.pushViewController(vc, animated:true)
    }


}
//extension UIImage {
//
//    public class func gifImageWithData(_ data: Data) -> UIImage? {
//        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
//            print("image doesn't exist")
//            return nil
//        }
//
//        return UIImage.animatedImageWithSource(source)
//    }
//
//    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
//        guard let bundleURL:URL = URL(string: gifUrl)
//            else {
//                print("image named \"\(gifUrl)\" doesn't exist")
//                return nil
//        }
//        guard let imageData = try? Data(contentsOf: bundleURL) else {
//            print("image named \"\(gifUrl)\" into NSData")
//            return nil
//        }
//
//        return gifImageWithData(imageData)
//    }
//
//    public class func gifImageWithName(_ name: String) -> UIImage? {
//        guard let bundleURL = Bundle.main
//            .url(forResource: name, withExtension: "gif") else {
//                print("SwiftGif: This image named \"\(name)\" does not exist")
//                return nil
//        }
//        guard let imageData = try? Data(contentsOf: bundleURL) else {
//            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
//            return nil
//        }
//
//        return gifImageWithData(imageData)
//    }
//
//    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
//        var delay = 0.05
//
//        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
//        let gifProperties: CFDictionary = unsafeBitCast(
//            CFDictionaryGetValue(cfProperties,
//                Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
//            to: CFDictionary.self)
//
//        var delayObject: AnyObject = unsafeBitCast(
//            CFDictionaryGetValue(gifProperties,
//                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
//            to: AnyObject.self)
//        if delayObject.doubleValue == 0 {
//            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
//                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
//        }
//
//        delay = delayObject as! Double
//
//        if delay < 0.05 {
//            delay = 0.05
//        }
//
//        return delay
//    }
//
//    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
//        var a = a
//        var b = b
//        if b == nil || a == nil {
//            if b != nil {
//                return b!
//            } else if a != nil {
//                return a!
//            } else {
//                return 0
//            }
//        }
//
//        if a! < b! {
//            let c = a
//            a = b
//            b = c
//        }
//
//        var rest: Int
//        while true {
//            rest = a! % b!
//
//            if rest == 0 {
//                return b!
//            } else {
//                a = b
//                b = rest
//            }
//        }
//    }
//
//    class func gcdForArray(_ array: Array<Int>) -> Int {
//        if array.isEmpty {
//            return 1
//        }
//
//        var gcd = array[0]
//
//        for val in array {
//            gcd = UIImage.gcdForPair(val, gcd)
//        }
//
//        return gcd
//    }
//
//    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
//        let count = CGImageSourceGetCount(source)
//        var images = [CGImage]()
//        var delays = [Int]()
//
//        for i in 0..<count {
//            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
//                images.append(image)
//            }
//
//            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
//                source: source)
//            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
//        }
//
//        let duration: Int = {
//            var sum = 0
//
//            for val: Int in delays {
//                sum += val
//            }
//
//            return sum
//        }()
//
//        let gcd = gcdForArray(delays)
//        var frames = [UIImage]()
//
//        var frame: UIImage
//        var frameCount: Int
//        for i in 0..<count {
//            frame = UIImage(cgImage: images[Int(i)])
//            frameCount = Int(delays[Int(i)] / gcd)
//
//            for _ in 0..<frameCount {
//                frames.append(frame)
//            }
//        }
//
//        let animation = UIImage.animatedImage(with: frames,
//            duration: Double(duration) / 1000.0)
//
//        return animation
//    }
//}

