//
//  PopUpButton.swift
//  Oops
//
//  Created by Meniny on 2016-07-17.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation
import UIKit

extension Oops {
    /// Button sub-class
    open class Button: UIButton {
        public struct ShowTimeoutConfiguration {
            let prefix: String
            let suffix: String
            
            public init(prefix: String = "", suffix: String = "") {
                self.prefix = prefix
                self.suffix = suffix
            }
        }
        
        open var isOptionalButton: Bool = false
        open var actionType = Oops.ActionType.none
        open var target: AnyObject!
        open var selector: Selector!
        open var action: (() -> Swift.Void)!
        open var customBackgroundColor: UIColor?
        open var customTextColor: UIColor?
        open var initialTitle: String!
        open var showTimeout: Oops.Button.ShowTimeoutConfiguration?
        
        
        public init() {
            super.init(frame: CGRect.zero)
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder:aDecoder)
        }
        
        override public init(frame: CGRect) {
            super.init(frame:frame)
        }
    }
}

