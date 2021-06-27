//
//  UIView+Attributes.swift
//  NavigationApp
//
//  Created by Maksim Semeniuk on 27.06.2021.
//

import UIKit

extension UIView {
    
    @IBInspectable var CornerRadius: CGFloat {
        set { layer.cornerRadius = newValue  }
        get { return layer.cornerRadius }
    }
    
}
