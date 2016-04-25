//
//  Extensions.swift
//  SCCollectionViewCustomLayout
//
//  Created by Catherine Schwartz on 31/12/2015.
//  Copyright © 2015 Catherine Schwartz. All rights reserved.
//

import UIKit

// Extensions and random stuff

extension UIView {
    
    func setBorder(color: UIColor, width: CGFloat = 1.0) {
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = width
    }
}

func generateRandomData() -> [[UIColor]] {
    let numberOfRows = 20
    let numberOfItemsPerRow = 15
    
    return (0..<numberOfRows).map { _ in
        return (0..<numberOfItemsPerRow).map { _ in UIColor.randomColor() }
    }
}

func generateArrayOfRandomData(numberOfItems: Int = 20) -> [UIColor] {
    return (0..<numberOfItems).map { _ in UIColor.randomColor() }
}

extension UIColor {
    class func randomColor() -> UIColor {
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}