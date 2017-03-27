//
//  ScrollLayerView.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/26.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class ScrollLayerView: UIView {

    override class var layerClass: AnyClass {
        return CAScrollLayer.classForCoder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        setup()
    }

    func setup() {

        self.layer.masksToBounds = true

        let pan = UIPanGestureRecognizer(target: self, action: #selector(ScrollLayerView.pan(sender:)))
        self.addGestureRecognizer(pan)
    }
    
    func pan(sender: UIPanGestureRecognizer) {
        
        var offset = self.bounds.origin
        offset.x -= sender.translation(in: self).x
        offset.y -= sender.translation(in: self).y

        if offset.x <= 0 { offset.x = 0 }
        if offset.y <= 0 { offset.y = 0 }
        
        self.layer.scroll(offset)
        sender.setTranslation(CGPoint.zero, in: self)
    }
}
