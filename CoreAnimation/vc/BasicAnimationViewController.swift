//
//  BasicAnimationViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/27.
//  Copyright © 2017年 houjianan. All rights reserved.
//

/*
 animationWithKeyPath的值：
 
 　 transform.scale = 比例轉換
 
 transform.scale.x = 闊的比例轉換
 
 transform.scale.y = 高的比例轉換
 
 transform.rotation.z = 平面圖的旋轉
 
 opacity = 透明度
 
 margin
 
 zPosition
 
 
 backgroundColor    背景颜色
 cornerRadius    圆角
 borderWidth
 
 bounds
 
 contents
 
 contentsRect
 
 cornerRadius
 
 frame
 
 hidden
 
 mask
 
 masksToBounds
 
 opacity
 
 position
 
 shadowColor
 
 shadowOffset
 
 shadowOpacity
 
 
 shadowRadius
 */

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
