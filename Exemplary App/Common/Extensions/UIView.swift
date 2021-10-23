//
//  UIView.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 12.10.2021.
//

import Foundation
import UIKit

extension UIView {
    func setGradienBackgroudColorVertical(from colorTop: UIColor, to colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds
                
        layer.insertSublayer(gradientLayer, at:0)
    }
}
