//
//  GradientViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/24.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class GradientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradient()
    }
    
    func createGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        self.view.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor.randomCGColor(), UIColor.randomCGColor(), UIColor.randomCGColor(), UIColor.randomCGColor(), UIColor.randomCGColor()]
        gradientLayer.locations = [0.2, 0.3, 0.4, 0.5, 0.5]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0);
        gradientLayer.endPoint = CGPoint(x: 1, y: 1);
    }
    
    /*
     (0, 0)-----------(1, 0)
        |               |
        |               |
        |               |
        |               |
        |               |
     (0, 1)-----------(1, 1)
     */

}
