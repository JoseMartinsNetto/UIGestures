//
//  Extensions.swift
//  UIGestures
//
//  Created by Jose Martins on 09/01/21.
//

import UIKit

extension UIView {
    
    func applyDash() {
        
        let dashed = CAShapeLayer()
        
        dashed.strokeColor = UIColor.white.cgColor
        dashed.lineWidth = 4
        dashed.lineDashPattern = [3,5]
        dashed.frame = self.bounds
        dashed.fillColor = nil
        dashed.path = UIBezierPath(rect: self.bounds).cgPath
        
        self.layer.addSublayer(dashed)
    }
    
    func applyShadow(offset: CGSize = CGSize(width: 15, height: 15), shadowColor: UIColor = #colorLiteral(red: 0.07450980392, green: 0.09803921569, blue: 0.1294117647, alpha: 1), radius: CGFloat = 25, opacity: Float = 1) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offset
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
