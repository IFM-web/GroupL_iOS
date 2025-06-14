//
//  RegistrationTabVC.swift
//  iVM360
//
//  Created by 1707 on 15/07/24.
//

import UIKit
import CoreLocation
class RegistrationTabVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var newRegistrationBtn: UIButton!
    @IBOutlet weak var registeredBtn: UIButton!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
   var isnewRegistration = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.newRegistrationBtn.isHidden = true
        self.newRegistrationBtn.layer.cornerRadius = 5
        self.registeredBtn.layer.cornerRadius = 5
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        locationManager = CLLocationManager()
    }
    if let location         = LocationManager.shared.currentLocation {
        print(location.coordinate.latitude.string)
        print(location.coordinate.longitude.string)

        
    }
    }
    
    @IBAction func newRegistrationClickBtn(_ sender: Any) {
        self.isnewRegistration = false
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginTabVC") as? LoginTabVC
        vc?.isNewRegistration_Back = self.isnewRegistration
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func registeredClickBtn(_ sender: Any) {
        self.isnewRegistration = true
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginTabVC") as? LoginTabVC
        vc?.isNewRegistration_Back = self.isnewRegistration
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
