//
//  MXExtensions.swift
//  Oops
//
//  Created by Meniny on 16/04/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation
import UIKit

public extension Oops {
    // Pop Up Styles
    public enum PopUpStyle: String {
        case success = "Success"
        case error = "Error"
        case notice = "Notice"
        case warning = "Warning"
        case info = "Info"
        case editor = "Editor"
        case loading = "Loading"
        case question = "Question"
        
        public var defaultUIntColor: UInt {
            switch self {
            case .success:
                return 0x22B573
            case .error:
                return 0xC1272D
            case .notice:
                return 0x727375
            case .warning:
                return 0xFFD110
            case .info:
                return 0x2866BF
            case .editor:
                return 0xA429FF
            case .loading:
                return 0x3C3C46//0xD62DA5
            case .question:
                return 0x727375
            }   
        }
        
        public var defaultUIColor: UIColor {
            return UIColorFromRGB(defaultUIntColor)
        }
        
        public var defaultButtonTextColor: UIColor {
            switch self {
            case .warning:
                return UIColor.black
            default:
                return UIColor.white
            }
        }
        
        public var icon: UIImage? {
            switch self {
            case .success:
                return Oops.IconPainting.imageOfCheckmark
                
            case .error:
                return Oops.IconPainting.imageOfCross
                
            case .notice:
                return Oops.IconPainting.imageOfNotice
                
            case .warning:
                return Oops.IconPainting.imageOfWarning
                
            case .info:
                return Oops.IconPainting.imageOfInfo
                
            case .editor:
                return Oops.IconPainting.imageOfEditor
                
            case .loading:
                return nil
                
            case .question:
                return Oops.IconPainting.imageOfQuestion
            }
        }
    }
    
    // Animation Styles
    public enum AnimationStyle {
        case none, topToBottom, bottomToTop, leftToRight, rightToLeft
    }
    
    // Action Types
    public enum ActionType {
        case none, selector, closure
    }
    
    public enum ButtonLayout {
        case horizontal, vertical
    }
    
    public typealias DismissClosure = (Swift.Void) -> Swift.Void
    
    public class Configuration {
        
        public class func defaultConfiguration() -> Oops.Configuration {
            return Oops.Configuration()
        }
        
        public var defaultShadowOpacity: CGFloat// = 0.7
        public var circleTopPosition: CGFloat// = 0
        public var circleBackgroundTopPosition: CGFloat// = 6
        public var circleHeight: CGFloat// = 56
        public var circleIconHeight: CGFloat// = 20
        public var titleTop: CGFloat// = 30
        public var titleHeight: CGFloat// = 25
        public var windowWidth: CGFloat// = 240
        public var windowHeight: CGFloat// = 178
        public var textHeight: CGFloat// = 90
        public var textFieldHeight: CGFloat// = 55
        public var textViewdHeight: CGFloat// = 80
        public var buttonHeight: CGFloat// = 40
        public var titleFont: UIFont// = UIFont.systemFont(ofSize: 20)
        public var titleMinimumScaleFactor: CGFloat// = 1
        public var textFont: UIFont// = UIFont.systemFont(ofSize: 14)
        public var buttonFont: UIFont// = UIFont.boldSystemFont(ofSize: 14)
        public var showCloseButton: Bool// = true
        public var showCircularIcon: Bool// = true
        /// Set this false to 'Disable' Auto hideView when Oops.Button is tapped
        public var shouldAutoDismiss: Bool// = true
        public var contentViewCornerRadius: CGFloat// = 5
        public var fieldCornerRadius: CGFloat// = 3
        public var buttonCornerRadius: CGFloat// = 3
        /// Actions
        public var hideWhenBackgroundViewIsTapped: Bool// = false
        public var circleBackgroundColor: UIColor// = UIColor.white
        public var contentViewColor: UIColor// = UIColorFromRGB(kUIntWhite)
        public var contentViewBorderColor: UIColor// = UIColorFromRGB(0xCCCCCC)
        public var titleColor: UIColor// = UIColorFromRGB(0x4D4D4D)
        public var dynamicAnimatorActive: Bool// = false
        public var disableTapGesture: Bool// = false
        public var buttonsLayout: Oops.ButtonLayout// = .vertical
        
        public var optionalButtonColor: UIColor?
        public var optionalButtonTitleColor: UIColor?
        
        public var normalButtonColor: UIColor?
        public var normalButtonTitleColor: UIColor?
        
        public init(defaultShadowOpacity: CGFloat = 0.7,
                    circleTopPosition: CGFloat = 0,
                    circleBackgroundTopPosition: CGFloat = 6,
                    circleHeight: CGFloat = 56,
                    circleIconHeight: CGFloat = 20,
                    titleTop: CGFloat = 30,
                    titleHeight: CGFloat = 25,
                    windowWidth: CGFloat = 240,
                    windowHeight: CGFloat = 178,
                    textHeight: CGFloat = 90,
                    textFieldHeight: CGFloat = 40,
                    textViewdHeight: CGFloat = 80,
                    buttonHeight: CGFloat = 40,
                    titleFont: UIFont = UIFont.systemFont(ofSize: 20),
                    titleMinimumScaleFactor: CGFloat = 1,
                    textFont: UIFont = UIFont.systemFont(ofSize: 14),
                    buttonFont: UIFont = UIFont.boldSystemFont(ofSize: 14),
                    showCloseButton: Bool = true,
                    showCircularIcon: Bool = true,
                    shouldAutoDismiss: Bool = true,
                    contentViewCornerRadius: CGFloat = 5,
                    fieldCornerRadius: CGFloat = 3,
                    buttonCornerRadius: CGFloat = 3,
                    hideWhenBackgroundViewIsTapped: Bool = false,
                    circleBackgroundColor: UIColor = UIColor.white,
                    contentViewColor: UIColor = UIColorFromRGB(kUIntWhite),
                    contentViewBorderColor: UIColor = UIColorFromRGB(0xCCCCCC),
                    titleColor: UIColor = UIColorFromRGB(0x4D4D4D),
                    optionalButtonColor: UIColor? = nil,//UIColor(red:0.45, green:0.45, blue:0.46, alpha:1.00),
                    optionalButtonTitleColor: UIColor? = nil,//UIColor.white,
                    normalButtonColor: UIColor? = nil,//UIColor(red:0.24, green:0.24, blue:0.27, alpha:1.00),
                    normalButtonTitleColor: UIColor? = nil,//UIColor.white,
                    dynamicAnimatorActive: Bool = false,
                    disableTapGesture: Bool = false,
                    buttonsLayout: Oops.ButtonLayout = .vertical) {
            self.defaultShadowOpacity = defaultShadowOpacity
            self.circleTopPosition = circleTopPosition
            self.circleBackgroundTopPosition = circleBackgroundTopPosition
            self.circleHeight = circleHeight
            self.circleIconHeight = circleIconHeight
            self.titleTop = titleTop
            self.titleHeight = titleHeight
            self.windowWidth = windowWidth
            self.windowHeight = windowHeight
            self.textHeight = textHeight
            self.textFieldHeight = textFieldHeight
            self.textViewdHeight = textViewdHeight
            self.buttonHeight = buttonHeight
            self.circleBackgroundColor = circleBackgroundColor
            self.contentViewColor = contentViewColor
            self.contentViewBorderColor = contentViewBorderColor
            self.titleColor = titleColor
            
            self.titleFont = titleFont
            self.titleMinimumScaleFactor = titleMinimumScaleFactor
            self.textFont = textFont
            self.buttonFont = buttonFont
            
            self.disableTapGesture = disableTapGesture
            self.showCloseButton = showCloseButton
            self.showCircularIcon = showCircularIcon
            self.shouldAutoDismiss = shouldAutoDismiss
            self.contentViewCornerRadius = contentViewCornerRadius
            self.fieldCornerRadius = fieldCornerRadius
            self.buttonCornerRadius = buttonCornerRadius
            
            self.hideWhenBackgroundViewIsTapped = hideWhenBackgroundViewIsTapped
            self.dynamicAnimatorActive = dynamicAnimatorActive
            self.buttonsLayout = buttonsLayout
            
            self.normalButtonColor = normalButtonColor
            self.normalButtonTitleColor = normalButtonTitleColor
            self.optionalButtonColor = optionalButtonColor
            self.optionalButtonTitleColor = optionalButtonTitleColor
        }
        
        public func set(windowHeight height: CGFloat) {
            windowHeight = height
        }
        
        public func set(textHeight height: CGFloat) {
            textHeight = height
        }
    }
    
    public struct TimeoutConfiguration {
        
        public typealias ActionClosure = () -> Swift.Void
        
        public var value: TimeInterval
        public let action: Oops.TimeoutConfiguration.ActionClosure
        
        mutating func increaseValue(by: Double) {
            self.value = value + by
        }
        
        public init(timeoutValue: TimeInterval, timeoutAction: @escaping Oops.TimeoutConfiguration.ActionClosure) {
            self.value = timeoutValue
            self.action = timeoutAction
        }
    }
}

public let kUIntWhite: UInt = 0xFFFFFF
public let kUIntBlack: UInt = 0x000000
public let kCircleHeightBackground: CGFloat = 62
public let kUniqueTag: Int = Int(arc4random() % UInt32(Int32.max))
public let kUniqueAccessibilityIdentifier: String = "Oops"


// Helper function to convert from RGB to UIColor
public func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
        blue: CGFloat(rgbValue & 0x0000FF) / 255,
        alpha: CGFloat(1.0)
    )
}

extension Int {
    
    func toUIColor() -> UIColor {
        return UIColor(
            red: CGFloat((self & 0xFF0000) >> 16) / 255,
            green: CGFloat((self & 0x00FF00) >> 8) / 255,
            blue: CGFloat(self & 0x0000FF) / 255,
            alpha: CGFloat(1.0)
        )
    }
    
    func toCGColor() -> CGColor {
        return self.toUIColor().cgColor
    }
}

extension UInt {
    
    func toUIColor() -> UIColor {
        return UIColor(
            red: CGFloat((self & 0xFF0000) >> 16) / 255,
            green: CGFloat((self & 0x00FF00) >> 8) / 255,
            blue: CGFloat(self & 0x0000FF) / 255,
            alpha: CGFloat(1.0)
        )
    }
    
    func toCGColor() -> CGColor {
        return self.toUIColor().cgColor
    }
}

extension String {
    
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
}
