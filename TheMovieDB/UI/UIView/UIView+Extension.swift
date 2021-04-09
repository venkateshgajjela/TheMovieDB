//
//  UIView+Extension.swift
//  TheMovieDB
//
//  Created by VENKSTESHKSTL on 08/04/21.
//

import Foundation
import UIKit



extension UIView {
func viewShadow(color: UIColor, opacity: Float = 0.5, radius: CGFloat = 5, shadowOffset: CGSize) {

        layer.cornerRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 7.0
        layer.masksToBounds =  false
    
}
}
