//
//  CustomButton.swift
//  NavigationApp
//
//  Created by Maksim Semeniuk on 27.06.2021.
//

import UIKit

class CustomButton: UIButton {
    func setEnabledWithAnimation(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = isEnabled ? UIColor.accentColor : UIColor.accentColor.withAlphaComponent(0.5)
        }
    }
}
