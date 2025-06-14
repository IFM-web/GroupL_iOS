//
//  AlertViewByDefault.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//

import UIKit

class AlertView {
    
    typealias AlertClosure = (AlertButton) -> Swift.Void
    
    public enum AlertButton: Int{
        case Cancel = 1,Other
    }
    public static func show(title titleString:String = AlertConst.Header.alert, message messageString:String?,cancelButtonText cancelButtonTextString:String? = nil,otherButtonText buttonTextString:String? = nil,
        buttonIndex: (AlertClosure)? = nil) {
        let alert = UIAlertController(title: titleString.localized, message: (messageString ?? "").localized, preferredStyle: .alert)
            // alert.view.backgroundColor = #colorLiteral(red: 0.3190903068, green: 0.3465844095, blue: 0.5636267662, alpha: 1)
        
        alert.addAction(UIAlertAction(title: (cancelButtonTextString ?? "OK").localized, style: .cancel, handler: { (action) in
            buttonIndex?(AlertButton.Cancel)
           
        }))
        if let otherButton = buttonTextString {
            alert.addAction(UIAlertAction(title: otherButton.localized, style: .default, handler: { (action) in
                buttonIndex?(AlertButton.Other)
            }))
        }
        if let topVC = UIApplication.topViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
}
private extension AlertView {
    
    static func instanceFromNib() -> AlertView {
        return UINib(nibName: "AlertView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AlertView
    }
    //Completion Wrapper Class
    class CompletionWrapper {
        var completion: AlertClosure?
        init(_ completion: (AlertClosure)? = nil) {
            self.completion = completion
        }
    }
    //===========================================================
    //MARK: - Action Methods
//    //===========================================================
//    @IBAction func okeyBtnTapped(_ sender: UIButton) {
//        self.removeFromSuperview()
//        if let wrapper = objc_getAssociatedObject(self, &AlertView.AlertBlockKey) as? CompletionWrapper {
//            wrapper.completion?(AlertButton.other)
//        }
//    }
//    @IBAction func cancelBtnTapped(_ sender: UIButton) {
//        self.removeFromSuperview()
//        if let wrapper = objc_getAssociatedObject(self, &AlertView.AlertBlockKey) as? CompletionWrapper {
//            wrapper.completion?(AlertButton.cancel)
//        }
//    }
    
    
    
    
    
}
