//
//  Oops.Responder.swift
//  Oops
//
//  Created by Meniny on 2016-07-17.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation
import UIKit

extension Oops {
    // Allow alerts to be closed/renamed in a chainable manner
    // Example: Oops().showSuccess(self, title: "Test", subTitle: "Value").close()
    open class Responder {
        let alertview: Oops
        
        // Initialisation and Title/Subtitle/Close functions
        public init(alertview: Oops) {
            self.alertview = alertview
        }
        
        open func setTitle(_ title: String) {
            self.alertview.labelTitle.text = title
        }
        
        open func setSubTitle(_ subTitle: String) {
            self.alertview.viewText.text = subTitle
        }
        
        open func close() {
            self.alertview.hideView()
        }
        
        open func setDismissAction(_ action: @escaping Oops.DismissClosure) {
            self.alertview.dismissAction = action
        }
    }
}

