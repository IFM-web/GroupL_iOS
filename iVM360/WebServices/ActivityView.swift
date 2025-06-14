//
//  ActivityView.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//

import UIKit
import MBProgressHUD

class ActivityView: NSObject {
    static func show(_ view:UIView){
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.bezelView.style           = .solidColor
        loadingNotification.bezelView.backgroundColor = UIColor.clear
        loadingNotification.contentColor              = UIColor.appColor
        //loadingNotification.label.text = "Loading.."
    }
    static func hide(_ view:UIView){
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        MBProgressHUD.hide(for: view, animated: true)
    }

}
