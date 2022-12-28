//
//  Constants.swift
//  ezzyride-app-ios
//
//  Created by Riajur Rahman on 11/4/17.
//  Copyright © 2017 Bitmascot. All rights reserved.
//

import Foundation

class Constants: NSObject {
    
    // Status Code
    static var STATUS_CODE_SUCCESS = 200
    static var NO_DATA_FOUND = 204
    static var VALIDATION_ERROR = 422
    static var UNAUTHORIZE_AGENT = 401
    
    static var SUCCESS_STATUS_CODE = 200
    static var CREATED_STATUS_CODE = 201
    static var SUCCESS_IMAGE_UPLOAD_STATUS_CODE = 201
    static var FAILED_STATUS_CODE = 500
    static var ERROR_STATUS_CODE = 409
    static var OTHERS_ERROR_STATUS_CODE = 400
    
    static var STATUS_OK = 1
    static var STATUS_FAILED = 0
    
    static var RESZIE_IMAGE_WIDTH = 500.0
    static var RESZIE_IMAGE_HEIGHT = 500.0
    
    static var MAP_API_STATUS_OK = "OK"
    
    static var USER_AUTH_CODE = ""
    
    // Constant Keys
    
    static var EMAIL = "email"
    static var FULLNAME = "name"
    static var ROLE = "role"
    static var ID = "id"
    static var DOB = "dob"
    
    static var COMPANY_DATA = "company_data"
    static var FONT_NAME_GOTHAM = "HelveticaNeue-Medium"
    static var USER_INFO = "userinfo"
    static var PROFILE_INFO = "profile_info"
    static var EMPLOYEE_LIST = "employee_list"
    static var ACCESS_TOKEN = "access_token"
    static var ALLAPPLICATION_LIST = "all_application"
    
    static var MEMBER_ID = "member_id"
    static var MEMBER_TYPE = "member_type"
    static var USER_ID = "user_id"
    static var STAGE_DATA = "stage_data"
    static var COMPANY_ID = "Company_id"
 
    
    static var TRIP_ID = "trip_id"
    static var DRIVER_ID = "driver_id"
    static var FCM_TOKEN = "fcm_token"
    static var DRIVER_CHENNAL = "CH"
    static var DRIVER_LAST_LAT = ""
    static var DRIVER_LAST_LNG = ""
    static var TOTAL_NOTIFICATION = ""
    
    static var HEADER_KEY = "Authorization"
    static var HEADER_PARTIAL_VALUE = "Bearer"
    static var LIMIT = 50
    static var ORDER_ASC = "ASC"
    static var ORDER_DESC = "DESC"
    static var SEPARATED_BY_COMA = ","
    
    static var FIRST_TIME_INSTALLATION_KEY = "first_time_installation"
    
    static var SETTINGS_API_KEY = "ecab0c41580367d2da02de37fff03f76ab096769b76b74e665ae834c58e310b1"
    static var IOS_PASSENGER_APP_KEY = "android_passenger_app"
    static var IOS_PASSENGER_APP_UPDATE_TYPE_KEY = "android_passenger_app_update_type"
    static var IOS_PASSENGER_APP_VERSION_CODE_KEY = "android_passenger_app_version_code"
    static var IOS_PASSENGER_APP_TRIP_CANCEL_TEXT_KEY = "passenger_app_trip_cancel_text"
    static var IOS_EZZYR_HELP_LINE_KEY = "ezzyr_help_line"
    static var IOS_TERMS_IMAGE_KEY = "terms_img"
    static var AMBULANCE_TERM_IMAGE = "ambulance_terms_img"
    static var IOS_LOCATION_KEY = "Bangladesh|Dhaka"
    static var IOS_ZONE_DATA_KEY = "zone_data"
    static var IOS_SERVICE_DATA_KEY = "service_data"
    
    static var GOOGLE_MAP_API_KEY = "AIzaSyDy-ZKFgEMWVUxLH70qA70s5lH_qdAeIh8" // AIzaSyBT-ehPrBviK4QBCs3nzI0zIyQejFp9iWw
    static var PUBNUB_PUBLISH_KEY = "pub-c-afab05e6-231c-45a7-9ec5-e0d6bbbd50b3"
    static var PUBNUB_SUB_KEY = "sub-c-886c158e-cf78-11e6-b045-02ee2ddab7fe"
    
    //Messages.
    
    static var USERNAME_PASSWORD_MISSING = "Username or Password missing."
    static var SOMETHING_WENT_WRONG = "Auth Failed"
    static var WRONG_USERNAME_PASSWORD = "Wrong username or password."
    static var INVALID_EMAIL_ADDRESS = "Invalid email address."
    static var MISSING_MANDATORY_FIELD = "Missing mandatory fields."
    static var PASSWORD_MISMATCH = "New & confirm password mismatch."
    static var PASSWORD_CHANGE_SUCCESS_MESSAGE = "Password is changed successfully."
    static var NO_DATA_FOUND_MESSAGE = "No data found."
    static var NOT_APPLICABLE_MESSAGE = "N/A"
    static var RESET_PASSWORD_MSG = "Password is reseted successfully. Please check your email!"
    static var INVALID_PHONE_NUMBER_MESSAGE = "Invalid contact number"
    static var INVALID_AUTH_CODE = "Invalid authentication code"
    static var PASSWORD_DID_NOT_MATCH = "Password didn't match."
    
    static var CREATE_SUCCESS_MSG = "Create successfully."
    static var UPDATE_SUCCESS_MSG = "Update successfully."
    
    static var LOCATION_MANAGER_INACTIVE_MESSAGE = "Location Services is not enabled"
    static var LOCATION_SERVICE_ACCESS_DENIED = "Location Services access denied. Please go to Settings > Privacy > Location Services: Manually enable it for Ezzyr."
    
    
    // Menu item name
    
    static var menuItem  = ["Home","My Attendance","Leave Balance","Notice","Profile","Holiday","Logout"]
    static var menuItemImage = ["home","My-Attendance","Leave-Balance","Notice","Profile","Leave-Calender","Logout"]

}








