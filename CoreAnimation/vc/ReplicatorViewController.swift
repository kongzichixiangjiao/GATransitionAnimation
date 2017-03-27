//
//  ReplicatorViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/24.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class ReplicatorViewController: UIViewController {

    lazy var myView: UIView = {
        let v = UIView(frame: CGRect(x: 100, y: 200, width: 40, height: 40))
        v.backgroundColor = UIColor.orange
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        createReplicarorLayers()
        
        createReplicatorView()
    }
    
    
    func createReplicatorView() {
        
        let replicatorView = ReplicatorView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))

        self.view.addSubview(replicatorView)
        
        let image = UIImage(named: "02.png")
        let imageV = UIImageView(image: image)
        imageV.frame = replicatorView.bounds
        replicatorView.addSubview(imageV)
    }
    
    
    func createReplicarorLayers() {
        
        self.view.addSubview(myView)
        
        let replicator = CAReplicatorLayer()
        replicator.frame = self.myView.bounds
        // 重复次数
        replicator.instanceCount = 10
        // 重复的transform
        replicator.instanceTransform = transform()
        
        // 下一个色块比前一个rgb颜色 b-1 g-1
        replicator.instanceBlueOffset = -0.1;
        replicator.instanceGreenOffset = -0.1;
        
        
        self.myView.layer.addSublayer(replicator)
        replicator.addSublayer(createLayer())
    }
    
    func createLayer() -> CALayer {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        layer.backgroundColor = UIColor.randomCGColor()
        return layer
    }
    
    func transform() -> CATransform3D {
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 100, 0)
        // 这里的角度如果大 可能显示不全10个色块 5.0->4.0
        transform = CATransform3DRotate(transform, CGFloat.GA_M_PI / 5.0, 0, 0, 1)
        transform = CATransform3DTranslate(transform, 0, -100, 0)
        return transform
    }

}
