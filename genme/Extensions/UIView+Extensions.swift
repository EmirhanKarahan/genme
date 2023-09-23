//
//  UIView+Extensions.swift
//  genme
//
//  Created by Emirhan Karahan on 12.08.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    func addShadow(
        offset: CGSize,
        color: UIColor = .black,
        opacity: Float = 0.5,
        radius: CGFloat = 5.0,
        isCenter: Bool = false)
    {
        layer.masksToBounds = false
        layer.shadowColor = color.withAlphaComponent(0.5).cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        if isCenter {
            layer.position = center
        }
    }
    
}
