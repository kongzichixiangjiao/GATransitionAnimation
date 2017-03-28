//
//  LikeButtonLayer.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/28.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class LikeButtonLayer: CALayer {

    var circle = [CAShapeLayer]()
    var circleSmall = [CAShapeLayer]()
    
    var circleCount: Int = 4
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.clear.cgColor
        
        initCircle()
    }
    
    func initCircle() {
        for _ in 0..<circleCount {
            let circleLayer = CAShapeLayer()
            circleLayer.backgroundColor = UIColor.randomCGColor()
            circleLayer.position = self.position
            circle.append(circleLayer)
        }
    }
    
    func startAnimation() {
        for i in 0..<circle.count {
            animation(circle[i], i: i + 1)
        }
    }
    
    func animation(_ layer: CAShapeLayer, i: Int) {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: self.position)
        bezierPath.addLine(to: CGPoint(x: 200, y: 200))
        
        let animation         = CAKeyframeAnimation(keyPath: "position")
        animation.duration    = 4
        animation.repeatCount = MAXFLOAT
        animation.path        = bezierPath.cgPath
        // 自动对齐图层到曲线
        animation.rotationMode = kCAAnimationRotateAuto
        animation.fillMode     = kCAFillModeBackwards
        layer.add(animation, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
