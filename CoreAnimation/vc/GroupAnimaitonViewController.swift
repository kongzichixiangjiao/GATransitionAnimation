//
//  GroupAnimaitonViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/27.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class GroupAnimaitonViewController: UIViewController {

    lazy var gaLayer: CALayer = {
        let l                 = CALayer()
        l.backgroundColor     = UIColor.blue.cgColor
        l.frame               = CGRect(x: 100, y: 100, width: 40, height: 40)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.addSublayer(gaLayer)
        
        groupAnimation()
    }
    
    func groupAnimation() {
        
        let bezierPath = UIBezierPath()

        bezierPath.addArc(withCenter: CGPoint(x: 150, y: 220), radius: 120, startAngle: 0, endAngle: CGFloat.GA_M_PI * 2, clockwise: true)
        
        let pathLayer         = CAShapeLayer()
        pathLayer.path        = bezierPath.cgPath
        pathLayer.fillColor   = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.orange.cgColor
        pathLayer.lineWidth   = 2
        self.view.layer.addSublayer(pathLayer)
        
        let iconLayer      = CALayer()
        iconLayer.frame    = CGRect(x: 0, y: 0, width: 40, height: 40)
        iconLayer.position = CGPoint(x: 100, y: 100)
        iconLayer.contents = UIImage(named: "02.png")?.cgImage
        self.view.layer.addSublayer(iconLayer)
        
        let animation         = CAKeyframeAnimation(keyPath: "position")
        animation.duration    = 4
        animation.repeatCount = MAXFLOAT
        animation.path        = bezierPath.cgPath
        // 自动对齐图层到曲线
        animation.rotationMode = kCAAnimationRotateAuto
        animation.fillMode     = kCAFillModeBackwards
       
        let animation1    = CAKeyframeAnimation(keyPath: "backgroundColor")
        animation1.values = [UIColor.randomCGColor(),
                             UIColor.randomCGColor(),
                             UIColor.randomCGColor(),
                             UIColor.randomCGColor(),
                             UIColor.randomCGColor(),
                             UIColor.randomCGColor()]
        animation1.duration    = 4
        animation1.repeatCount = MAXFLOAT
        gaLayer.add(animation1, forKey: nil)
        
        let group         = CAAnimationGroup()
        group.animations  = [animation, animation1]
        group.duration    = 4
        group.repeatCount = MAXFLOAT
        gaLayer.add(group, forKey: nil)
    }

}
