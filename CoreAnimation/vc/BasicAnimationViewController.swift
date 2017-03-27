//
//  BasicAnimationViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/27.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class BasicAnimationViewController: UIViewController {

    lazy var gaLayer: CALayer = {
        let l                 = CALayer()
        l.backgroundColor     = UIColor.blue.cgColor
        l.frame               = CGRect(x: 100, y: 100, width: 100, height: 100)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.addSublayer(gaLayer)
        
        startAnimation()
    }
    
    func startAnimation() {
        let basicAnimation          = CABasicAnimation(keyPath: "backgroundColor")
        basicAnimation.delegate     = self
        basicAnimation.fromValue    = UIColor.randomCGColor()
        basicAnimation.toValue      = UIColor.randomCGColor()
        basicAnimation.autoreverses = true
        basicAnimation.duration     = 3
        basicAnimation.speed = 2
        basicAnimation.repeatCount  = MAXFLOAT
        basicAnimation.timeOffset = 1
        basicAnimation.fillMode     = kCAFillModeForwards
        gaLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    func stopAnimation() {
        // 001
        gaLayer.removeAllAnimations()
        // 002
        gaLayer.removeAnimation(forKey: "basicAnimation")
    }
}

extension BasicAnimationViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print("start")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("stop")
    }
    
}
