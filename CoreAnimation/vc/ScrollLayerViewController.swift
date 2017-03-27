//
//  ScrollLayerViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/26.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class ScrollLayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createScrollLayerView()
    }
    
    func createScrollLayerView() {
        let s = ScrollLayerView(frame: CGRect(x: 20, y: 100, width: 200, height: 300))
        s.backgroundColor = UIColor.orange
        self.view.addSubview(s)
        
        let image = UIImage(named: "01.jpg")
        let imageV = UIImageView(image: image)
        s.addSubview(imageV)
    }

}
