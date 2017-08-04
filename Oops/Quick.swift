//
//  Alert.swift
//  Joyup
//
//  Created by Meniny on 2017-05-11.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import Foundation
import UIKit

internal func OopsLocalized(_ key: String?) -> String {
    if let key = key {
        return NSLocalizedString(key, comment: "")
    }
    return ""
}

internal func OopsLocalizedTitle(_ style: Oops.PopUpStyle) -> String {
    return OopsLocalized(style.rawValue)
}

public typealias OopsOptionsClosure = (_ index: Int, _ alert: Oops) -> Swift.Void

public extension Oops {
    
    public static func showDebug(style: Oops.PopUpStyle,
                                 message: String?,
                                 title: String? = nil,
                                 icon: UIImage? = nil,
                                 buttons: [String]? = nil,
                                 close: String? = nil,
                                 configuration: Oops.Configuration? = nil,
                                 action: OopsOptionsClosure? = nil) {
        #if DEBUG
            showOops(message,
                     title: title != nil ? OopsLocalized(title!) : OopsLocalized("DEBUG"),
                     icon: icon,
                     buttons: buttons ?? [],
                     close: close,
                     style: style,
                     configuration: configuration,
                     useCustomTheme: false,
                     action: action)
        #endif
    }
    
    @discardableResult
    public static func showWarning(_ message: String?,
                                 title: String? = nil,
                                 icon: UIImage? = nil,
                                 buttons: [String]? = nil,
                                 close: String? = nil,
                                 configuration: Oops.Configuration? = nil,
                                 action: OopsOptionsClosure? = nil) -> Oops {
        return self.showOops(message,
                         title: title ?? OopsLocalizedTitle(.warning),
                         icon: icon,
                         buttons: buttons ?? [],
                         close: close,
                         style: .warning,
                         action: action)
    }
    
    @discardableResult
    public static func showError(_ message: String?,
                                 title: String? = nil,
                                 icon: UIImage? = nil,
                                 buttons: [String]? = nil,
                                 close: String? = nil,
                                 configuration: Oops.Configuration? = nil,
                                 action: OopsOptionsClosure? = nil) -> Oops {
        return self.showOops(message,
                         title: title ?? OopsLocalizedTitle(.error),
                         icon: icon,
                         buttons: buttons ?? [],
                         close: close,
                         style: .error,
                         configuration: configuration,
                         action: action)
    }
    
    @discardableResult
    public static func showMessage(_ message: String?,
                                   title: String? = nil,
                                   icon: UIImage? = nil,
                                   buttons: [String]? = nil,
                                   close: String? = nil,
                                   configuration: Oops.Configuration? = nil,
                                   action: OopsOptionsClosure? = nil) -> Oops {
        return self.showOops(message,
                         title: title ?? OopsLocalizedTitle(.info),
                         icon: icon,
                         buttons: buttons ?? [],
                         close: close,
                         style: .info,
                         action: action)
    }
    
    @discardableResult
    public static func showSuccess(_ message: String?,
                                   title: String? = nil,
                                   icon: UIImage? = nil,
                                   buttons: [String]? = nil,
                                   close: String? = nil,
                                   configuration: Oops.Configuration? = nil,
                                   action: OopsOptionsClosure? = nil) -> Oops {
        return self.showOops(message,
                         title: title ?? OopsLocalizedTitle(.success),
                         icon: icon,
                         buttons: buttons ?? [],
                         close: close,
                         style: .success,
                         configuration: configuration,
                         action: action)
    }
    
    @discardableResult
    public static func showLoading(_ message: String?,
                                 title: String? = nil,
                                 icon: UIImage? = nil,
                                 cancel: Bool = false,
                                 configuration: Oops.Configuration? = nil,
                                 onCancel: (() -> Void)? = nil) -> Oops {
        let config = configuration ?? Oops.Configuration()
        config.shouldAutoDismiss = true//false
        config.showCloseButton = false
        let notice = Oops(configuration: config)
        
        if cancel {
            notice.addButton(OopsLocalized("Cancel"), action: onCancel ?? {})
        }
        notice.circleView.clipsToBounds = false
        notice.circleIconView?.clipsToBounds = false
        
        notice.show(.loading,
                    title: title != nil ? OopsLocalized(title!) : OopsLocalizedTitle(.loading),
                    detail: message != nil ? OopsLocalized(message!) : "",
                    icon: icon,
                    color: nil,
                    buttonTitleColor: nil,
                    completeText: nil,
                    timeout: nil,
                    animation: .topToBottom)
        return notice
    }
    
    @discardableResult
    public static func showInfo(_ message: String?,
                                  title: String? = nil,
                                  icon: UIImage? = nil,
                                  buttons: [String]? = nil,
                                  close: String? = nil,
                                  configuration: Oops.Configuration? = nil,
                                  action: OopsOptionsClosure? = nil) -> Oops {
        return self.showOops(message,
                         title: title,
                         icon: icon,
                         buttons: buttons ?? [],
                         close: close,
                         style: .info,
                         configuration: configuration,
                         action: action)
    }
    
    @discardableResult
    public static func showNotice(_ message: String?,
                                 title: String? = nil,
                                 icon: UIImage? = nil,
                                 buttons: [String]? = nil,
                                 close: String? = nil,
                                 configuration: Oops.Configuration? = nil,
                                 action: OopsOptionsClosure? = nil) -> Oops {
        return self.showOops(message,
                         title: title,
                         icon: icon,
                         buttons: buttons ?? [],
                         close: close,
                         style: .notice,
                         configuration: configuration,
                         action: action)
    }
    
    @discardableResult
    public static func showOptions(_ message: String?,
                                  title: String?,
                                  icon: UIImage? = nil,
                                  options: [String],
                                  close: String? = nil,
                                  configuration: Oops.Configuration? = nil,
                                  action: @escaping OopsOptionsClosure) -> Oops {
        return self.showOops(message,
                         title: title,
                         icon: icon,
                         buttons: options,
                         close: close,
                         style: .question,
                         configuration: configuration,
                         action: action)
    }
    
    @discardableResult
    public static func showConfirm(_ message: String?,
                                   title: String,
                                   icon: UIImage? = nil,
                                   leftButton: String?,
                                   leftAction: (() -> Swift.Void)?,
                                   rightButton: String? = nil,
                                   rightAction: (() -> Swift.Void)? = nil) -> Oops {
        let config = Oops.Configuration()
        config.buttonsLayout = .horizontal
        
        let buttons = [leftButton ?? OopsLocalized("Done"), rightButton ?? OopsLocalized("Cancel")]
        return showOops(message,
                        title: title,
                        icon: icon,
                        buttons: buttons,
                        close: nil,
                        style: .question,
                        configuration: config,
                        useCustomTheme: false) { (idx, oops) in
                            if idx == 0 {
                                leftAction?()
                            } else {
                                rightAction?()
                            }
        }
    }
    
    @discardableResult
    public static func showOops(_ message: String?,
                                     title: String? = nil,
                                     icon: UIImage? = nil,
                                     buttons: [String] = [],
                                     close: String? = nil,
                                     style: Oops.PopUpStyle = .info,
                                     configuration: Oops.Configuration? = nil,
                                     useCustomTheme: Bool = false,
                                     action: OopsOptionsClosure? = nil) -> Oops {
        let config = configuration ?? Oops.Configuration()
        config.shouldAutoDismiss = false
        config.showCloseButton = false
        let notice = Oops(configuration: config)
        
        for t in buttons {
            notice.addButton(OopsLocalized(t),
                             backgroundColor: useCustomTheme ? config.normalButtonColor : style.defaultUIColor,
                             textColor: useCustomTheme ? config.normalButtonTitleColor : style.defaultButtonTextColor,
                             showTimeout: nil) {
                action?(buttons.index(of: t) ?? 0, notice)
            }
        }
        
        if close != nil || buttons.isEmpty {
            notice.addButton(OopsLocalized(close ?? "Done"),
                             backgroundColor: useCustomTheme ? config.optionalButtonColor : style.defaultUIColor,
                             textColor: useCustomTheme ? config.optionalButtonTitleColor : style.defaultButtonTextColor,
                             showTimeout: nil) {
                action?(buttons.count + 1, notice)
                notice.hideView()
            }
        }
        
        notice.show(style,
                    title: title != nil ? OopsLocalized(title!) : OopsLocalizedTitle(style),
                    detail: message != nil ? OopsLocalized(message!) : "",
                    icon: icon,
                    color: useCustomTheme ? config.optionalButtonColor : style.defaultUIColor,
                    buttonTitleColor: nil,
                    completeText: nil,
                    timeout: nil,
                    animation: .topToBottom)
        return notice
    }
}

public extension Oops {

    public class func errorTextFieldAnimation(_ fields: [UITextField]) {
        var orginal = [CGColor]()
        for t in fields {
            orginal.append(t.layer.borderColor ?? UIColor.clear.cgColor)
            t.layer.borderColor = UIColor.red.cgColor
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            for t in fields {
                t.layer.borderColor = orginal[fields.index(of: t)!]
            }
        }
    }
    
    public class func errorTextViewAnimation(_ textViews: [UITextView]) {
        var orginal = [CGColor]()
        for t in textViews {
            orginal.append(t.layer.borderColor ?? UIColor.clear.cgColor)
            t.layer.borderColor = UIColor.red.cgColor
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            for t in textViews {
                t.layer.borderColor = orginal[textViews.index(of: t)!]
            }
        }
    }
}
