//
//  UIImage.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18/11/2021.
//

import UIKit

extension UIImage {
    func withSize(width: Int, height: Int) -> UIImage {
        return UIGraphicsImageRenderer(size: CGSize(width: width, height: height)).image { _ in
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
    }
    
}
