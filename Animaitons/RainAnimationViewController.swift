//
//  RainAnimationViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/28.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class RainAnimationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        addRainningEffect()
    }
    
    func addRainningEffect() {
        //粒子发射器图层
        let rainDropEmitterLayer = CAEmitterLayer()
        rainDropEmitterLayer.frame = self.view.bounds
        //粒子发射器位置
        rainDropEmitterLayer.emitterPosition = CGPoint(x: 100, y: -30)
        //粒子发射器的范围
        rainDropEmitterLayer.emitterSize = CGSize(width: self.view.bounds.size.width * 4, height: 0)
        //发射模式
        rainDropEmitterLayer.emitterMode = kCAEmitterLayerOutline
        //粒子模式
        rainDropEmitterLayer.emitterShape = kCAEmitterLayerLine
        
        //设置layer的粒子
        rainDropEmitterLayer.emitterCells = [createEmitterCell(imageName: "ele_rainLine1"), createEmitterCell(imageName: "ele_rainLine2"), createEmitterCell(imageName: "ele_rainLine3")]
        
        self.view.layer.addSublayer(rainDropEmitterLayer)
    }
    
    func createEmitterCell(imageName: String) -> CAEmitterCell {
        //创建粒子
        let emitterCell = CAEmitterCell()
        //设置粒子内容
        emitterCell.contents = UIImage(named: imageName)?.cgImage
        //设置粒子缩放比例
        emitterCell.scale = 0.9
        //缩放范围
        emitterCell.scaleRange = 1
        //每秒粒子产生数量
        emitterCell.birthRate = 15
        //粒子生命周期
        emitterCell.lifetime = 4
        //粒子透明速度
        emitterCell.alphaSpeed = -0.07
        //粒子速度
        emitterCell.velocity = 280
        emitterCell.velocityRange = 100
        //设置发射角度
        emitterCell.emissionLongitude = -CGFloat.GA_M_PI
        
        //设置粒子旋转角速度 // 树叶飘落效果
//        emitterCell.spin = CGFloat.GA_M_PI_4
        emitterCell.repeatCount = MAXFLOAT
        
        return emitterCell
    }
    
}
