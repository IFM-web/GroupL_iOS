//
//  SceneDelegate.swift
//  iVM360
//
//  Created by 1707 on 15/07/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //------------------------------------------------------------------
        // Your RootViewController in here(loginFlow)
        //  ----------------------------------------------------------------
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let checkin = UserDefaults.standard.value(forKey: "checkin") as? Bool ?? false
            let isLogin = UserDefaults.standard.value(forKey: "isLogin") as? Bool ?? false
            let isDriver = UserDefaults.standard.value(forKey: "isDriver") as? Bool ?? false
            let is_supervisor_multipleHospital = UserDefaults.standard.value(forKey: "is_supervisor_multipleHospital") as? Bool ?? false
            
            if isLogin == true{
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginByPIN_VC") as! LoginByPIN_VC
                navigationController.viewControllers = [initialViewController]
                window.rootViewController = navigationController
                self.window = window
                window.makeKeyAndVisible()
                
                //                    }else if checkin == true {
                //
                //                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                //                        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                //                           let initialViewController = storyboard.instantiateViewController(withIdentifier: "SelectWorkVC") as! SelectWorkVC
                //                           navigationController.viewControllers = [initialViewController]
                //                         window.rootViewController = navigationController
                //                     self.window = window
                //                     window.makeKeyAndVisible()
                //
                //                    }else if isDriver == true{
                //                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                //                        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                //                           let initialViewController = storyboard.instantiateViewController(withIdentifier: "DriverDashBoardVC") as! DriverDashBoardVC
                //                           navigationController.viewControllers = [initialViewController]
                //                         window.rootViewController = navigationController
                //                     self.window = window
                //                     window.makeKeyAndVisible()
                //                    }else if is_supervisor_multipleHospital == true {
                //                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                //                        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                //                           let initialViewController = storyboard.instantiateViewController(withIdentifier: "CompnyHospitalListViewController") as! CompnyHospitalListViewController
                //                           navigationController.viewControllers = [initialViewController]
                //                         window.rootViewController = navigationController
                //                     self.window = window
                //                     window.makeKeyAndVisible()
                //                    }
                //                    else{
                //                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                //                        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                //                           let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                //                           navigationController.viewControllers = [initialViewController]
                //                    }
            } else{
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                   let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginImpIdVC") as! LoginImpIdVC
                   navigationController.viewControllers = [initialViewController]
            }
            
        }
            
            guard let _ = (scene as? UIWindowScene) else { return }
        
    }
        //    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //        print("killd6")
        //
        //        guard let _ = (scene as? UIWindowScene) else { return }
        //    }
        
        func sceneDidDisconnect(_ scene: UIScene) {
            print(AppSession.user?.EmpNumber ?? "")
            UserDefaultUtility().saveEmpNumber(EmpNumber: AppSession.user?.EmpNumber ?? "")
            // Called as the scene is being released by the system.
            // This occurs shortly after the scene enters the background, or when its session is discarded.
            // Release any resources associated with this scene that can be re-created the next time the scene connects.
            // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        }
        
        func sceneDidBecomeActive(_ scene: UIScene) {
            print("killd4")
            // Called when the scene has moved from an inactive state to an active state.
            // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        }
        
        func sceneWillResignActive(_ scene: UIScene) {
            print("killd3")
            // Called when the scene will move from an active state to an inactive state.
            // This may occur due to temporary interruptions (ex. an incoming phone call).
        }
        
        func sceneWillEnterForeground(_ scene: UIScene) {
            print("killd2")
            // Called as the scene transitions from the background to the foreground.
            // Use this method to undo the changes made on entering the background.
        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {
            print("killd1")
            // Called as the scene transitions from the foreground to the background.
            // Use this method to save data, release shared resources, and store enough scene-specific state information
            // to restore the scene back to its current state.
        }
        
        
    }
    

