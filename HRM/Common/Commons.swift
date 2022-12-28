//
//  Commons.swift
//  ezzyride-app-ios
//
//  Created by Riajur Rahman on 18/4/17.
//  Copyright © 2017 Bitmascot. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

open class Commons: NSObject {
    
    static func makeCardView(view: UIView) -> UIView {
        
        view.layer.masksToBounds = false
        view.backgroundColor = .clear
        view.roundCornersForView(corners: [.topLeft, .bottomRight], radius: 35)
        view.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 0.5
        view.layer.shadowOpacity = 0.3
        view.layer.borderColor = Commons.colorWithHexString("FF7711").cgColor
        view.layer.borderWidth = 3
        return view
    }
   static func newAttrSize(blockQuote: NSAttributedString) -> NSAttributedString
    {
        let yourAttrStr = NSMutableAttributedString(attributedString: blockQuote)
        yourAttrStr.enumerateAttribute(.font, in: NSMakeRange(0, yourAttrStr.length), options: .init(rawValue: 0)) {
            (value, range, stop) in
            if let font = value as? UIFont {
                let resizedFont = font.withSize(font.pointSize * 1.45)
                yourAttrStr.addAttribute(.font, value: resizedFont, range: range)
            }
        }
        
        return yourAttrStr
    }
    
    static func destroyData(){
        Helpers.removeValue(Constants.PROFILE_INFO)
        Helpers.removeValue(Constants.USER_ID)
        Helpers.removeValue(Constants.EMPLOYEE_LIST)
    }
    static func makeCircularFloatingView(view: UIView) -> UIView {
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = view.frame.size.width / 2.0
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.1
        return view
    }

    
    static func colorWithHexString (_ hex:String) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
                 
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    static func getLeftRightView(_ imageName: String) -> UIView {
                
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        
        let view = UIView()
        view.addSubview(imageView)
        
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageView.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        
        return view
    }
    
    static func userExist() -> Bool {

        let userExist = Helpers.getStringValueForKey(Constants.EMAIL)
        if userExist.count > 0 {
            return true
        }
        return false
    }
    
    static func getFormattedDate(_ date: Date, format: String) -> String {
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        let result = formatter.string(from: date)
        
        return result
    }

   static func diffrenceDate(currentDate: Date, picDate: Date ) -> String{
        let difference = Calendar.current.dateComponents([.hour, .minute], from: currentDate, to: picDate)
        let formattedString = String(format: "%02ld%02ld", difference.hour!, difference.minute!)
        return formattedString
    }
    static func calculateTime(currentDate: Date, createdDate: Date ) -> String{
        let difference = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: createdDate, to: currentDate)
        let formattedString = String(format: "%02ld%02ld", difference.day!, difference.hour!, difference.minute!)
        var timeString = ""
        
        if difference.minute != 0 {
            timeString = "\(String(describing: difference.minute!)) minute"
        }
        if difference.hour != 0 {
            timeString = "\(String(describing: difference.hour!)) hours \(String(describing: difference.minute!)) minute"
        }
        if difference.day != 0 {
            timeString = "\(String(describing: difference.day!)) Day  \(String(describing: difference.hour!)) hours"
        }
        if difference.month != 0 {
            timeString = "\(String(describing: difference.month!)) Month \(String(describing: difference.day!)) Day"
        }
        return timeString
    }
    static func diffrenceDay(currentDate: Date, picDate: Date ) -> String{
        let difference = Calendar.current.dateComponents([.day], from: currentDate, to: picDate)
        let formattedString = String(difference.day!)
        return formattedString
    }
    static func getLocalDate(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    static func getDate(_ dateString: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: dateString)!
        return date
    }
    
    static func isDateInRange(_ startDate: Date, endDate: Date) -> Bool {
        let currentDate = Date()
        if currentDate >= startDate && currentDate <= endDate {
            return true
        }
        return false
    }
    
    static func changeDateFormat(_ dateString: String, curformat: String, desiredFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = curformat
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = desiredFormat
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
    
    static func convertDateToString(dateString: String, FomatedString: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-mm-dd HH:mm:ss"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FomatedString
       
        
        let date: Date? = dateFormatterGet.date(from: dateString)
        
        return dateFormatter.string(from: date!)
    }
    static func convertDate(dateString: String, FomatedString: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-mm-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FomatedString
       
        
        let date: Date? = dateFormatterGet.date(from: dateString)
        
        return dateFormatter.string(from: date!)
    }


    static func changeTimeFormat(_ timeString: String, curformat: String, desiredFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = curformat
        let times = dateFormatter.date(from: timeString)
        dateFormatter.dateFormat = desiredFormat
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let time = dateFormatter.string(from: times!)
        return time
    }
    
    static func getStringToDate(_ dateString: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        let date = formatter.date(from: dateString)!
        return date
    }
    static func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-mm-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
    static func getDateInAmPmFormat(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy HH:mm:ss"

        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func getEmptyDataMessage(_ delegate: AnyObject?) -> UILabel {
        
        if let view = delegate?.view {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (view.bounds.size.width), height: (view.bounds.size.height)))
            messageLabel.text = "No referrals found."
            messageLabel.textColor = Commons.colorWithHexString(Colors.DISSELECTED_TEXT_COLOR)
            messageLabel.textAlignment = NSTextAlignment.center
            messageLabel.numberOfLines = 0
            messageLabel.font = UIFont.systemFont(ofSize: 16)
            
            return messageLabel
        }
        return UILabel()
    }
    
    static func getEmptyMessage(_ delegate: AnyObject?, message: String) -> UILabel {
        
        if let view = delegate?.view {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (view.bounds.size.width), height: (view.bounds.size.height)))
            messageLabel.text = message
            messageLabel.textColor = Commons.colorWithHexString(Colors.DISSELECTED_TEXT_COLOR)
            messageLabel.textAlignment = NSTextAlignment.center
            messageLabel.numberOfLines = 0
            messageLabel.font = UIFont.systemFont(ofSize: 16)
            
            return messageLabel
        }
        return UILabel()
    }
    
    static func getUnderConstructionMessage(_ delegate: AnyObject?) -> UILabel {
        
        if let view = delegate?.view {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (view.bounds.size.width), height: (view.bounds.size.height)))
            messageLabel.text = "This Feature is Under Construction!!!"
            messageLabel.textColor = Commons.colorWithHexString(Colors.DISSELECTED_TEXT_COLOR)
            messageLabel.textAlignment = NSTextAlignment.center
            messageLabel.numberOfLines = 0
            messageLabel.font = UIFont(name: Constants.FONT_NAME_GOTHAM, size: 16.0)
            
            return messageLabel
        }
        return UILabel()
    }
    
    static func getValue(_ value: String?) -> String {
        
        let result = (value ?? "").isEmpty ? "" : value!
        return result
    }
    
    static func getDelay() -> DispatchTime {
        let when = DispatchTime.now() + 0.5
        return when
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    static func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        
        let size = image.size
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func configNavBar() {
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = colorWithHexString("#1EA2CB")
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().clipsToBounds = false
        UINavigationBar.appearance().backgroundColor = colorWithHexString("#1EA2CB")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    static func removeSavedParams() {
        
    }
    static func wordToRemove(sentence: String, word: String) -> String {
      
        var currentSentence = sentence
        currentSentence = (sentence.components(separatedBy: NSCharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
        let wordToRemove = word
        
        
        if let range = currentSentence.range(of: wordToRemove) {
            currentSentence.removeSubrange(range)
        }
        let string2 = currentSentence.replacingOccurrences(of: "/", with: "")
        let retrunValue = string2.replacingOccurrences(of: " ", with: "")
        let removeUnnamedRouad = retrunValue.replacingOccurrences(of: "", with: "")
        let retrunValueFinal = retrunValue.replacingOccurrences(of: "'", with: "")
        return retrunValueFinal
    }
    
    static func paddingViewWithImage(_ iconName: String, textField: UITextField) -> UIView {
        
        let iconWidth = 20
        let iconHeight = 20
        
        let imageView = UIImageView()
        let imageEmail = UIImage(named: iconName)
        imageView.image = imageEmail
        
        imageView.frame = CGRect(x: 0, y: 5, width: iconWidth, height: iconHeight)
        textField.leftViewMode = UITextField.ViewMode.always
        textField.addSubview(imageView)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: textField.frame.height))
        return paddingView
    }
    
    static func swiftyJSONArrayToString(_ jsonArray: [JSON], key: String) -> String {
        var object = [String: [JSON]]()
        object[key] = jsonArray
        let result = JSON(object)
        if let resultString = result.rawString() {
            return resultString
        }
        return ""
    }
    
    static func stringToSwiftyJSONArray(_ resultString: String, key: String) -> [JSON] {
        let emptyArray: [JSON] = [JSON]()
        let result = JSON.init(parseJSON: resultString)
        if let jsonArray = result[key].array {
            return jsonArray
        }
        return emptyArray
    }
    
    static func getDeviceId() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }

    func placeHolderColorChange(TextFild: UITextField, PlaceHolder: String){
        TextFild.attributedPlaceholder = NSAttributedString(string: PlaceHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
 
    }
    
    static func bottomCornerRedious(button: UIButton, cornerRedious: Int){
        button.layer.cornerRadius = CGFloat(cornerRedious)
        button.layer.masksToBounds = true
        
    }
    
    func labelCornerRedious(label: UILabel, cornerRedious: Int){
        label.layer.cornerRadius = CGFloat(cornerRedious)
        label.layer.masksToBounds = true
    }
    
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func jsonToNSData(json: AnyObject) -> NSData?{
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
    
    
    
    
//    static func loadDivision(_ divisionName: String) -> Division? {
//        
//        if let division = Bundle.main.path(forResource: divisionName, ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: division), options: .alwaysMapped)
//                let divisionJSON = try JSON(data: data)
//                if !divisionJSON.isEmpty {
//                    let divisionModel = convertJsonToModel(divisionJSON)
//                    return divisionModel
//                }
//                
//            } catch let error {
//                print("parse error: \(error.localizedDescription)")
//            }
//        } else {
//            print("Invalid filename/path.")
//        }
//        return nil
//    }
    
   /* static func convertJsonToModel(_ json: JSON) -> Division {
        
        let division = Division()
        if let geoDivision = json["division"].string {
            division.division = geoDivision
        }
        if let city_count = json["city_count"].int {
            division.cityCount = city_count
        }
        if let geojson = json["geojson"].array {
            var zones = [Zone]()
            for i in 0..<geojson.count {
                let zone = Zone()
                if let geoObject = geojson[i].dictionary {
                    if let geoZone = geoObject["zone"]?.string {
                        zone.zone = geoZone
                    }
                    if let city_count = geoObject["city_count"]?.int {
                        zone.cityCount = city_count
                    }
                    if let geoCoordinate = geoObject["coordinate"]?.dictionary {
                        let baseCoordinate = BaseCoordinate()
                        if let type = geoCoordinate["type"]?.string {
                            baseCoordinate.type = type
                        }
                        if let source = geoCoordinate["source"]?.string {
                            baseCoordinate.source = source
                        }
                        if let geoFeatures = geoCoordinate["features"]?.array {
                            var features = [Feature]()
                            for j in 0..<geoFeatures.count {
                                if let geoFeatureObject = geoFeatures[j].dictionary {
                                    let feature = Feature()
                                    if let type = geoFeatureObject["type"]?.string {
                                        feature.type = type
                                    }
                                    if let geoGeometry = geoFeatureObject["geometry"]?.dictionary {
                                        let geometry = Geometry()
                                        if let type = geoGeometry["type"]?.string {
                                            geometry.type = type
                                        }
                                        if let geoCoordinates = geoGeometry["coordinates"]?.array {
                                            var coordinateList = [Coordinates]()
                                            for k in 0..<geoCoordinates.count {
                                                if let geoCoordinateItem = geoCoordinates[k].array {
                                                    var coordinates = [Coordinate]()
                                                    for l in 0..<geoCoordinateItem.count {
                                                        let coordinate = Coordinate()
                                                        if let singleGeoCoordinate = geoCoordinateItem[l].array {
                                                            if singleGeoCoordinate.count == 2 {
                                                                if let lat = singleGeoCoordinate[0].double {
                                                                    coordinate.latitude = String(lat)
                                                                }
                                                                if let lon = singleGeoCoordinate[1].double {
                                                                    coordinate.longitude = String(lon)
                                                                }
                                                            }
                                                            coordinates.append(coordinate)
                                                        }
                                                    }
                                                    let singleCoordinates = Coordinates(coordinateList: coordinates)
                                                    coordinateList.append(singleCoordinates)
                                                }
                                            }
                                            geometry.coordinates = coordinateList
                                        }
                                        feature.geometry = geometry
                                    }
                                    if let properties = geoFeatureObject["properties"]?.dictionary {
                                        let property = Property()
                                        if let style = properties["style"]?.string {
                                            property.style = style
                                        }
                                        feature.properties = property
                                    }
                                    features.append(feature)
                                }
                            }
                            baseCoordinate.features = features
                        }
                        zone.coordinate = baseCoordinate
                    }
                    
                    if let geoSubZone = geoObject["geojson"]?.array {
                        var subZones = [SubZone]()
                        for n in 0..<geoSubZone.count {
                            if let singleGeoSubZone = geoSubZone[n].dictionary {
                                let subZone = SubZone()
                                if let sub_zone = singleGeoSubZone["sub_zone"]?.string {
                                    subZone.sub_zone = sub_zone
                                }
                                if let geoCoordinate = singleGeoSubZone["coordinate"]?.dictionary {
                                    let baseCoordinate = BaseCoordinate()
                                    if let type = geoCoordinate["type"]?.string {
                                        baseCoordinate.type = type
                                    }
                                    if let source = geoCoordinate["source"]?.string {
                                        baseCoordinate.source = source
                                    }
                                    if let geoFeatures = geoCoordinate["features"]?.array {
                                        var features = [Feature]()
                                        for j in 0..<geoFeatures.count {
                                            if let geoFeatureObject = geoFeatures[j].dictionary {
                                                let feature = Feature()
                                                if let type = geoFeatureObject["type"]?.string {
                                                    feature.type = type
                                                }
                                                if let geoGeometry = geoFeatureObject["geometry"]?.dictionary {
                                                    let geometry = Geometry()
                                                    if let type = geoGeometry["type"]?.string {
                                                        geometry.type = type
                                                    }
                                                    if let geoCoordinates = geoGeometry["coordinates"]?.array {
                                                        var coordinateList = [Coordinates]()
                                                        for k in 0..<geoCoordinates.count {
                                                            if let geoCoordinateItem = geoCoordinates[k].array {
                                                                var coordinates = [Coordinate]()
                                                                for l in 0..<geoCoordinateItem.count {
                                                                    let coordinate = Coordinate()
                                                                    if let singleGeoCoordinate = geoCoordinateItem[l].array {
                                                                        if singleGeoCoordinate.count == 2 {
                                                                            if let lat = singleGeoCoordinate[0].double {
                                                                                coordinate.latitude = String(lat)
                                                                            }
                                                                            if let lon = singleGeoCoordinate[1].double {
                                                                                coordinate.longitude = String(lon)
                                                                            }
                                                                        }
                                                                        coordinates.append(coordinate)
                                                                    }
                                                                }
                                                                let singleCoordinates = Coordinates(coordinateList: coordinates)
                                                                coordinateList.append(singleCoordinates)
                                                            }
                                                        }
                                                        geometry.coordinates = coordinateList
                                                    }
                                                    feature.geometry = geometry
                                                }
                                                if let properties = geoFeatureObject["properties"]?.dictionary {
                                                    let property = Property()
                                                    if let style = properties["style"]?.string {
                                                        property.style = style
                                                    }
                                                    feature.properties = property
                                                }
                                                features.append(feature)
                                            }
                                        }
                                        baseCoordinate.features = features
                                    }
                                    subZone.coordinate = baseCoordinate
                                }
                                subZones.append(subZone)
                            }
                        }
                        zone.subZones = subZones
                    }
                }
                zones.append(zone)
            }
            division.zones = zones
        }
        return division
    }*/
    
    static func getDistanceInMeters(_ origin: String, destination: String) -> Double {
        
        let breakOriginIntoParts: [String] = origin.components(separatedBy: ",")
        let breakDestinationIntoParts: [String] = destination.components(separatedBy: ",")
        
        if breakOriginIntoParts.count > 0 && breakDestinationIntoParts.count > 0 {
            let originLat = Double(breakOriginIntoParts[0])
            let originLon = Double(breakOriginIntoParts[1])
            let originCoordinates = CLLocationCoordinate2D(latitude: originLat!, longitude: originLon!)
            
            let destinationLat = Double(breakDestinationIntoParts[0])
            let destinationLon = Double(breakDestinationIntoParts[1])
            let destinationCoordinates = CLLocationCoordinate2D(latitude: destinationLat!, longitude: destinationLon!)
            
            let originCoord = CLLocation(latitude: originCoordinates.latitude, longitude: originCoordinates.longitude)
            let destionationCoord = CLLocation(latitude: destinationCoordinates.latitude, longitude: destinationCoordinates.longitude)
            let distanceInMeters = originCoord.distance(from: destionationCoord)
            return distanceInMeters
        }
        return 0.0
    }
}


















