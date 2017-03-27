//
//  TileLayerViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/26.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class TileLayerViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let s = UIScrollView(frame: self.view.bounds)
        s.backgroundColor = UIColor.orange
        self.view.addSubview(s)
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tileLayer = CATiledLayer()
        tileLayer.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        tileLayer.delegate = self
        CATiledLayer.fadeDuration()
        
        self.scrollView.layer.addSublayer(tileLayer)
        self.scrollView.contentSize = tileLayer.frame.size
        
        tileLayer.setNeedsDisplay()
    }
    
    deinit {
        print("TileLayerViewController deinit")
    }
    
}

extension TileLayerViewController: CALayerDelegate {
    func draw(_ layer: CALayer, in ctx: CGContext) {
        // 所以请小心谨慎地确保你在这个方法中实现的绘制代码是线程安全的
            UIGraphicsPushContext(ctx)
            let bounds = ctx.boundingBoxOfClipPath
            let image = UIImage(named: "02.png")
            image?.draw(in: bounds)
            UIGraphicsPopContext()
    }
}

