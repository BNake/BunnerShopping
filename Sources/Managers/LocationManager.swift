//
//  LocationManager.swift
//  VIPTemplate
//
//  Created by The Son    on 11/2/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import INTULocationManager

class LocationManager {
    static let sharedInstance: LocationManager = LocationManager()
    
    private(set) var currentLocation: CLLocation?
    private(set) var currentCountryCode: String?
    
    private lazy var manager = INTULocationManager.sharedInstance()
    
    private var startMonitoring = false
    
    init() {
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) {[weak self] _ in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.startMonitoring {
                strongSelf.startMonitoringUserLocation()
            }
        }
    }
    
    func requestCurrentLocation(onSuccess result:@escaping (_: CLLocation) -> Void, onFailed failed:@escaping () -> Void) {
        if let currentLocation = currentLocation {
            result(currentLocation)
            return
        }
        
        self.manager.requestLocation(withDesiredAccuracy: .neighborhood, timeout: 10.0, delayUntilAuthorized: true) { [weak self] currentLocation, _, status in
            if status == INTULocationStatus.success {
                // Request succeeded, meaning achievedAccuracy is at least the requested accuracy, and
                // currentLocation contains the device's current location
                if let location = currentLocation {
                    result(location)
                    self?.currentLocation = currentLocation
                } else {
                    failed()
                }
            } else if status == INTULocationStatus.timedOut {
                // Wasn't able to locate the user with the requested accuracy within the timeout interval.
                // However, currentLocation contains the best location available (if any) as of right now,
                // and achievedAccuracy has info on the accuracy/recency of the location in currentLocation.
                failed()
            } else {
                // An error occurred, more info is available by looking at the specific status returned.
                failed()
            }
        }
    }
    
    func requestCurrentLocation(onSuccess result:@escaping (_: CLLocation, _ countryCode: String) -> Void, onFalied failed:@escaping () -> Void) {
        self.requestCurrentLocation(onSuccess: { [weak self] currentLocation in
            
            guard let theLocation = self?.currentLocation else {
                failed()
                return
            }
            
            self?.getCurrentCountryCode(location: theLocation,
                                        onSuccess: { currentCountryCode in
                                            result(theLocation, currentCountryCode)
                                        }, onFailed: {
                                            failed()
                                        })
            
        }, onFailed: {
            failed()
        })
    }
    
    let geoCoder = CLGeocoder()
    
    private func getCurrentCountryCode(location: CLLocation, onSuccess result:@escaping (_ countryCode: String) -> Void, onFailed failed:@escaping () -> Void) {
        geoCoder.cancelGeocode()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { [weak self] placeMarks, error in
            guard let places = placeMarks, places.count > 0, error == nil else {
                failed()
                return
            }
            let thePlace = places[0]
            self?.currentCountryCode = thePlace.isoCountryCode
            LogDebug("Current country: \(self?.currentCountryCode ?? "")")
            result(thePlace.isoCountryCode ?? "")
        })
    }
    
    func distanceFromCurrent(toLat lat: Double, toLng lng: Double) -> Double? {
        return self.currentLocation?.distance(from: CLLocation(latitude: lat, longitude: lng))
    }

    func isLocationEnable() -> Bool {
        return (INTULocationManager.locationServicesState() == .available)
    }
    
    private var monitoringRequestID: INTULocationRequestID = 0
    
    func startMonitoringUserLocation() {

    }
    
    func stopMonitoringUserLocation() {
        startMonitoring = false
        self.manager.cancelLocationRequest(monitoringRequestID)
    }

}
