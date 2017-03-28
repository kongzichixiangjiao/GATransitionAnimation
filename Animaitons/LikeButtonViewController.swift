//
//  LikeButtonViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/28.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class LikeButtonViewController: UIViewController, CAAnimationDelegate {
    
    let like = LikeButtonLayer()
    
    var circle = [CAShapeLayer]()
    var circleSmall = [CAShapeLayer]()
    
    var maskLayer: CAShapeLayer!
    var buttomMask: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor()
        initImagelayer()
        initCircle()
        initMaskLayer()
    }
    
    func initImagelayer() {
        buttomMask = CALayer()
        buttomMask.contents = UIImage(named: "star")?.cgImage
        buttomMask.position = CGPoint(x: 200, y: 200)
        buttomMask.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        let layer = CALayer()
        layer.frame = self.view.bounds
        layer.backgroundColor = UIColor.randomCGColor()
        layer.mask = buttomMask
        self.view.layer.addSublayer(layer)
    }
    
    func initCircle() {
        for _ in 0..<10 {
            let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 3, startAngle: CGFloat.GA_M_PI * 2, endAngle: 0, clockwise: false)
            
            let shaper = CAShapeLayer()
            shaper.fillColor = UIColor.randomCGColor()
            shaper.strokeColor = UIColor.randomCGColor()
            shaper.lineWidth = 1
            shaper.lineJoin = kCALineJoinMiter
            shaper.lineCap = kCALineCapRound
            shaper.path = path.cgPath
            self.view.layer.addSublayer(shaper)
            
            circle.append(shaper)
        }
        
        for _ in 0..<10 {
            let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 2, startAngle: CGFloat.GA_M_PI * 2, endAngle: 0, clockwise: false)
            
            let shaper = CAShapeLayer()
            shaper.fillColor = UIColor.randomCGColor()
            shaper.strokeColor = UIColor.randomCGColor()
            shaper.lineWidth = 1
            shaper.lineJoin = kCALineJoinMiter
            shaper.lineCap = kCALineCapRound
            shaper.path = path.cgPath
            self.view.layer.addSublayer(shaper)
            
            circleSmall.append(shaper)
        }
    }
    
    func initMaskLayer() {
        maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.randomCGColor()
        maskLayer.strokeColor = UIColor.randomCGColor()
        maskLayer.lineWidth = 1.5
        self.view.layer.addSublayer(maskLayer)
    }
    
    func startAnimation() {
        maskLayerStartAnim()
    }
    
    func buttomMaskAnimation() {
        let anim = CAKeyframeAnimation(keyPath: "transform.scale")
        anim.duration  = 2
        anim.values = [0.4, 1, 0.9, 1]
        anim.calculationMode = kCAAnimationCubic
        buttomMask.add(anim, forKey: "scale")
    }
    
    public func maskLayerStartAnim() {
        let anim = CAKeyframeAnimation(keyPath: "path")
        let fromPath = UIBezierPath(arcCenter: CGPoint(x: 200, y: 200), radius: 1, startAngle: 0, endAngle: CGFloat(M_PI) * 2.0, clockwise: false).cgPath
        let toPath = UIBezierPath(arcCenter: CGPoint.init(x: 200, y: 200), radius: 50, startAngle: 0, endAngle: CGFloat(M_PI) * 2.0, clockwise: false).cgPath
        anim.delegate = self
        anim.duration = 2
        anim.values = [fromPath, toPath]
        anim.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        maskLayer.add(anim, forKey: "path")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        maskLayer.removeAllAnimations()
        maskLayer.removeFromSuperlayer()
        buttomMaskAnimation()
        for i in 0..<circle.count {
            animation(circle[i], i: i + 1)
            animation(circleSmall[i], i: i + 1, isSmall: true)
        }
        
    }
    
    
    func animation(_ layer: CAShapeLayer, i: Int, isSmall: Bool = false) {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 200, y: 200))
        let angle = CGFloat.GA_M_PI * 2 / CGFloat(circle.count)
        let x: CGFloat = cos((angle * CGFloat(i)) + (isSmall ? CGFloat.GA_M_PI / CGFloat(circle.count) : 0)) * 50 + 200
        let y: CGFloat = sin((angle * CGFloat(i)) + (isSmall ? CGFloat.GA_M_PI / CGFloat(circle.count) : 0)) * 50 + 200
        
        bezierPath.addLine(to: CGPoint(x: x, y: y))
        /*
        // 方便观察线路
        let shaper = CAShapeLayer()
        shaper.fillColor = UIColor.clear.cgColor
        shaper.strokeColor = UIColor.randomCGColor()
        shaper.lineWidth = 1
        shaper.lineJoin = kCALineJoinMiter
        shaper.lineCap = kCALineCapRound
        shaper.path = bezierPath.cgPath
        self.view.layer.addSublayer(shaper)
        */
        let animation         = CAKeyframeAnimation(keyPath: "position")
        animation.duration    = 1
        animation.repeatCount = 1
        animation.path        = bezierPath.cgPath
        layer.add(animation, forKey: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startAnimation()
    }
    
    
    
}
