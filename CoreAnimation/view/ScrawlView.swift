//
//  ScrawlView.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/27.
//  Copyright © 2017年 houjianan. All rights reserved.
//

/*
 这样实现的问题在于，我们画得越多，程序就会越慢。因为每次移动手指的时候都会重绘整个贝塞尔路径（UIBezierPath），随着路径越来越复杂，每次重绘的工作就会增加，直接导致了帧数的下降。看来我们需要一个更好的方法了。
 */

import UIKit

class ScrawlView: UIView {
    
    private let BRUSH_SIZE: CGFloat = 32
    
    var path: UIBezierPath!
    var strokes = [NSValue]()
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.classForCoder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initPath()
        
        initShapeLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initShapeLayer() {
        let shapeLayer = self.layer as! CAShapeLayer
        shapeLayer.strokeColor = UIColor.randomCGColor()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineWidth = 5;
    }
    
    func initPath() {
        self.path = UIBezierPath()
        self.path.lineJoinStyle = CGLineJoin.round
        self.path.lineCapStyle = CGLineCap.round
        self.path.lineWidth = 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {
            return
        }
        self.path.move(to: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {
            return
        }
        self.path.addLine(to: point)
        // 001
//        self.setNeedsDisplay()
        // 002
//        (self.layer as! CAShapeLayer).path = self.path.cgPath
        // 003
        strokes.append(NSValue.init(cgPoint: point))
        // 003.001
//        self.setNeedsDisplay()
        // 003.002
        setNeedsDisplay(brushRect(point))
    }
    
    func brushRect(_ point: CGPoint) -> CGRect{
       return CGRect(x: point.x - BRUSH_SIZE/2, y: point.y - BRUSH_SIZE/2, width: BRUSH_SIZE, height: BRUSH_SIZE)
    }
    
    override func draw(_ rect: CGRect) {
        // 001
        UIColor.clear.setFill()
        UIColor.orange.setStroke()
        self.path.stroke()
        
        // 003
        for value in strokes {
            let point = value.cgPointValue
            let brushRect = self.brushRect(point)
            let image = UIImage(named: "02.png")
            //only draw brush stroke if it intersects dirty rect
            if (rect.intersects(brushRect)) {
                image?.draw(in: brushRect)
            }
        }
    }
}
