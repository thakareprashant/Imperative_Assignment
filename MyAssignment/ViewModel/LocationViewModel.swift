//
//  AppDelegate.swift
//  MyAssignment
//
//  Created by pthakare on 27/06/24.
//

import Foundation

import CoreLocation
import MapKit

enum PermissionLocation{
    
    case denied
    case success
    case notDetermine
}
class LocationViewModel: NSObject, CLLocationManagerDelegate {
    
    var coordinatesText: ((String) -> Void)?
    var addressText: ((String) -> Void)?
    var timeZoneText: ((String) -> Void)?
    var localTimeText: ((String) -> Void)?
    var mapRegion: ((MKCoordinateRegion) -> Void)?
    var permissionHandle:((PermissionLocation)->())?
    private let locationManager = CLLocationManager()
    private var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        
        locationManager.requestWhenInUseAuthorization()
        if  CLLocationManager.authorizationStatus() == .denied{
            permissionHandle?(.denied)
        }
        else if  CLLocationManager.authorizationStatus() == .notDetermined{
            permissionHandle?(.notDetermine)
        }
        locationManager.startUpdatingLocation()
        }
        
    
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location = location
            let coordinate = location.coordinate
            coordinatesText?("\(coordinate.latitude), \(coordinate.longitude)")
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                if let placemark = placemarks?.first {
                    self?.addressText?("\(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")")
                    
                    if let timeZone = placemark.timeZone {
                        self?.timeZoneText?("Time Zone: \(timeZone.identifier)")
                        let formatter = DateFormatter()
                        formatter.timeZone = timeZone
                        formatter.dateFormat = "h:mm a"
                        self?.localTimeText?("Local Time: \(formatter.string(from: Date()))")
                    }
                }
            }
            
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapRegion?(region)
            
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            case .denied, .restricted:
                permissionHandle?(.denied)
            default:
                break
            }
        }
}
