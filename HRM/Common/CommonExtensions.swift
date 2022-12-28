//
//  CommonExtensions.swift
//  ezzyride-app-ios
//
//  Created by Riajur Rahman on 21/5/17.
//  Copyright © 2017 WebAlive. All rights reserved.
//

import Foundation
import UIKit

enum Priority: Int {
    
    case First = 1,
    Second,
    Third,
    Fourth,
    Fifth
}

enum LoginType: Int {
    
    case AppLogin = 1,
    GoogleLogin,
    FacebookLogin,
    GuestLogin
}

enum UserType: Int {
    
    case One = 1,
    Two,
    Three,
    Four
}

extension NSDate {
    var localTime: String {
        return description(with: NSLocale.current)
    }
}

extension UITextField {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UITextField {
    
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = Commons.colorWithHexString(Colors.TEXTFIELD_BOTTOM_BORDER_COLOR).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func setBottomBorder(_ color: String) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func setBottomBorderNoShadow() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = Commons.colorWithHexString("#F1F1F1").cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension UIImage{
    func toBase64() -> String{
        let imageData = self.pngData()
        return (imageData?.base64EncodedString())!
    }
    
    
}

extension String {
    
    func convertHTML() -> NSAttributedString {
        
        guard let data = self.data(using: .utf8) else {
            return NSAttributedString()
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
        
            return NSAttributedString()
        }
       

     
        return attributedString
    }
    

   
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func isValidEmail(address: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: address)
    }
    
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
        
        
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        print(matches)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    func doSms(){
        if isValid(regex: .phone) {
            guard let url = URL(string: "sms://\(self.onlyDigits())") else { return }
            if let _ = URL(string: "sms://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url){
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    func doMakeAPhoneCall() {
        if isValid(regex: .phone) {
            guard let url = URL(string: "tel://\(self.onlyDigits())") else { return }
            if let _ = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    func doMakeAUnCheckPhoneCall() {
        //if isValid(regex: .phone) {
        guard let url = URL(string: "tel://\(self.onlyDigits())") else { return }
        if let _ = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        //}
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%f",self)
    }
}

extension Notification.Name {
    static let pushPayload = Notification.Name(rawValue: "pushPayload")
}

extension UIAlertController {
    
    func changeFont(view: UIView, font:UIFont) {
        for item in view.subviews {
            if item.isKind(of: UICollectionView.self) {
                let col = item as! UICollectionView
                for  row in col.subviews{
                    changeFont(view: row, font: font)
                }
            }
            if item.isKind(of: UILabel.self) {
                let label = item as! UILabel
                label.font = font
            }else {
                changeFont(view: item, font: font)
            }
        }
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let font = UIFont.systemFont(ofSize: 15)
        changeFont(view: self.view, font: font )
    }
}

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}
extension UIView {
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }

    func roundCornersForView(corners:UIRectCorner, radius: CGFloat) {
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }


    func animSupport(){
        UIView.animate(withDuration: 0.80, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        print(self.center.y)
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animShow(){
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        print(self.center.y)
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
    
    func setCardView(view : UIView){
        
        view.layer.cornerRadius = 5.0
        view.layer.borderColor  =  UIColor.clear.cgColor
        view.layer.borderWidth = 5.0
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor =  UIColor.lightGray.cgColor
        view.layer.shadowRadius = 5.0
        view.layer.shadowOffset = CGSize(width:5, height: 5)
        view.layer.masksToBounds = true
        
    }
    func setShadow(){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.8
     
       
    }
    

}
extension UITableView {
    func tableShow(){
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        print(self.center.y)
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func tableHide(){
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
}

extension UIButton {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
    
    func swing() {
        let animation = CAKeyframeAnimation()
        let relativeStart = 1.0/3.0
        let relativeEnd   = 2.0/3.0
        let duration      = 1.0
        let innerDuration = duration / (relativeEnd - relativeStart) // 3 seconds
        // configure the "complete" animation
     
        animation.duration = innerDuration
        animation.timeOffset = relativeStart * innerDuration
        let group = CAAnimationGroup()
        group.animations = [animation]
        group.duration = duration
        group.repeatCount = HUGE
        group.autoreverses = true
        group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: "easeInEaseOut"))
        
        layer.add(animation, forKey: nil)
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}
extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}



extension UIAlertController {
    
    func addImage(image: UIImage){
        let maxSize = CGSize(width: 138, height: 72)
        let imgsize = image.size
        
        var ratio: CGFloat!
        if (imgsize.width > imgsize.height){
            ratio = maxSize.width / imgsize.width
        }else {
            ratio = maxSize.height / imgsize.height
        }
        let scaledSize = CGSize(width: imgsize.width * ratio, height: imgsize.height * ratio)
        //let resiezeImage = image.imageWithSize(_size: scaledSize)
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
//        imgAction.setValue(resiezeImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        imgAction.setValue(image, forKey: "image")
        self.addAction(imgAction)
    }
    
}

extension UIImage {
    func imageWithSize(_size: CGSize) -> UIImage {
        var scaledImageRect = CGRect.zero
        let aspectWidth: CGFloat = size.width / self.size.width
        let aspectHeight: CGFloat = size.height / self.size.height
        let aspectRation: CGFloat = min(aspectWidth, aspectHeight)
        scaledImageRect.size.width = self.size.width * aspectRation
        scaledImageRect.size.height = self.size.height * aspectRation
        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
}
extension UIApplication {
    
    class var topViewController: UIViewController? {
        return getTopViewController()
    }
    
    private class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

extension Equatable {
    func share() {
        let activity = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        UIApplication.topViewController?.present(activity, animated: true, completion: nil)
    }
}

extension StringProtocol where Index == String.Index {
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}

