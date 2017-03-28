//
//  SunAnimaitonViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/28.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class SunAnimationViewController: UIViewController {

    lazy var layer1: CALayer = {
        let l = CALayer()
        l.frame = CGRect(x: 60, y: 200, width: 200, height: 200)
        l.contents = UIImage(named: "ele_sunnySun")?.cgImage
        return l
    }()
    
    lazy var layer2: CALayer = {
        let l = CALayer()
        l.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        l.contents = UIImage(named: "ele_sunnySunshine")?.cgImage
        return l
    }()
    
    lazy var layer3: CALayer = {
        let l = CALayer()
        let w: CGFloat = 200
        let h: CGFloat = 200
        l.frame = CGRect(x: (self.layer1.bounds.size.width - w) / 2, y: (self.layer1.bounds.size.height - h) / 2, width: w, height: h)
        l.contents = UIImage(named: "night_sunny_big_star")?.cgImage
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        self.view.layer.addSublayer(layer1)
        

        layer1.addSublayer(layer2)
        layer1.addSublayer(layer3)
        
        layer2.position = layer3.position
        
        addAnimaiton()
    }
    
    func addAnimaiton() {
        let animaition = CABasicAnimation(keyPath: "transform.rotation.z")
        animaition.fromValue = CGFloat.GA_M_PI
        animaition.toValue = -CGFloat.GA_M_PI
        animaition.duration = 8
        animaition.repeatCount = MAXFLOAT
        animaition.autoreverses = false
        layer1.add(animaition, forKey: nil)
    }

}


