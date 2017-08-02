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
        
        var isOptionalButton: Bool = false
        var actionType = Oops.ActionType.none
        var target: AnyObject!
        var selector: Selector!
        var action: (() -> Swift.Void)!
        var customBackgroundColor: UIColor?
        var customTextColor: UIColor?
        var initialTitle: String!
        var showTimeout: Oops.Button.ShowTimeoutConfiguration?
        
        
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

