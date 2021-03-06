//
//  Oops.swift
//  Oops
//
//  Created by Meniny on 6/5/16.
//  Copyright (c) 2016 Meniny. All rights reserved.
//

import Foundation
import UIKit

fileprivate func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

// The Main Class
open class Oops: UIViewController {
    
    var configuration: Oops.Configuration!
    
    // UI Colour
    var viewColor = UIColor.white
    
    // UI Options
    open var iconTintColor: UIColor?
    open var customSubview : UIView?
    
    // Members declaration
    var baseView = UIView()
    public private(set) var labelTitle = UILabel()
    public private(set) var viewText = UITextView()
    
    open var titleText: String? {
        get {
            return labelTitle.text
        }
        set {
            labelTitle.text = newValue
        }
    }
    
    open var detailText: String {
        get {
            return viewText.text
        }
        set {
            viewText.text = newValue
        }
    }
    
    var contentView = UIView()
    var circleBG = UIView(frame: CGRect(x: 0, y: 0, width: kCircleHeightBackground, height: kCircleHeightBackground))
    var circleView = UIView()
    var circleIconView : UIView?
    public private(set) var timeout: Oops.TimeoutConfiguration?
    var showTimeoutTimer: Timer?
    var timeoutTimer: Timer?
    var dismissAction : Oops.DismissClosure?
    public private(set) var textFields: [UITextField] = []
    public private(set) var textViews: [UITextView] = []
    public private(set) var buttons: [Oops.Button] = []
    fileprivate var selfReference: Oops?
    
    // MARK: - Initializer
    
    public init(configuration: Oops.Configuration) {
        self.configuration = configuration
        super.init(nibName:nil, bundle:nil)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
//        configuration = Oops.Configuration()
//        super.init(coder: aDecoder)
//        setup()
    }
    
    required public init() {
        configuration = Oops.Configuration()
        super.init(nibName:nil, bundle:nil)
        setup()
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        configuration = Oops.Configuration()
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
//        setup()
    }
    
    // MARK: - Configuration & Layout
    
    fileprivate func setup() {
        // Set up main view
        view.frame = UIScreen.main.bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:configuration.defaultShadowOpacity)
        view.addSubview(baseView)
        // Base View
        baseView.frame = view.frame
        baseView.addSubview(contentView)
        // Content View
        contentView.layer.cornerRadius = configuration.contentViewCornerRadius
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.addSubview(labelTitle)
        contentView.addSubview(viewText)
        // Circle View
        circleBG.backgroundColor = configuration.circleBackgroundColor
        circleBG.layer.cornerRadius = circleBG.frame.size.height / 2
        baseView.addSubview(circleBG)
        circleBG.addSubview(circleView)
        let x = (kCircleHeightBackground - configuration.circleHeight) / 2
        circleView.frame = CGRect(x: x,
                                  y: x + configuration.circleTopPosition,
                                  width:configuration.circleHeight,
                                  height:configuration.circleHeight)
        circleView.layer.cornerRadius = circleView.frame.size.height / 2
        // Title
        labelTitle.numberOfLines = 0
        labelTitle.textAlignment = .center
        labelTitle.font = configuration.titleFont
        if(configuration.titleMinimumScaleFactor < 1){
            labelTitle.minimumScaleFactor = configuration.titleMinimumScaleFactor
            labelTitle.adjustsFontSizeToFitWidth = true
        }
        labelTitle.frame = CGRect(x:12, y: configuration.titleTop, width: configuration.windowWidth - 24, height:configuration.titleHeight)
        // View text
        viewText.isEditable = false
        viewText.textAlignment = .center
        viewText.textContainerInset = UIEdgeInsets.zero
        viewText.textContainer.lineFragmentPadding = 0;
        viewText.font = configuration.textFont
        // Colours
        contentView.backgroundColor = configuration.contentViewColor
        viewText.backgroundColor = configuration.contentViewColor
        labelTitle.textColor = configuration.titleColor
        viewText.textColor = configuration.titleColor
        contentView.layer.borderColor = configuration.contentViewBorderColor.cgColor
        //Gesture Recognizer for tapping outside the texttextViews
        if configuration.disableTapGesture == false {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Oops.tapped(_:)))
            tapGesture.numberOfTapsRequired = 1
            self.view.addGestureRecognizer(tapGesture)
        }
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let rv = UIApplication.shared.keyWindow! as UIWindow
        let sz = rv.frame.size
        
        // Set background frame
        view.frame.size = sz
        let vMargin: CGFloat = 8
        let hMargin: CGFloat = 12
        let defaultTopOffset: CGFloat = 32
        
        // get actual height of title text
        var titleActualHeight: CGFloat = 0
        if let title = labelTitle.text {
            titleActualHeight = title.heightWithConstrainedWidth(configuration.windowWidth - hMargin * 2, font: labelTitle.font) + 10
            // get the larger height for the title text
            titleActualHeight = (titleActualHeight > configuration.titleHeight ? titleActualHeight : configuration.titleHeight)
        }
        
        // computing the right size to use for the textView
        let maxHeight = sz.height - 100 // max overall height
        var consumedHeight = CGFloat(0)
        consumedHeight += (titleActualHeight > 0 ? configuration.titleTop + titleActualHeight : defaultTopOffset)
        consumedHeight += 14
        
        if configuration.buttonsLayout == .vertical {
            consumedHeight += (configuration.buttonHeight + vMargin) * CGFloat(buttons.count)
        } else {
            consumedHeight += configuration.buttonHeight + vMargin
        }
        consumedHeight += (configuration.textFieldHeight + vMargin) * CGFloat(textFields.count)
        consumedHeight += (configuration.textViewdHeight + vMargin) * CGFloat(textViews.count)
        let maxViewTextHeight = maxHeight - consumedHeight
        let viewTextWidth = configuration.windowWidth - hMargin * 2
        var viewTextHeight = configuration.textHeight
        
        // Check if there is a custom subview and add it over the textview
        if let customSubview = customSubview {
            viewTextHeight = min(customSubview.frame.height, maxViewTextHeight)
            viewText.text = ""
            viewText.addSubview(customSubview)
        } else {
            // computing the right size to use for the textView
            let suggestedViewTextSize = viewText.sizeThatFits(CGSize(width: viewTextWidth, height: CGFloat.greatestFiniteMagnitude))
            viewTextHeight = min(suggestedViewTextSize.height, maxViewTextHeight)
            
            // scroll management
            if (suggestedViewTextSize.height > maxViewTextHeight) {
                viewText.isScrollEnabled = true
            } else {
                viewText.isScrollEnabled = false
            }
        }
        
        let windowHeight = consumedHeight + viewTextHeight
        // Set frames
        var x = (sz.width - configuration.windowWidth) / 2
        var y = (sz.height - windowHeight - (configuration.circleHeight / 8)) / 2
        contentView.frame = CGRect(x: x, y: y, width:configuration.windowWidth, height: windowHeight)
        contentView.layer.cornerRadius = configuration.contentViewCornerRadius
        y -= kCircleHeightBackground * 0.6
        x = (sz.width - kCircleHeightBackground) / 2
        circleBG.frame = CGRect(x: x, y: y + configuration.circleBackgroundTopPosition, width: kCircleHeightBackground, height:kCircleHeightBackground)
        
        //adjust Title frame based on circularIcon show/hide flag
        //        let titleOffset : CGFloat = configuration.showCircularIcon ? 0.0 : -12.0
        let titleOffset: CGFloat = 0
        labelTitle.frame = labelTitle.frame.offsetBy(dx: 0, dy: titleOffset)
        
        // Subtitle
        y = titleActualHeight > 0 ? configuration.titleTop + titleActualHeight + titleOffset : defaultTopOffset
        viewText.frame = CGRect(x: hMargin, y: y, width: configuration.windowWidth - hMargin * 2, height: configuration.textHeight)
        viewText.frame = CGRect(x: hMargin, y: y, width: viewTextWidth, height:viewTextHeight)
        // Text fields
        y += viewTextHeight + 14.0
        for txt in textFields {
            txt.frame = CGRect(x: hMargin, y: y, width: configuration.windowWidth - hMargin * 2, height: configuration.textFieldHeight)
            txt.layer.cornerRadius = configuration.fieldCornerRadius
            y += configuration.textFieldHeight
            y += vMargin
        }
        for txt in textViews {
            txt.frame = CGRect(x: hMargin, y: y, width: configuration.windowWidth - hMargin * 2, height: configuration.textViewdHeight)
            //txt.layer.cornerRadius = fieldCornerRadius
            y += configuration.textViewdHeight
            y += vMargin
        }
        
        // Buttons
        var buttonX: CGFloat = hMargin
        let numberOfButton = CGFloat(buttons.count)
        let buttonsSpace: CGFloat = numberOfButton > 1 ? (vMargin * (numberOfButton - 1)) : 0
        let widthEachButton = (configuration.windowWidth - hMargin * 2 - buttonsSpace) / numberOfButton
        
        switch configuration.buttonsLayout {
        case .vertical:
            for btn in buttons {
                btn.frame = CGRect(x: buttonX, y: y, width:configuration.windowWidth - 24, height: configuration.buttonHeight)
                btn.layer.cornerRadius = configuration.buttonCornerRadius
                y += configuration.buttonHeight
                y += vMargin
            }
        case .horizontal:
            for btn in buttons {
                btn.frame = CGRect(x: buttonX, y: y, width: widthEachButton, height: configuration.buttonHeight)
                btn.layer.cornerRadius = configuration.buttonCornerRadius
                buttonX += widthEachButton
                buttonX += vMargin
            }
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(Oops.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(Oops.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event:UIEvent?) {
        if event?.touches(for: view)?.count > 0 {
            view.endEditing(true)
        }
    }
    
    // MARK: - Adding UI Components
    
    /// Add a `UITextField` to Oops
    ///
    /// - Parameters:
    ///   - placeholder: Placeholder string, default is nil
    ///   - text: Text string, default is nil
    ///   - secure: Secure text entry, default is false
    ///   - capitalization: Autocapitalization type, defailt is none
    /// - Returns: `UITextField` object
    @discardableResult
    open func addTextField(_ placeholder: String? = nil, text: String? = nil, secure: Bool = false, capitalization: UITextAutocapitalizationType = .none) -> UITextField {
        // Update view height
        configuration.set(windowHeight: configuration.windowHeight + configuration.textFieldHeight)
        // Add text field
        let txt = UITextField(frame: CGRect(x: 0, y: 0, width: configuration.windowWidth - 24, height: configuration.textFieldHeight))
        txt.isSecureTextEntry = secure
        txt.borderStyle = UITextBorderStyle.roundedRect
        txt.font = configuration.textFont
        txt.autocapitalizationType = capitalization
        txt.clearButtonMode = UITextFieldViewMode.whileEditing
        txt.layer.masksToBounds = true
        txt.layer.borderWidth = 1.0
        if let t = text {
            txt.text = t
        }
        if let ph = placeholder {
            txt.placeholder = ph
        }
        contentView.addSubview(txt)
        textFields.append(txt)
        return txt
    }
    
    /// Add a `UITextView` to Oops
    ///
    /// - Parameter text: Text string, default is nil
    /// - Returns: `UITextView` object
    @discardableResult
    open func addTextView(text: String? = nil) -> UITextView {
        // Update view height
        configuration.set(windowHeight: configuration.windowHeight + configuration.textViewdHeight)
        // Add text view
        let txt = UITextView()
        txt.text = text ?? ""
        // No placeholder with UITextView but you can use KMPlaceholderTextView library
        txt.font = configuration.textFont
        //txt.autocapitalizationType = UITextAutocapitalizationType.Words
        //txt.clearButtonMode = UITextFieldViewMode.WhileEditing
        txt.layer.masksToBounds = true
        txt.layer.borderWidth = 1.0
        contentView.addSubview(txt)
        textViews.append(txt)
        return txt
    }
    
    /// Add a `Oops.Button` to Oops
    ///
    /// - Parameters:
    ///   - title: Title string
    ///   - backgroundColor: Background color, default is nil
    ///   - textColor: Title color, default is nil
    ///   - showTimeout: Timeout options, default is nil
    ///   - action: Action closure
    /// - Returns: `Oops.Button` object
    @discardableResult
    open func addButton(_ title: String,
                        backgroundColor: UIColor? = nil,
                        textColor: UIColor? = nil,
                        font: UIFont? = nil,
                        showTimeout: Oops.Button.ShowTimeoutConfiguration? = nil,
                        action: @escaping () -> Void) -> Oops.Button {
        let btn = addButton(title, backgroundColor: backgroundColor, textColor: textColor, font: font, showTimeout: showTimeout)
        btn.actionType = Oops.ActionType.closure
        btn.action = action
        btn.addTarget(self, action: #selector(Oops.buttonTapped(_:)), for:.touchUpInside)
        btn.addTarget(self, action: #selector(Oops.buttonTapDown(_:)), for:[.touchDown, .touchDragEnter])
        btn.addTarget(self, action: #selector(Oops.buttonRelease(_:)), for:[.touchUpInside, .touchUpOutside, .touchCancel, .touchDragOutside] )
        return btn
    }
    
    /// Add a `Oops.Button` to Oops
    ///
    /// - Parameters:
    ///   - title: Title string
    ///   - backgroundColor: Background color, default is nil
    ///   - textColor: Title color, default is nil
    ///   - showTimeout: Timeout options, default is nil
    ///   - target: Action `Selector` target
    ///   - selector: Action `Selector` object
    /// - Returns: `Oops.Button` object
    @discardableResult
    open func addButton(_ title: String,
                        backgroundColor: UIColor? = nil,
                        textColor: UIColor? = nil,
                        font: UIFont? = nil,
                        showTimeout: Oops.Button.ShowTimeoutConfiguration? = nil,
                        target: AnyObject,
                        selector: Selector) -> Oops.Button {
        let btn = addButton(title, backgroundColor: backgroundColor, textColor: textColor, font: font, showTimeout: showTimeout)
        btn.actionType = Oops.ActionType.selector
        btn.target = target
        btn.selector = selector
        btn.addTarget(self, action: #selector(Oops.buttonTapped(_:)), for:.touchUpInside)
        btn.addTarget(self, action: #selector(Oops.buttonTapDown(_:)), for:[.touchDown, .touchDragEnter])
        btn.addTarget(self, action: #selector(Oops.buttonRelease(_:)), for:[.touchUpInside, .touchUpOutside, .touchCancel, .touchDragOutside] )
        return btn
    }
    
    // MARK: - Internal & Private Functions
    
    @discardableResult
    fileprivate func addButton(_ title: String,
                               backgroundColor: UIColor? = nil,
                               textColor: UIColor? = nil,
                               font: UIFont? = nil,
                               showTimeout: Oops.Button.ShowTimeoutConfiguration? = nil) -> Oops.Button {
        // Update view height
        configuration.set(windowHeight: configuration.windowHeight + configuration.buttonHeight)
        // Add button
        let btn = Oops.Button()
        btn.layer.masksToBounds = true
        btn.setTitle(title, for: UIControlState())
        btn.titleLabel?.font = font ?? configuration.buttonFont
        btn.customBackgroundColor = backgroundColor
        btn.customTextColor = textColor
        btn.initialTitle = title
        btn.showTimeout = showTimeout
        contentView.addSubview(btn)
        buttons.append(btn)
        return btn
    }
    
    func buttonTapped(_ btn: Oops.Button) {
        if btn.actionType == Oops.ActionType.closure {
            btn.action()
        } else if btn.actionType == Oops.ActionType.selector {
            let ctrl = UIControl()
            ctrl.sendAction(btn.selector, to:btn.target, for:nil)
        } else {
            print("Unknow action type for button")
        }
        
        if self.view.alpha != 0 && configuration.shouldAutoDismiss {
            hideView()
        }
    }
    
    
    func buttonTapDown(_ btn: Oops.Button) {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        let pressBrightnessFactor = 0.85
        btn.backgroundColor?.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        brightness = brightness * CGFloat(pressBrightnessFactor)
        btn.backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    func buttonRelease(_ btn: Oops.Button) {
        btn.backgroundColor = btn.customBackgroundColor ?? viewColor
    }
    
    var tmpContentViewFrameOrigin: CGPoint?
    var tmpCircleViewFrameOrigin: CGPoint?
    var keyboardHasBeenShown:Bool = false
    
    func keyboardWillShow(_ notification: Notification) {
        keyboardHasBeenShown = true
        
        guard let userInfo = (notification as NSNotification).userInfo else {return}
        guard let endKeyBoardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.minY else {return}
        
        if tmpContentViewFrameOrigin == nil {
            tmpContentViewFrameOrigin = self.contentView.frame.origin
        }
        
        if tmpCircleViewFrameOrigin == nil {
            tmpCircleViewFrameOrigin = self.circleBG.frame.origin
        }
        
        var newContentViewFrameY = self.contentView.frame.maxY - endKeyBoardFrame
        if newContentViewFrameY < 0 {
            newContentViewFrameY = 0
        }
        let newBallViewFrameY = self.circleBG.frame.origin.y - newContentViewFrameY
        self.contentView.frame.origin.y -= newContentViewFrameY
        self.circleBG.frame.origin.y = newBallViewFrameY
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if(keyboardHasBeenShown){//This could happen on the simulator (keyboard will be hidden)
            if(self.tmpContentViewFrameOrigin != nil){
                self.contentView.frame.origin.y = self.tmpContentViewFrameOrigin!.y
                self.tmpContentViewFrameOrigin = nil
            }
            if(self.tmpCircleViewFrameOrigin != nil){
                self.circleBG.frame.origin.y = self.tmpCircleViewFrameOrigin!.y
                self.tmpCircleViewFrameOrigin = nil
            }
            
            keyboardHasBeenShown = false
        }
    }
    
    //Dismiss keyboard when tapped outside textfield & close Oops when hideWhenBackgroundViewIsTapped
    func tapped(_ gestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        if let tappedView = gestureRecognizer.view , tappedView.hitTest(gestureRecognizer.location(in: tappedView), with: nil) == baseView && configuration.hideWhenBackgroundViewIsTapped {
            
            hideView()
        }
    }
    
    // MARK: - Showing Alert View
    
    /// Show `Oops`
    ///
    /// - Parameters:
    ///   - style: Pop up style, setup this to config the default title, icon, color, etc.
    ///   - title: Title string, set to `nil` to use default title
    ///   - detail: Detail String
    ///   - icon: Custom icon image, set to `nil` to use default icon
    ///   - mainColor: custom color, set to `nil` to use default color
    ///   - buttonTitleColor: Button title color, set to `nil` to use default color
    ///   - completeText: Close button title string, set to `nil` to use default title
    ///   - configuration: Custom `Oops` configuration, set to `nil` to use default configuration
    ///   - timeout: Timeout Options, default is `nil`
    ///   - animation: Animation Style, default is `.topToBottom`
    /// - Returns: `Oops` Object
    @discardableResult
    open class func show(_ style: Oops.PopUpStyle,
                   title: String?,
                   detail: String,
                   icon: UIImage? = nil,
                   color mainColor: UIColor? = nil,
                   buttonTitleColor: UIColor? = nil,
                   completeText: String? = nil,
                   configuration: Oops.Configuration? = nil,
                   timeout: Oops.TimeoutConfiguration? = nil,
                   animation: Oops.AnimationStyle = .topToBottom) -> Oops {
        let alert = (configuration != nil) ? Oops(configuration: configuration!) : Oops()
        return alert.show(style,
                          title: title,
                          detail: detail,
                          icon: icon,
                          color: mainColor,
                          buttonTitleColor: buttonTitleColor,
                          completeText: completeText,
                          timeout: timeout,
                          animation: animation)
    }
    
    /// Show `Oops`
    ///
    /// - Parameters:
    ///   - style: Pop up style, setup this to config the default title, icon, color, etc.
    ///   - title: Title string, set to `nil` to use default title
    ///   - detail: Detail String
    ///   - icon: Custom icon image, set to `nil` to use default icon
    ///   - mainColor: custom color, set to `nil` to use default color
    ///   - buttonTitleColor: Button title color, set to `nil` to use default color
    ///   - completeText: Close button title string, set to `nil` to use default title
    ///   - timeout: Timeout Options, default is `nil`
    ///   - animation: Animation Style, default is `.topToBottom`
    /// - Returns: `Oops` Object
    @discardableResult
    open func show(_ style: Oops.PopUpStyle,
                   title: String?,
                   detail: String,
                   icon: UIImage? = nil,
                   color mainColor: UIColor? = nil,
                   buttonTitleColor: UIColor? = nil,
                   completeText: String? = nil,
                   timeout: Oops.TimeoutConfiguration? = nil,
                   animation: Oops.AnimationStyle = .topToBottom) -> Oops {
        selfReference = self
        view.alpha = 0
        view.tag = kUniqueTag
        view.accessibilityIdentifier = kUniqueAccessibilityIdentifier
        guard let rv = UIApplication.shared.keyWindow else {
            fatalError("unexpectedly found nil while unwrapping UIApplication.shared.keyWindow")
//            return self
        }
        rv.addSubview(view)
        view.frame = rv.bounds
        baseView.frame = rv.bounds
        
        // Alert colour/icon
        viewColor =  mainColor ?? style.defaultUIColor
        let iconImage: UIImage? = (style == .loading) ? nil : checkCircleIconImage(icon, defaultImage: style.icon!)
        
        // Title
        let titleString = title ?? style.rawValue
        if !titleString.isEmpty {
            self.labelTitle.text =  titleString
            let actualHeight = titleString.heightWithConstrainedWidth(configuration.windowWidth - 24, font: self.labelTitle.font)
            self.labelTitle.frame = CGRect(x:12, y:configuration.titleTop, width: configuration.windowWidth - 24, height:actualHeight)
        }
        
        // Detail
        if !detail.isEmpty {
            viewText.text = detail
            // Adjust text view size, if necessary
            let str = detail as NSString
            let attr = [NSFontAttributeName:viewText.font ?? UIFont()]
            let sz = CGSize(width: configuration.windowWidth - 24, height:90)
            let r = str.boundingRect(with: sz, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attr, context:nil)
            let ht = ceil(r.size.height)
            if ht < configuration.textHeight {
                configuration.windowHeight -= (configuration.textHeight - ht)
                configuration.set(textHeight: ht)
            }
        }
        
        // Done button
        if configuration.showCloseButton {
            addButton(NSLocalizedString(completeText ?? "Done", comment: ""),
                      target: self,
                      selector: #selector(Oops.hideView))
        }
        
        //hidden/show circular view based on the ui option
        circleView.isHidden = !configuration.showCircularIcon
        circleBG.isHidden = !configuration.showCircularIcon
        
        // Alert view colour and images
        circleView.backgroundColor = viewColor
        // Spinner / icon
        if style == .loading {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            indicator.startAnimating()
            circleIconView = indicator
            circleIconView?.clipsToBounds = false
            circleView.clipsToBounds = false
            circleBG.clipsToBounds =  false
        } else {
            if let iconTintColor = iconTintColor {
                circleIconView = UIImageView(image: iconImage!.withRenderingMode(.alwaysTemplate))
                circleIconView?.tintColor = iconTintColor
            } else {
                circleIconView = UIImageView(image: iconImage!)
            }
            if circleIconView is UIImageView {
               (circleIconView as! UIImageView).contentMode = .scaleAspectFill
            }
            circleIconView?.clipsToBounds = true
        }
        circleView.addSubview(circleIconView!)
        let x = (configuration.circleHeight - configuration.circleIconHeight) / 2
        if circleIconView is UIImageView {
            if configuration.circleIconHeight >= configuration.circleHeight {
                circleIconView?.layer.cornerRadius = configuration.circleHeight * 0.5
            }
        }
        circleIconView!.frame = CGRect( x: x, y: x, width: configuration.circleIconHeight, height: configuration.circleIconHeight)
        
        circleIconView?.layer.masksToBounds = true
        
        for txt in textFields {
            txt.layer.borderColor = viewColor.cgColor
        }
        
        for txt in textViews {
            txt.layer.borderColor = viewColor.cgColor
        }
        
        for btn in buttons {
            if let customBackgroundColor = btn.customBackgroundColor {
                // Custom BackgroundColor set
                btn.backgroundColor = customBackgroundColor
            } else {
                // Use default BackgroundColor derived from AlertStyle
                if let bc = mainColor {
                    btn.backgroundColor = bc
                } else {
                    if btn.isOptionalButton {
                        btn.backgroundColor = configuration.optionalButtonColor ?? viewColor
                    } else {
                        btn.backgroundColor = configuration.normalButtonColor ?? viewColor
                    }
                }
            }
            
            if let customTextColor = btn.customTextColor {
                // Custom TextColor set
                btn.setTitleColor(customTextColor, for: UIControlState())
            } else {
                // Use default BackgroundColor derived from AlertStyle
                if let btc = buttonTitleColor {
                    btn.setTitleColor(btc, for: .normal)
                } else {
                    if btn.isOptionalButton {
                        btn.setTitleColor(configuration.optionalButtonTitleColor ?? UIColor.white, for: .normal)
                    } else {
                        btn.setTitleColor(configuration.normalButtonTitleColor ?? UIColor.white, for: .normal)
                    }
                }
            }
        }
        
        // Adding timeout
        if let timeout = timeout {
            self.timeout = timeout
            timeoutTimer?.invalidate()
            timeoutTimer = Timer.scheduledTimer(timeInterval: timeout.value, target: self, selector: #selector(Oops.hideViewTimeout), userInfo: nil, repeats: false)
            showTimeoutTimer?.invalidate()
            showTimeoutTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(Oops.updateShowTimeout), userInfo: nil, repeats: true)
        }
        
        // Animate in the alert view
        self.showAnimation(animation)
        
        return self
    }
    
    // MARK: - Internal & Private Functions (Showing/Hiding/Animating)
    
    // Show animation in the alert view
    fileprivate func showAnimation(_ animation: Oops.AnimationStyle = .topToBottom, animationStartOffset: CGFloat = -400.0, boundingAnimationOffset: CGFloat = 15.0, animationDuration: TimeInterval = 0.2) {
        
        let rv = UIApplication.shared.keyWindow! as UIWindow
        var animationStartOrigin = self.baseView.frame.origin
        var animationCenter : CGPoint = rv.center
        
        switch animation {
            
        case .none:
            self.view.alpha = 1.0
            return;
            
        case .topToBottom:
            animationStartOrigin = CGPoint(x: animationStartOrigin.x, y: self.baseView.frame.origin.y + animationStartOffset)
            animationCenter = CGPoint(x: animationCenter.x, y: animationCenter.y + boundingAnimationOffset)
            
        case .bottomToTop:
            animationStartOrigin = CGPoint(x: animationStartOrigin.x, y: self.baseView.frame.origin.y - animationStartOffset)
            animationCenter = CGPoint(x: animationCenter.x, y: animationCenter.y - boundingAnimationOffset)
            
        case .leftToRight:
            animationStartOrigin = CGPoint(x: self.baseView.frame.origin.x + animationStartOffset, y: animationStartOrigin.y)
            animationCenter = CGPoint(x: animationCenter.x + boundingAnimationOffset, y: animationCenter.y)
            
        case .rightToLeft:
            animationStartOrigin = CGPoint(x: self.baseView.frame.origin.x - animationStartOffset, y: animationStartOrigin.y)
            animationCenter = CGPoint(x: animationCenter.x - boundingAnimationOffset, y: animationCenter.y)
        }
        
        self.baseView.frame.origin = animationStartOrigin
        
        if self.configuration.dynamicAnimatorActive {
            UIView.animate(withDuration: animationDuration, animations: {
                self.view.alpha = 1.0
            })
            self.animate(item: self.baseView, center: rv.center)
        } else {
            UIView.animate(withDuration: animationDuration, animations: {
                self.view.alpha = 1.0
                self.baseView.center = animationCenter
            }, completion: { finished in
                UIView.animate(withDuration: animationDuration, animations: {
                    self.view.alpha = 1.0
                    self.baseView.center = rv.center
                })
            })
        }
    }
    
    // DynamicAnimator function
    var animator : UIDynamicAnimator?
    var snapBehavior : UISnapBehavior?
    
    fileprivate func animate(item : UIView , center: CGPoint) {
        
        if let snapBehavior = self.snapBehavior {
            self.animator?.removeBehavior(snapBehavior)
        }
        
        self.animator = UIDynamicAnimator.init(referenceView: self.view)
        let tempSnapBehavior  =  UISnapBehavior.init(item: item, snapTo: center)
        self.animator?.addBehavior(tempSnapBehavior)
        self.snapBehavior? = tempSnapBehavior
    }
    
    //
    open func updateShowTimeout() {
        
        guard let timeout = self.timeout else {
            return
        }
        
        self.timeout?.value = timeout.value.advanced(by: -1)
        
        for btn in buttons {
            guard let showTimeout = btn.showTimeout else {
                continue
            }
            
            let timeoutStr: String = showTimeout.prefix + String(Int(timeout.value)) + showTimeout.suffix
            let txt = String(btn.initialTitle) + " " + timeoutStr
            btn.setTitle(txt, for: UIControlState())
            
        }
        
    }
    
    // Close Oops
    open func hideView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
        }, completion: { finished in
            
            // Stop timeoutTimer so alertView does not attempt to hide itself and fire it's dimiss block a second time when close button is tapped
            self.timeoutTimer?.invalidate()
            
            // Stop showTimeoutTimer
            self.showTimeoutTimer?.invalidate()
            
            if let d = self.dismissAction {
                // Call completion handler when the alert is dismissed
                d()
            }
            
            // This is necessary for Oops to be de-initialized, preventing a strong reference cycle with the viewcontroller calling Oops.
            for button in self.buttons {
                button.action = nil
                button.target = nil
                button.selector = nil
            }
            
            self.view.removeFromSuperview()
            self.selfReference = nil
        })
    }
    
    open func hideViewTimeout() {
        self.timeout?.action()
        self.hideView()
    }
    
    func checkCircleIconImage(_ circleIconImage: UIImage?, defaultImage: UIImage) -> UIImage {
        if let image = circleIconImage {
            return image
        } else {
            return defaultImage
        }
    }
    
    //Return true if a Oops is already being shown, false otherwise
    open func isShowing() -> Bool {
        if let subviews = UIApplication.shared.keyWindow?.subviews {
            for view in subviews {
                if view.tag == kUniqueTag &&
                    view.accessibilityIdentifier == kUniqueAccessibilityIdentifier {
                    return true
                }
            }
        }
        return false
    }
}
