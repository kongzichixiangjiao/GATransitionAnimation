//
//  GradientView.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/24.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class ReplicatorView: UIView {

    //    API说明：The class used to create the layer for instances of this class.
    override class var layerClass: AnyClass {
        return CAReplicatorLayer.classForCoder()
    }
    //    获得本身转变成CAGradientLayer的对象
    var textLayer: CAReplicatorLayer {
        return self.layer as! CAReplicatorLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    xib初始化
    override func awakeFromNib() {
        setUp()
    }
    
    func setUp() {
        //configure replicator
        let layer = self.layer as! CAReplicatorLayer
        layer.instanceCount = 2
        var transform = CATransform3DIdentity
        let verticalOffset = self.bounds.size.height + 2;
        transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
        transform = CATransform3DScale(transform, 1, -1, 0);
        layer.instanceTransform = transform;
        layer.instanceAlphaOffset = -0.6;
    }
    
}
