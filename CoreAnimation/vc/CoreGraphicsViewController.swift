//
//  CoreGraphicsViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/27.
//  Copyright © 2017年 houjianan. All rights reserved.
//


/*
 Core Animation为这些图形类型的绘制提供了专门的类，并给他们提供硬件支持。CAShapeLayer可以绘制多边形，直线和曲线。CATextLayer可以绘制文本。CAGradientLayer用来绘制渐变。这些总体上都比Core Graphics更快，同时他们也避免了创造一个寄宿图。
 */

import UIKit

class CoreGraphicsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s = ScrawlView(frame: self.view.bounds)
        s.backgroundColor = UIColor.white
        self.view.addSubview(s)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        return 
    }
    
}
