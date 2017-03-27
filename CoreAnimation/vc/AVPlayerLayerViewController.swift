//
//  AVPlayerLayerViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/26.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import AVFoundation

class AVPlayerLayerViewController: UIViewController {
    
    var avPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "test", withExtension: "mp4")
        
        let item = AVPlayerItem(url: url!)
        
        // 如果异常崩溃libc++abi.dylib`__cxa_throw 把全局断点的exception改成oc 就可以了！！
        avPlayer = AVPlayer(playerItem: item)
        
        let playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        avPlayer?.play()
    }
}
