//
//  KeyFrameAnimationViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/27.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class KeyFrameAnimationViewController: UIViewController {

    lazy var gaLayer: CALayer = {
        let l                 = CALayer()
        l.backgroundColor     = UIColor.blue.cgColor
        l.frame               = CGRect(x: 100,
                                       y: 100,
                                       width: 30,
                                       height: 30)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.addSublayer(gaLayer)
        // 001
//        keyFrameAnimation()
        // 002
//        keyFrameAnimationWithBezierPath()
        // 003
//        bufferAnimation()
        // 004
        bufferAnimation1()
    }
    
    func interpolate(fromValue: NSValue, toValue: NSValue, time: Float) -> NSValue {
        let from = fromValue.cgPointValue
        let to = toValue.cgPointValue
        let x = interpolate(from: Float(from.x), to: Float(to.x), time: time)
        let y = interpolate(from: Float(from.y), to: Float(to.y), time: time)
        let point = CGPoint(x: CGFloat(x), y: CGFloat(y))
        return NSValue.init(cgPoint: point)
    }
    
    func interpolate(from: Float, to: Float, time: Float) -> Float {
        return (to - from) * time + from
    }
    // 罗伯特·彭纳有一个网页关于缓冲函数 http://robertpenner.com/easing/
    func bounceEaseOut(t: Float) -> Float {
        if (t < 4/11.0) {
            return (121 * t * t)/16.0;
        } else if (t < 8/11.0) {
            return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
        } else if (t < 9/10.0) {
            return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
        }
        return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
    }
    
    func bufferAnimation1() {
        let duration = 2
        let fromVlue = NSValue.init(cgPoint: CGPoint(x: 150, y: 32))
        let toVlue = NSValue.init(cgPoint: CGPoint(x: 150, y: 268))
        var frames = [NSValue]()
        for i in 0..<duration * 60 {
            var time = 1/(Float)(duration * 60) * Float(i)
            time = bounceEaseOut(t: time)
            frames.append(interpolate(fromValue: fromVlue, toValue: toVlue, time: time))
        }
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = CFTimeInterval(duration)
        animation.delegate = self
        animation.repeatCount = MAXFLOAT
        
        animation.values = frames
        
        self.gaLayer.position = CGPoint(x: 150, y: 268)
        self.gaLayer.add(animation, forKey: nil)
    }
    
    func bufferAnimation() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 2.0
        animation.delegate = self
        animation.repeatCount = MAXFLOAT
        
        animation.values = [NSValue.init(cgPoint: CGPoint(x: 150, y: 32)),
                            NSValue.init(cgPoint: CGPoint(x: 150, y: 268)),
                            NSValue.init(cgPoint: CGPoint(x: 150, y: 140)),
                            NSValue.init(cgPoint: CGPoint(x: 150, y: 268)),
                            NSValue.init(cgPoint: CGPoint(x: 150, y: 220)),
                            NSValue.init(cgPoint: CGPoint(x: 150, y: 268)),
                            NSValue.init(cgPoint: CGPoint(x: 150, y: 250)),
                            NSValue.init(cgPoint: CGPoint(x: 150, y: 269))]

        animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        animation.keyTimes = [0.0, 0.3, 0.5, 0.7, 0.8, 0.9, 0.95, 1.0]

        self.gaLayer.position = CGPoint(x: 150, y: 268)
        self.gaLayer.add(animation, forKey: nil)
    }
    
    func keyFrameAnimationWithBezierPath() {
        
        let bezierPath = UIBezierPath()
        // 001
//        bezierPath.move(to: CGPoint(x: 100, y: 100))
//        bezierPath.addCurve(to: CGPoint(x: 200, y: 200), controlPoint1: CGPoint(x: 100, y: 100), controlPoint2: CGPoint(x: 100, y: 150))
        // 002
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
        
        let animation          = CAKeyframeAnimation(keyPath: "position")
        animation.duration     = 4
        animation.repeatCount  = MAXFLOAT
        animation.path         = bezierPath.cgPath
        // 自动对齐图层到曲线   
        animation.rotationMode = kCAAnimationRotateAuto
        animation.fillMode     = kCAFillModeBackwards
        iconLayer.add(animation, forKey: nil)
    }
    
    func keyFrameAnimation() {
        let keyFrameAnimation         = CAKeyframeAnimation(keyPath: "backgroundColor")
        keyFrameAnimation.duration    = 2
        keyFrameAnimation.values      = [UIColor.randomCGColor(),
                                         UIColor.randomCGColor(),
                                         UIColor.randomCGColor(),
                                         UIColor.randomCGColor(),
                                         UIColor.randomCGColor()]
        keyFrameAnimation.repeatCount = MAXFLOAT
        gaLayer.add(keyFrameAnimation, forKey: nil)
    }
}

extension KeyFrameAnimationViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print("start")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("stop")
    }
    
}
