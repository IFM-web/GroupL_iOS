//
//  LocationManager.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//

import CoreLocation

class LocationManager: NSObject {
    
    static let shared                                               = LocationManager()
    private var statusCompletion :((Error?) -> Void)?               = nil
    private var locationBlock    :((CLLocation?, Error?) -> Void)?  = nil
    private var lastLocation: CLLocation?                           = nil
    private var allowsBackgroundLocation: Bool                      = false
    
    lazy var locationManager: CLLocationManager = {
        let locationManager                                = CLLocationManager()
        locationManager.desiredAccuracy                    = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter                     = LocationConst.minMetersBetweenLocations
        locationManager.activityType                       = .automotiveNavigation
        locationManager.delegate                           = self
        locationManager.allowsBackgroundLocationUpdates    = self.allowsBackgroundLocation
        locationManager.pausesLocationUpdatesAutomatically = false
        return locationManager
    }()
    
    lazy var isLocationEnable : Bool = {
        switch CLLocationManager.authorizationStatus() {
        case .restricted, .denied, .notDetermined:
            return false
            
        case .authorizedWhenInUse, .authorizedAlways:
            return true
        @unknown default:
            return false
        }
    }()
    
    var currentLocation:CLLocation?  {
        return lastLocation ?? locationManager.location
    }
    //===========================================================
    //MARK: - Private Init
    //===========================================================
    private override init() {}
    
    func requestAuthorization(_ always:Bool = false, backgroundEnable: Bool = false, completionHandler:((Error?) -> Void)? = nil) {
        statusCompletion         = completionHandler
        allowsBackgroundLocation = backgroundEnable
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            if always == true {
                locationManager.requestAlwaysAuthorization()
            }else{
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.requestLocation()
        case .restricted, .denied:
            statusCompletion?(getErrorMessage())
        case .authorizedWhenInUse, .authorizedAlways:
            statusCompletion?(nil)
        @unknown default:
            statusCompletion?(nil)
        }
    }
    func getLocationContinuously(_ completionHandler:((CLLocation?, Error?) -> Void)?  = nil) {
        locationBlock = completionHandler
        if isLocationEnable == true {
            locationManager.startUpdatingLocation()
        }else{
            guard let handler = completionHandler else { return }
            handler(nil,nil)
        }
    }
    func distance(sourceCood: CLLocationCoordinate2D? = nil, destinationCood: CLLocationCoordinate2D) -> Double  {
        let destinationLoc = CLLocation(latitude: destinationCood.latitude, longitude: destinationCood.longitude)
        if let cood = sourceCood {
            let sourceLoc = CLLocation(latitude: cood.latitude, longitude: cood.longitude)
            return sourceLoc.distance(from: destinationLoc)
        }
        return lastLocation?.distance(from: destinationLoc) ?? 0.0
    }
}
private extension LocationManager {
    func getErrorMessage() -> String? {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            return AlertConst.LocationMsg.notDetermine
        case .restricted, .denied:
            return AlertConst.LocationMsg.disable
        case .authorizedWhenInUse, .authorizedAlways:
            return nil
        @unknown default:
            return nil
        }
    }
}
extension LocationManager: CLLocationManagerDelegate {
    //===========================================================
    //MARK: - Configure Location Method
    //===========================================================
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(manager.location.)
        lastLocation = locations.filter({$0.horizontalAccuracy >= 0 && $0.horizontalAccuracy <= LocationConst.minMetersLocationAccuracy}).last
        
        if let block = locationBlock, let location = lastLocation {
            block(location, getErrorMessage())
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted,.denied:
            statusCompletion?(getErrorMessage())
        case .authorizedWhenInUse, .authorizedAlways:
            statusCompletion?(nil)
        default:
            print("LocationError: \(status)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationError: \(error.localizedDescription)")
    }
}

extension CLLocation {
    
    static func == (rhs: CLLocation, lhs: CLLocation) -> Bool {
        return rhs.distance(from: lhs) < LocationConst.minMetersForEquivalent
    }
    class func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return fabs(from.distance(from: to))
    }
    /// Calculates the bearing to another CLLocation.
    ///
    /// - Parameters:
    ///   - destination: Location to calculate bearing.
    /// - Returns: Calculated bearing degrees in the range 0° ... 360°
    public func bearing(to destination: CLLocation) -> Double {
        let lat1  = Double.pi * coordinate.latitude / 180.0
        let long1 = Double.pi * coordinate.longitude / 180.0
        
        let lat2  = Double.pi * destination.coordinate.latitude / 180.0
        let long2 = Double.pi * destination.coordinate.longitude / 180.0
        let rads = atan2(
            sin(long2 - long1) * cos(lat2),
            cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(long2 - long1))
        let degrees = rads * 180 / Double.pi
        return (degrees+360).truncatingRemainder(dividingBy: 360)
    }
}
// MARK: - Get Placemark
extension LocationManager {
    
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}
