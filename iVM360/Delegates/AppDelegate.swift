////
////  AppDelegate.swift
////  iVM360
////
////  Created by 1707 on 15/07/24.
////
//
//import UIKit
//import IQKeyboardManagerSwift
//import UserNotifications
//import CoreLocation
//import AppTrackingTransparency
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//
//    var window: UIWindow?
//    var deviceToken1 = ""
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        if #available(iOS 14.5, *) {
//                    // Request tracking authorization
//                    ATTrackingManager.requestTrackingAuthorization { status in
//                        switch status {
//                        case .authorized:
//                            // User authorized tracking, you can start collecting data
//                            print("Tracking authorized")
//                            // Example: Start tracking here
//                        case .denied:
//                            // User denied tracking, handle accordingly
//                            print("Tracking denied")
//                            // Example: Show an alert explaining the importance of tracking for app functionality or advertising
//                        case .notDetermined:
//                            // Tracking authorization has not been requested yet
//                            print("Tracking authorization not determined")
//                        case .restricted:
//                            // Tracking is restricted, for example, due to parental controls
//                            print("Tracking restricted")
//                        @unknown default:
//                            // Handle future cases if needed
//                            print("Unknown tracking authorization status")
//                        }
//                    }
//                } else {
//                    // Fallback on earlier versions
//                    print("AppTrackingTransparency framework is not available")
//                }
//
//        
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.delegate = self
//        
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
//        (granted, error) in
//        guard granted else { return }
//        DispatchQueue.main.async {
//            
//        UIApplication.shared.registerForRemoteNotifications()
//        }
//        }
//// ---------------------------------
////        lunch screen time set
////------------------------------------
//        Thread.sleep(forTimeInterval: 7.0)
////  ----------------------------------------
//         UIApplication.shared.isIdleTimerDisabled = true
//         IQKeyboardManager.shared.enable                   = true
//         IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
//        return true
//    }
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    // 1. Convert device token to string
//    let tokenParts = deviceToken.map { data -> String in
//    return String(format: "%02.2hhx", data)
//    }
//    let token = tokenParts.joined()
//    // 2. Print device token to use for PNs payloads
//    print("Device Token: \(token)")
//        UserDefaults.standard.set(token, forKey: "deviceToken")
//        deviceToken1 = "\(token)"
//    let bundleID = Bundle.main.bundleIdentifier;
//    print("Bundle ID: \(token) \(bundleID)");
//    // 3. Save the token to local storeage and post to app server to generate Push Notification. ...
//    }
//    
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//    print("failed to register for remote notifications: \(error.localizedDescription)")
//    }
//    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
//    print("Received push notification: \(userInfo)")
//    let aps = userInfo["aps"] as! [String: Any]
//    print("\(aps)")
//    }
//    
//    // This method will be called when app received push notifications in foreground
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
//    {
//        completionHandler([.alert, .badge, .sound])
//    }
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        print("killd")
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//        print("killd")
//    }
//    
//    private func setupAppBehavior(_ launchOptions:[UIApplication.LaunchOptionsKey: Any]? = nil) {
//           UIApplication.shared.isIdleTimerDisabled            = true
//           IQKeyboardManager.shared.enable                    = true
//           IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
//          
//       }
//
//
//}
//
//
//  AppDelegate.swift
//  iVM360
//
//  Created by 1707 on 15/07/24.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import CoreLocation
import AppTrackingTransparency
import FirebaseCore
import FirebaseMessaging
import AdSupport
//import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var deviceToken1 = ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 16.0, *) {
            print("Database Path", URL.documentsDirectory)
        } else {
            // Fallback on earlier versions
        }
        // Override point for customization after application launch.
        if #available(iOS 14.5, *) {
                    // Request tracking authorization
                    ATTrackingManager.requestTrackingAuthorization { status in
                        switch status {
                        case .authorized:
                            // User authorized tracking, you can start collecting data
                            print("Tracking authorized")
                            // Example: Start tracking here
                        case .denied:
                            // User denied tracking, handle accordingly
                            print("Tracking denied")
                            // Example: Show an alert explaining the importance of tracking for app functionality or advertising
                        case .notDetermined:
                            // Tracking authorization has not been requested yet
                            print("Tracking authorization not determined")
                        case .restricted:
                            // Tracking is restricted, for example, due to parental controls
                            print("Tracking restricted")
                        @unknown default:
                            // Handle future cases if needed
                            print("Unknown tracking authorization status")
                        }
                    }
                } else {
                    // Fallback on earlier versions
                    print("AppTrackingTransparency framework is not available")
                }

        FirebaseApp.configure()
                
                // Request Notification Permissions
                registerForPushNotifications(application)
                
                Messaging.messaging().delegate = self
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
        (granted, error) in
        guard granted else { return }
        DispatchQueue.main.async {
            
        UIApplication.shared.registerForRemoteNotifications()
        }
        }
// ---------------------------------
//        lunch screen time set
//------------------------------------
        Thread.sleep(forTimeInterval: 7.0)
//  ----------------------------------------
         UIApplication.shared.isIdleTimerDisabled = true
        IQKeyboardManager.shared.isEnabled                   = true
        IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = false
        return true
    }
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    // 1. Convert device token to string
//    let tokenParts = deviceToken.map { data -> String in
//    return String(format: "%02.2hhx", data)
//    }
//    let token = tokenParts.joined()
//    // 2. Print device token to use for PNs payloads
//    print("Device Token: \(token)")
//        UserDefaults.standard.set(token, forKey: "deviceToken")
//        deviceToken1 = "\(token)"
//    let bundleID = Bundle.main.bundleIdentifier;
//    print("Bundle ID: \(token) \(bundleID)");
//    // 3. Save the token to local storeage and post to app server to generate Push Notification. ...
//    }
    // Register for push notifications
        func registerForPushNotifications(_ application: UIApplication) {
            UNUserNotificationCenter.current().delegate = self
            let options: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
                print("Permission granted: \(granted)")
            }
            application.registerForRemoteNotifications()
        }

        // Handle APNs token registration
        func application(
            _ application: UIApplication,
            didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
        ) {
            let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
            }
            let token = tokenParts.joined()
            // 2. Print device token to use for PNs payloads
            print("Device Token: \(token)")
                //UserDefaults.standard.set(token, forKey: "deviceToken")
                deviceToken1 = "\(token)"
            UserDefaultUtility().saveDevicesToken(deviceToken: deviceToken1)
            let bundleID = Bundle.main.bundleIdentifier;
            print("Bundle ID: \(token) \(bundleID)");

            Messaging.messaging().apnsToken = deviceToken
        }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    print("Received push notification: \(userInfo)")
    let aps = userInfo["aps"] as! [String: Any]
    print("\(aps)")
    }
    
    // This method will be called when app received push notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        print("killd")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func setupAppBehavior(_ launchOptions:[UIApplication.LaunchOptionsKey: Any]? = nil) {
           UIApplication.shared.isIdleTimerDisabled            = true
        IQKeyboardManager.shared.isEnabled                   = true
        IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = false
          
       }

}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken = fcmToken else { return }
        print("FCM Token: \(fcmToken)")
        UserDefaultUtility().saveFcmToken(fcmToken: fcmToken)
        
        // Save or send the token to your server
    }
}
