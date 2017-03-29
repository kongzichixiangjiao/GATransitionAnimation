//
//  LikeButtonViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/28.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class LikeButtonViewController: UIViewController, CAAnimationDelegate {
    
    var circle = [CAShapeLayer]()
    var circleSmall = [CAShapeLayer]()
    
    var maskLayer: CAShapeLayer!
    var buttomMask: CALayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor()

        let like = LikeButton(frame: CGRect(x: 30, y: 200, width: 30, height: 30), clickedHandler: {
            print("start")
        })
        self.view.addSubview(like)
    }
}
