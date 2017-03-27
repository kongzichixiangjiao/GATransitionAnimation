//
//  Color-Extension.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/24.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

extension UIColor {
    class func randomCGColor(alpha a: CGFloat = 1) -> CGColor {
        return self.randomColor(alpha: a).cgColor
    }
    
    class func randomColor(alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: alpha)
    }
}
