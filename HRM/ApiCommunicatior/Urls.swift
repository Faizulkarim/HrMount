//
//  Urls.swift
//  ezzyride-app-ios
//
//  Created by Riajur Rahman on 25/4/17.
//  Copyright © 2017 WebAlive. All rights reserved.
//

import Foundation

class Urls: NSObject {
    
    static var BASE_URL = "http://api-hrm.ezzyr.xyz/v1"
    //static var BASE_URL = "http://13.127.60.179/v1"
    
    static var BOOKING_BASE_URL = "http://13.127.60.179/mp1"
    //static var BOOKING_BASE_URL = "http://services.ezzyr.com/mp1"

    
    static var SETTING_MAIN_URL = "/settings-main"
    static var CHECK_COMPANY = "/checkCompanyCode"
    static var ATTENDACE = "/attendance/store"
    static var LOGIN_URL = "/login"
    static var ATTEDDANCE_LIST = "/attendance/list"
    static var REQUEST_FOR_ATTENDENCE_RECONCILIATION = "/attendance/reconciliation"
    static var RECONCILIATION_LIST = "/attendance/reconciliation"
    static var REQUEST_FOR_LEAVE = "/leave/store"
    static var LEAVE_TYPE = "/leave/typeList"
    static var LEAVE_LIST  = "/leave/application"
    static var EMPLOYE_LIST = "/employee/list"
    static var NOTICE = "/notice"
    static var SALARY = "/salary"
    static var HOLIDAY_C = "/holiday"
    static var CLAIM = "/claim"
    static var USER_PROFILE_URL = "/profile"
    static var UPLOAD_PROFILE_IMAGE_URL = "/profile/upload/profileImage"


    // GOOGLE MAP API
    static var GOOGLE_MAP_GEOGOCE_BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json?"
    static var GOOGLE_MAP_DIRECTION_API_BASE_URL = "https://maps.googleapis.com/maps/api/directions/json?"
    static var GOOGLE_PLACES_SEARCH_API_BASE_URL = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
    static var GOOGLE_MAP_DISTANCE_MATRIX_API_BASE_URL = "https://maps.googleapis.com/maps/api/distancematrix/json?"
    
    // URL ENCODED KEYS
    static var ORIGIN_KEY = "origin="
    static var DESTINATION_KEY = "&destination="
    static var API_KEY = "&mode=driving&key="
    static var QUERY_KEY = "query="
    static var REGION_KEY = "&region="
    static var REGION_VALUE = "BD"
    static var PLACES_API_KEY = "&key="
    static var UNITS_KEY = "units="
    static var UNIT_VALUE_IN_KILOMETERS = "metric"
    static var UNIT_VALUE_IN_MILES = "imperial"
    static var AND = "&"
    
    
    /// menu url
    
    static var menuUrl = "http://partner.ezzyr.com"
}





