//
//  EmitterViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/25.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class EmitterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createEmitter()
    }
    
    func createEmitter() {
        let emitter = CAEmitterLayer()
        emitter.frame = self.view.bounds
        /*
         public let kCAEmitterLayerUnordered: String // 叠加部位加深
         public let kCAEmitterLayerOldestFirst: String
         public let kCAEmitterLayerOldestLast: String
         public let kCAEmitterLayerBackToFront: String
         public let kCAEmitterLayerAdditive: String // 叠加部位透明
         */
        emitter.renderMode = kCAEmitterLayerUnordered
        emitter.emitterPosition = CGPoint(x: emitter.frame.size.width / 2, y: emitter.frame.size.height / 2)
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "02.png")?.cgImage
        // 发射物体个数
        emitterCell.birthRate = 20
        // 发射物体的生命周期
        emitterCell.lifetime = 5
        // 透明度递减的速度
        emitterCell.alphaSpeed = -0.4
        // 发射的速度
        emitterCell.velocity = 50
        // 发射的范围
        emitterCell.velocityRange = 50
        // 发射的角度  // CGFloat.GA_M_PI / 2
        emitterCell.emissionRange = CGFloat.GA_M_PI
        // 发射的cell
        emitter.emitterCells = [emitterCell]
        
        self.view.layer.addSublayer(emitter)
    }
    

}
