//
//  UIView+Border.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit

extension UIView {
        
    enum ViewSide {
        case Left, Right, Top, Bottom, All
    }
    
    func addBorder(toSide side: ViewSide, withColor color: UIColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        border.borderWidth = thickness
        
//        switch side {
//        case .Left:
//            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height);
//            break
//        case .Right:
//            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height);
//            break
//        case .Top:
//            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness);
//            break
//        case .Bottom:
//            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness);
//            break
//        case .All:
//            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); //Left
//            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); //Right
//            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); //Top
//            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); //Bottom
//            break
//        }
        
        layer.addSublayer(border)
    }
}
