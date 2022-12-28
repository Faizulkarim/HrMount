//
//  SelfAttendanceController.swift
//  HRM
//
//  Created by Innovadeaus on 3/7/19.
//  Copyright © 2019 Innovadeaus. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Kingfisher
import SwiftyJSON
import GooglePlaces

class SelfAttendanceController: BaseController,GMSMapViewDelegate {
    @IBOutlet weak var myMapView: GMSMapView!
    @IBOutlet weak var textView: UITextView!
    var locationManager: CLLocationManager!
    var currentLocationMarker: GMSMarker?
    var attendanceService : AttendanceService?
    var apiCommunicatorHelper: APICommunicator?
    var geocoder = GMSGeocoder()
    
    var lastLocationLatLng = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.clipsToBounds = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Commons.colorWithHexString("FF7711").cgColor
        initGoogleMap()
        initGester()
        initApiCommunicatorHelper()
        // Do any additional setup after loading the view.
    }
    func initApiCommunicatorHelper() {
        apiCommunicatorHelper = APICommunicator(view: self.view)
        apiCommunicatorHelper?.delegate = self
        attendanceService = AttendanceService(self.view, communicator: apiCommunicatorHelper!)
        
    }
    func initGoogleMap(){
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.myMapView.isMyLocationEnabled = true
        self.myMapView.delegate = self
        var region:GMSVisibleRegion = GMSVisibleRegion()
        region.nearLeft = CLLocationCoordinate2DMake(26.633914, 92.6801153)
        region.farRight = CLLocationCoordinate2DMake(20.3794,88.00861410000002)
        let bounds = GMSCoordinateBounds(coordinate: region.nearLeft,coordinate: region.farRight)
        let camera = myMapView.camera(for: bounds, insets:UIEdgeInsets.zero)
        myMapView.camera = camera!;
        
        /// var mycamera = GMSCameraPosition.camera(withTarget: bounds, zoom: 6)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func getAddressForLiveLocation(Location: CLLocationCoordinate2D? , type: Int){
        geocoder.reverseGeocodeCoordinate(Location!)  { response, error in
            if error != nil {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            } else {
                if let places = response?.results() {
                    if let place = places.first {
                        if let lines = place.lines {
                            self.doAttendace(type: type, locationName: lines[0])
                            
                        }
                    } else {
                        print("GEOCODE: nil first in places")
                    }
                } else {
                    print("GEOCODE: nil in places")
                }
            }
        }
    }
    
    func initGester(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToNextItem(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToNextItem(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    @objc func moveToNextItem(_ sender:UISwipeGestureRecognizer) {
        switch sender.direction{
        case .left:
            if isOpen == true {
                showAndHide()
            }
        case .right:
            if isOpen == false {
                showAndHide()
            }
            
        default: break //default
        }
        
    }
    
    @IBAction func menuShow(_ sender: Any) {
        showAndHide()
    }
    
    @IBAction func inTime(_ sender: Any) {
    
       getAddressForLiveLocation(Location: lastLocationLatLng, type: 0)
    }
    
    @IBAction func outTime(_ sender: Any) {
    getAddressForLiveLocation(Location: lastLocationLatLng, type: 1)
    }
    func doAttendace(type: Int, locationName: String){
        
        let params = [
            "lat": "\(lastLocationLatLng.latitude)",
            "lng": "\(lastLocationLatLng.longitude)",
            "location_name": "\(locationName)",
            "type": "\(type)"
            
        ]
        attendanceService?.doAttendance(params)
        print(params)
    }
    func getAttendanceResponse(_ data: [String: Any], statusCode: Int) {
        
        if statusCode == Constants.STATUS_CODE_SUCCESS {
            let response = JSON(data)
            print(response)

            if !response.isEmpty {
                if let success = response["success"].bool {
                    if success == true {
                        if let msg = response ["msg"].string {
                            let popup = CustomAlertPopup.customOkayPopup("", msgBody: msg)
                            self.present(popup, animated: true, completion: nil)
                            
                        }
                    }else{
                        if let reson = response["msg"].string {
                            let popup = CustomAlertPopup.customOkayPopup("", msgBody: reson)
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        else {
            //need to handle
        }
    }
    


}

extension SelfAttendanceController: APICommunicatorDelegate {
    
    func taskCompletationHandler(_ methodTag: Int, data: Dictionary<String, Any>, statusCode: Int) {
        if methodTag == MethodTags.FIRST {
            getAttendanceResponse(data, statusCode: statusCode)
        }
        
    }
}

