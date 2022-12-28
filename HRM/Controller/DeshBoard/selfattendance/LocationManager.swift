//
//  LocationManager.swift
//  ezzyride-app-ios
//
//  Created by Innovadeaus on 4/2/19.
//  Copyright © 2019 Innovadeus Pvt. Ltd. All rights reserved.
//

import Foundation

import CoreLocation
import GoogleMaps
import GooglePlaces

extension SelfAttendanceController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if Reachability.isConnectedToNetwork() == true{

            }
        if let lastLocation = locations.last {
            currentLocationMarker?.position = lastLocation.coordinate
            currentLocationMarker?.rotation = lastLocation.course
            zoomToCoordinates(lastLocation.coordinate, zoom: 15)
            lastLocationLatLng = lastLocation.coordinate
  
        }
        }
 
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            break
        case .restricted:
            break
        case .denied:
            stopMonitoringLocation()
            break
        default:
            addCurrentLocationMarker(name: "self_location")
            startMonitoringLocation()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors: " + error.localizedDescription)
    }
    
    func startMonitoringLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.activityType = CLActivityType.automotiveNavigation
            locationManager.distanceFilter = 1
            locationManager.headingFilter = 1
            locationManager.requestWhenInUseAuthorization()
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopMonitoringLocation() {
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingLocation()
    }
    
    func addCurrentLocationMarker(name: String) {
        currentLocationMarker?.map = nil
        currentLocationMarker = nil
        if let location = locationManager.location {
            currentLocationMarker = GMSMarker(position: location.coordinate)
            currentLocationMarker?.icon = UIImage(named: name)
            currentLocationMarker?.map = myMapView
            currentLocationMarker?.rotation = locationManager.location?.course ?? 0
        }
    }
    
    func zoomToCoordinates(_ coordinates: CLLocationCoordinate2D, zoom: Int) {

        CATransaction.begin()
        CATransaction.setValue(1.0, forKey: kCATransactionAnimationDuration)
        let city = GMSCameraPosition.camera(withLatitude: coordinates.latitude,longitude: coordinates.longitude, zoom: Float(zoom))
        self.myMapView.animate(to: city)
        CATransaction.commit()
        
    }
    
    func delay(_ seconds:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + seconds
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        self.doneButton.setBackgroundColor(color: UIColor.gray, forState: .normal)
//        self.doneButton.isUserInteractionEnabled = false


    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        return true
    }
    

    //    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
    //
    //        let infoWindow: MarkerInfoView = MarkerInfoView.instanceFromNib() as! MarkerInfoView
    //        infoWindow.time.text = "Some text"
    //        infoWindow.nameLabel.text =  "\(marker.position.latitude) \(marker.position.longitude)"
    //        infoWindow.frame = CGRect(x: 0, y: 0, width: 150, height: 35)
    //        return infoWindow
    //    }
    //    func getDistanceMetresBetweenLocationCoordinates(coord1: CLLocationCoordinate2D, coord2: CLLocationCoordinate2D) -> Double {
    //        let location1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
    //        let location2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
    //        return location1.distance(from: location2)
    //    }
    
    
}
