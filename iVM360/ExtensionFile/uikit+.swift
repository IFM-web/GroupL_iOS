//
//  uikit+.swift
//  DexgoHousekeeping
//
//  Created by Apple on 14/05/22.
//

import UIKit
import SafariServices

//===========================================================
//MARK: - UIApplication Methods
//===========================================================
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

//===========================================================
//MARK: - UIView Extension
//===========================================================
//extension UIView {
//
//    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
//    }
//
//    @IBInspectable
//    var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius  = newValue
//        }
//    }
//
//    @IBInspectable
//    var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//
//    @IBInspectable
//    var borderColor: UIColor? {
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.borderColor = color.cgColor
//            } else {
//                layer.borderColor = nil
//            }
//        }
//    }
//    @IBInspectable var bottomBorderWidth: CGFloat {
//            get {
//                return 0.0   // Just to satisfy property
//            }
//            set {
//                let line = UIView(frame: CGRect(x: 0.0, y: bounds.height, width: bounds.width, height: newValue))
//                line.translatesAutoresizingMaskIntoConstraints = false
//                line.backgroundColor = borderColor
//                line.tag = 110
//                self.addSubview(line)
//
//                let views = ["line": line]
//                let metrics = ["lineWidth": newValue]
//                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
//                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
//            }
//        }
//
//
//
//    func removeborder() {
//        for view in self.subviews {
//            if view.tag == 110  {
//                view.removeFromSuperview()
//            }
//
//        }
//    }
//
//    func fadeIn() {
//        // Move our fade out code from earlier
//        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionFlipFromTop, animations: {
//            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
//        }, completion: nil)
//    }
//
//    func fadeOut() {
//        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionFlipFromBottom, animations: {
//            self.alpha = 0.0
//        }, completion: nil)
//    }
//
//
//    func updateLayerProperties(with:UIColor) {
//        self.layer.shadowColor = with.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 10.0
//        self.layer.masksToBounds = false
//    }
//
//    func cornerRadius(_ radius:CGFloat) -> Void {
//        self.layer.cornerRadius  = radius
//        self.layer.masksToBounds = true
//    }
//
//    func border(_ width:CGFloat, borderColor:UIColor) -> Void {
//        self.layer.borderWidth   = width
//        self.layer.borderColor   = borderColor.cgColor
//        self.layer.masksToBounds = true
//    }
//
//    func shadows(_ color:UIColor, cornerRadius:CGFloat) -> Void {
//        self.layer.masksToBounds = false
//        self.layer.shadowColor   = color.cgColor
//        self.layer.shadowOffset  = CGSize(width: 2, height: 2)
//        self.layer.shadowOpacity = 0.6
//        self.layer.shadowRadius  = 4.0
//        self.layer.cornerRadius  = cornerRadius
//    }
//
//    func shadowWithBular(shadowColor:UIColor, cornerRadius:CGFloat){
//
//
//
//        self.layer.cornerRadius = 5
//
//        // border
//        self.layer.borderWidth  = 1.0
//        self.layer.borderColor  = shadowColor.cgColor
//
//        // shadow
//        self.layer.shadowColor  = shadowColor.cgColor
//        self.layer.shadowOffset  = CGSize(width: 2, height: 2)
//        self.layer.shadowOpacity  = 0.7
//        self.layer.shadowRadius   = 5.0
//
//    }
//
//    func dropShadow(shadowColor:UIColor, shadowRadius:Float){
//        self.backgroundColor = UIColor.clear
//        self.layer.shadowColor = shadowColor.cgColor
//        self.layer.shadowOffset = CGSize(width: 3, height: 3)
//        self.layer.shadowOpacity = 0.7
//        self.layer.shadowRadius = 4.0
//    }
//    var safeTopAnchor: NSLayoutYAxisAnchor {
//        if #available(iOS 11.0, *) {
//            return self.safeAreaLayoutGuide.topAnchor
//        } else {
//            return self.topAnchor
//        }
//    }
//
//    var safeLeftAnchor: NSLayoutXAxisAnchor {
//        if #available(iOS 11.0, *){
//            return self.safeAreaLayoutGuide.leftAnchor
//        }else {
//            return self.leftAnchor
//        }
//    }
//
//    var safeRightAnchor: NSLayoutXAxisAnchor {
//        if #available(iOS 11.0, *){
//            return self.safeAreaLayoutGuide.rightAnchor
//        }else {
//            return self.rightAnchor
//        }
//    }
//
//    var safeBottomAnchor: NSLayoutYAxisAnchor {
//        if #available(iOS 11.0, *) {
//            return self.safeAreaLayoutGuide.bottomAnchor
//        } else {
//            return self.bottomAnchor
//        }
//    }
//    func rotateInfinity() {
//        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//       // rotation.toValue                = -360.degreesToRadians
//        rotation.duration               = 1.1
//        rotation.isCumulative           = true
//        rotation.repeatCount            = Float.infinity
//        rotation.isRemovedOnCompletion  = false
//        self.layer.add(rotation, forKey: "rotationAnimation")
//    }
//}
//extension UITextField{
//    //===========================================================
//    //MARK: - UITextField Extension
//    //===========================================================
//   @IBInspectable var placeHolderColor: UIColor? {
//        get {
//            return self.placeHolderColor
//        }
//        set {
//            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
//        }
//    }
//    @IBInspectable var paddingLeftCustom: CGFloat {
//            get {
//                return leftView!.frame.size.width
//            }
//            set {
//                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
//                leftView = paddingView
//                leftViewMode = .always
//            }
//        }
//
//
//}
//===========================================================
//MARK: - UINavtiogation Extension
//===========================================================
extension UINavigationBar {
    var isTransperent: Bool {
        get {
            return false // Just to satisfy property
        }
        set {
            if newValue == true {
                self.shadowImage   = UIImage()
                self.isTranslucent = true
                self.setBackgroundImage(UIImage(), for: .default)
            }else{
                self.shadowImage   = UIImage()
                self.isTranslucent = false
                self.setBackgroundImage(nil, for: .default)
            }
        }
    }
    var titleColor: UIColor?  {
        get {
            guard let attributes = self.titleTextAttributes else { return nil }
            return attributes[NSAttributedString.Key.foregroundColor] as? UIColor
        }
        set {
            if let color = newValue {
                var attributes                             = [NSAttributedString.Key : Any]()
                if let font                                = self.titleFont {
                    attributes[NSAttributedString.Key.font] = font
                }
                attributes[NSAttributedString.Key.foregroundColor] = color
                if #available(iOS 11.0, *) {
                    self.largeTitleTextAttributes = attributes
                }
                self.titleTextAttributes          = attributes
            }
        }
    }
    var titleFont: UIFont? {
        get {
            guard let attributes = self.titleTextAttributes else { return nil }
            return attributes[NSAttributedString.Key.font] as? UIFont
        }
        set {
            if let font = newValue {
                var attributes                             = [NSAttributedString.Key : Any]()
                if let color                               = self.titleColor {
                    attributes[NSAttributedString.Key.foregroundColor] = color
                }
                attributes[NSAttributedString.Key.font] = font
                if #available(iOS 11.0, *) {
                    self.largeTitleTextAttributes = attributes
                }
                self.titleTextAttributes          = attributes
            }
        }
    }
}
//
////===========================================================
////MARK: - Navigation Controller Extension
////===========================================================
//extension UINavigationController {
//    open override var preferredStatusBarStyle: UIStatusBarStyle {
//        return topViewController?.preferredStatusBarStyle ?? .default
//    }
//
//}
extension UIApplication {
    static var release: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "x.x"
    }
    static var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "x"
    }
    static var version: String {
        return "\(release).\(build)"
    }
}
