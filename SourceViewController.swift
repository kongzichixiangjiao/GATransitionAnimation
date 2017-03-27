//
//  SourceViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/16.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class SourceViewController: UIViewController {

    let d = GAModalTransitionDelegate()
    
    var myView: UIView!
    var yellowView: UIView!
    var blueView: UIView!
    
    override func viewDidLoad() {
        createUI()
        
//        createTimer()
    }
    
    func createTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            timer in
            let calendar = NSCalendar(calendarIdentifier: .gregorian)
            let components = calendar?.components([.minute, .hour, .second], from: Date())
            let _ = (Double(components!.hour!) / 60.0) * M_PI * 2.0
            let minsAngle = (Double(components!.minute!) / 60.0) * M_PI * 2.0
            let secsAngle = (Double(components!.second!) / 60.0) * M_PI * 2.0

            self.myView.transform = CGAffineTransform(rotationAngle: CGFloat(minsAngle));
            self.yellowView.transform = CGAffineTransform(rotationAngle: CGFloat(secsAngle))
        })
        RunLoop().add(timer, forMode: .commonModes)
    }
    
    func createUI() {
        let image = UIImage(named: "01.jpg")
        myView = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        
        myView.backgroundColor = UIColor.orange
        myView.layer.contents = image?.cgImage
        myView.layer.contentsGravity = kCAGravityResizeAspect
        myView.layer.contentsScale = UIScreen.main.scale
        myView.layer.contentsRect = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
        myView.clipsToBounds = true
        myView.layer.delegate = self
        myView.layer.display()
        self.view.addSubview(myView)
        
        yellowView = UIView(frame: CGRect(x: 100, y: 180, width: 200, height: 100))
        yellowView.backgroundColor = UIColor.yellow
        // 锚点属性 以哪个位置旋转
        yellowView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        self.view.addSubview(yellowView)
        
        blueView = UIView(frame: CGRect(x: 40, y: 40, width: 100, height: 100))
        blueView.backgroundColor = UIColor.blue
        
        blueView.layer.borderColor = UIColor.purple.cgColor
        blueView.layer.borderWidth = 2
        
        // true 会把阴影裁剪
        blueView.layer.masksToBounds = false
        
        blueView.layer.shadowColor = UIColor.green.cgColor
        blueView.layer.shadowOpacity = 0.8
        // 001
        let squarePath = CGPath(rect: blueView.bounds, transform: nil)
        blueView.layer.shadowPath = squarePath
        // 002
//        blueView.layer.shadowOffset = CGSize(width: 0, height: 5)
        blueView.layer.shadowRadius = 5
        
        // 锚点属性 以哪个位置旋转
        blueView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        self.yellowView.addSubview(blueView)
        
        // mask
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.brown.cgColor
        maskLayer.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        let image3 = UIImage(named: "02.png") // 不是镂空
        maskLayer.contents = image3?.cgImage
        
        let imageV = UIImageView(frame: CGRect(x: 100, y: 300, width: 40, height: 40))
        let image2 = UIImage(named: "03.png") // 不是镂空
        imageV.image = image2
        self.view.addSubview(imageV)
        imageV.layer.mask = maskLayer
        
        // magnificationFilter
        let mLayer = CALayer()
        mLayer.backgroundColor = UIColor.brown.cgColor
        mLayer.frame = CGRect(x: 100, y: 350, width: 50, height: 50)
        let image4 = UIImage(named: "02.png")
        mLayer.contents = image4?.cgImage
//        mLayer.magnificationFilter = kCAFilterLinear
//        mLayer.minificationFilter = kCAFilterLinear
        self.view.layer.addSublayer(mLayer)
        
    }
    
}

extension SourceViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // zPostion：view在z轴的位置
        myView.layer.zPosition = 1.0
        // 点击哪个图层
        // 001 -- contains
        // 获取点击屏幕的点
        var point = touches.first?.location(in: self.view)
        // 这个点在yellowView层的点是哪
        point = yellowView.layer.convert(point!, from: self.view.layer)
        // 这个点是不是在yellowView层
        if yellowView.layer.contains(point!) {
            // 这个点在blueView层的点是哪
            point = blueView.layer.convert(point!, from: yellowView.layer)
            // 这个点是否在blue层
            if blueView.layer.contains(point!) {
                print("blue")
            }else {
                print("yellow")
            }
        } else {
            print("self.view")
        }
        
        // 002 -- hitTest
        let point1 = touches.first?.location(in: self.view)
        let layer =  yellowView.layer.hitTest(point1!)
        if yellowView.layer == layer {
            print("yellow")
        } else if blueView.layer == layer {
            print("blue")
        } else {
            print("self.view")
        }
    }
}

extension SourceViewController: CALayerDelegate {
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        ctx.setLineWidth(2)
        ctx.setStrokeColor(UIColor.yellow.cgColor)
        ctx.strokeEllipse(in: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    func layerWillDraw(_ layer: CALayer) {
        
    }
    
}
extension SourceViewController {
    
    @IBAction func present(_ sender: Any) {
        /*
         1、transitioningDelegate
         2、modalPresentationStyle
         */
        let vc = TargetViewController()
        vc.transitioningDelegate = d
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func push(_ sender: Any) {
        let vc = TargetViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
