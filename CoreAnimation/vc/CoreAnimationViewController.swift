//
//  CoreAnimationViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/26.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class CoreAnimationViewController: UIViewController {
    
    lazy var gaView: UIView = {
        let v               = UIView(frame: CGRect(x: 20, y: 100,
                                                   width: 300, height: 300))
        v.backgroundColor   = UIColor.orange
        return v
    }()
    
    lazy var gaLayer: CALayer = {
        let l                 = CALayer()
        l.backgroundColor     = UIColor.blue.cgColor
        l.frame               = CGRect(x: 100, y: 100, width: 100, height: 100)
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(gaView)
        
        addTransiton()
        
        self.view.layer.addSublayer(gaLayer)
    }
    
    func animation() {
        
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        CATransaction.setAnimationDuration(2)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setCompletionBlock {
            self.gaLayer.transform = CATransform3DMakeScale(1.2, 1.2, 0)
        }
        
        gaLayer.backgroundColor = UIColor.randomCGColor()
        
        CATransaction.commit()
    }
    
    func addTransiton() {
        let transition       = CATransition()
        transition.type      = kCATransitionPush
        transition.subtype   = kCATransitionFromLeft
        self.gaLayer.actions = ["backgroundColor": transition]
    }
    
    func animation1(_ touches: Set<UITouch>) {
        let point = touches.first?.location(in: self.view)
        
        // 是否点击了 gaLayer.presentation()?.hitTest(point!)
        
        if gaLayer.presentation()?.hitTest(point!) != nil {
            self.gaLayer.backgroundColor = UIColor.randomCGColor()
            return
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        CATransaction.setAnimationDuration(4)
        self.gaLayer.position = point!
        CATransaction.commit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 001
//        animation()
        // 002
        animation1(touches)
    }
}
