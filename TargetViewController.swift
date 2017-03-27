//
//  ViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/16.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class TargetViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    enum vcType {
        case cube, gradient, replicator, emitter, scroll, tile, gl, avLayer, animation, basicAnimation, keyFrameAnimation, groupAnimation, customAnimation, timer, chipmunk, coreGraphics, image
    }
    
    var data: [[String:Any]] = [["1" : "立方体", "2" : "CubeViewController", "type" : vcType.cube],
                                   ["1" : "渐变", "2" : "GradientViewController", "type" : vcType.gradient],
                                   ["1" : "重复图层", "2" : "ReplicatorViewController", "type" : vcType.replicator],
                                   ["1" : "粒子发射器", "2" : "EmitterViewController", "type" : vcType.emitter],
                                   ["1" : "ScrollLayer", "2" : "ScrollLayerViewController", "type" : vcType.scroll],
                                   ["1" : "超大图展示(进出崩溃)", "2" : "TileLayerViewController", "type" : vcType.tile],
                                   ["1" : "glView", "2" : "EAGLViewController", "type" : vcType.gl],
                                   ["1" : "AVPlayerLayer", "2" : "AVPlayerLayerViewController", "type" : vcType.avLayer],
                                   ["1" : "事务动画", "2" : "CoreAnimationViewController", "type" : vcType.animation],
                                   ["1" : "basic动画", "2" : "BasicAnimationViewController", "type" : vcType.basicAnimation],
                                   ["1" : "关键帧动画", "2" : "KeyframeAnimationViewController", "type" : vcType.keyFrameAnimation],
                                   ["1" : "动画组", "2" : "GroupAnimationViewController", "type" : vcType.groupAnimation],
                                   ["1" : "自定义动画", "2" : "CustomViewController", "type" : vcType.customAnimation],
                                   ["1" : "定时器", "2" : "TimerViewController", "type" : vcType.timer],
                                   ["1" : "物理模拟", "2" : "ChipmunkViewController", "type" : vcType.timer],
                                   ["1" : "CoreGraphics", "2" : "CoreGraphicsViewController", "type" : vcType.coreGraphics],
                                   ["1" : "图片加载", "2" : "ImageViewController", "type" : vcType.image]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        automaticallyAdjustsScrollViewInsets = true
    }
}

extension TargetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = data[indexPath.row]["1"] as! String?
        cell?.detailTextLabel?.text = data[indexPath.row]["2"] as! String?
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = data[indexPath.row]["type"] as! vcType
        switch type {
        case .cube:
            self.navigationController?.pushViewController(CubeViewController(), animated: true)
        case .gradient:
            self.navigationController?.pushViewController(GradientViewController(), animated: true)
        case .replicator:
            self.navigationController?.pushViewController(ReplicatorViewController(), animated: true)
        case .emitter:
            self.navigationController?.pushViewController(EmitterViewController(), animated: true)
        case .scroll:
            self.navigationController?.pushViewController(ScrollLayerViewController(), animated: true)
        case .tile:
            self.navigationController?.pushViewController(TileLayerViewController(), animated: true)
        case .gl:
            self.navigationController?.pushViewController(EAGLViewController(), animated: true)
        case .avLayer:
            self.navigationController?.pushViewController(AVPlayerLayerViewController(), animated: true)
        case .animation:
            self.navigationController?.pushViewController(CoreAnimationViewController(), animated: true)
        case .basicAnimation:
            self.navigationController?.pushViewController(BasicAnimationViewController(), animated: true)
        case .keyFrameAnimation:
            self.navigationController?.pushViewController(KeyFrameAnimationViewController(), animated: true)
        case .groupAnimation:
            self.navigationController?.pushViewController(GroupAnimaitonViewController(), animated: true)
        case .customAnimation:
            self.navigationController?.pushViewController(CustomViewController(), animated: true)
        case .timer:
            self.navigationController?.pushViewController(TimerViewController(), animated: true)
        case .chipmunk:
            self.navigationController?.pushViewController(ChipmunkViewController(), animated: true)
        case .coreGraphics:
            self.navigationController?.pushViewController(CoreGraphicsViewController(), animated: true)
        case .image:
            self.navigationController?.pushViewController(ImageViewController(), animated: true)
        }

    }
}

