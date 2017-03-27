//
//  TimerViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/27.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    var timer: CADisplayLink?
    var lastStep: CFTimeInterval!
    var timeOffset1: CFTimeInterval = 1
    var duration: CFTimeInterval = 2
    
    lazy var gaLabel: UILabel = {
        let v               = UILabel(frame: CGRect(x: 20,
                                                    y: 100,
                                                    width: 60,
                                                    height: 60))
        v.font = UIFont.systemFont(ofSize: 12)
        v.backgroundColor   = UIColor.orange
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(gaLabel)
        
        /*
         NSDefaultRunLoopMode - 标准优先级
         NSRunLoopCommonModes - 高优先级
         UITrackingRunLoopMode - 用于UIScrollView和别的控件的动画
         */

        /*
        // 001
        let nsTimer = Timer(timeInterval: 2, repeats: true, block: {
            timer in
            print(Date())
        })
        RunLoop.main.add(nsTimer, forMode: .defaultRunLoopMode)
         */
        
        // 002
        self.lastStep = CACurrentMediaTime()
        timer?.invalidate()
        timer = CADisplayLink(target: self, selector: #selector(TimerViewController.timerAciton(sender:)))
        timer?.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    func timerAciton(sender: CADisplayLink) {
        let fromVlue = NSValue.init(cgPoint: CGPoint(x: 150, y: 32))
        let toVlue = NSValue.init(cgPoint: CGPoint(x: 150, y: 268))
        
        let thisStep = CACurrentMediaTime()

        let stepDuration = thisStep - self.lastStep
        print(stepDuration)
        self.lastStep = thisStep
        //update time offset
        self.timeOffset1 = CFTimeInterval(min(self.timeOffset1 + stepDuration, self.duration))
        print(self.timeOffset1)
        //get normalized time offset (in range 0 - 1)
        var time = self.timeOffset1 / duration
        //apply easing
        time = CFTimeInterval(bounceEaseOut(t: Float(time)))
        
        let postion = interpolate(fromValue: fromVlue, toValue: toVlue, time: Float(time))

        gaLabel.center = postion.cgPointValue
        
        if (self.timeOffset1 >= self.duration) {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func interpolate(fromValue: NSValue, toValue: NSValue, time: Float) -> NSValue {
        let from = fromValue.cgPointValue
        let to = toValue.cgPointValue
        let x = interpolate(from: Float(from.x), to: Float(to.x), time: time)
        let y = interpolate(from: Float(from.y), to: Float(to.y), time: time)
        let point = CGPoint(x: CGFloat(x), y: CGFloat(y))
        return NSValue.init(cgPoint: point)
    }
    
    func interpolate(from: Float, to: Float, time: Float) -> Float {
        return (to - from) * time + from
    }
    // 罗伯特·彭纳有一个网页关于缓冲函数 http://robertpenner.com/easing/
    func bounceEaseOut(t: Float) -> Float {
        if (t < 4/11.0) {
            return (121 * t * t)/16.0;
        } else if (t < 8/11.0) {
            return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
        } else if (t < 9/10.0) {
            return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
        }
        return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
    }
    
    func bufferAnimation1() {
    }
}
