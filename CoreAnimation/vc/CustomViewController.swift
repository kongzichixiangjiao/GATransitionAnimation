//
//  CustomViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/27.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    lazy var gaLabel: UILabel = {
        let v               = UILabel(frame: CGRect(x: 20,
                                                   y: 100,
                                                   width: 300,
                                                   height: 300))
        v.text = "点击屏幕执行动画"
        v.font = UIFont.systemFont(ofSize: 12)
        v.backgroundColor   = UIColor.orange
        return v
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(gaLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //preserve the current view snapshot
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 0.0)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let coverImage = UIGraphicsGetImageFromCurrentImageContext()
        //insert snapshot view in front of this one
        let coverView = UIImageView(image: coverImage)
        coverView.frame = self.view.bounds;
        self.view.addSubview(coverView)
        self.view.backgroundColor = UIColor.randomColor()
        //perform animation (anything you like)
        UIView.animate(withDuration: 2, animations: {
            var transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            transform = transform.rotated(by: CGFloat.GA_M_PI_2)
            coverView.transform = transform
            coverView.alpha = 0.0
        }, completion: {
            bo in
            coverView.removeFromSuperview()
        })
    }
}
