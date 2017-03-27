//
//  HomeViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/19.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import GLKit

class HomeViewController: UIViewController {
    
    var myView: UIView!
    
    var containtView: UIView!
    var labels: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        
//        let image = UIImage(named: "02.png")
//        myView = UIView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
//        
//        myView.backgroundColor = UIColor.orange
//        myView.layer.contents = image?.cgImage
//        myView.layer.contentsGravity = kCAGravityResizeAspect
//        self.view.addSubview(myView)
//        
//        var transform = CGAffineTransform.identity
//        // 组合
//        transform = transform.rotated(by: 40)
//        transform = transform.scaledBy(x: 0.2, y: 0.2)
//        transform = transform.translatedBy(x: 50, y: 0)
//        
//        // 旋转
//        // CGAffineTransform(rotationAngle: 40)
//        // 缩放
//        // CGAffineTransform(scaleX: 0.2, y: 0.2)
//        // 平移
//        // CGAffineTransform(translationX: 40, y: 0)
//        
////        myView.transform = transform
//        
//// ---------------------------------------
//        
//        // 剪切
//        var transformShear = CGAffineTransform.identity
//        transformShear.c = -1
//        transformShear.b = 0
//        
////        myView.transform = transformShear
//        
//// ---------------------------------------
//        
//        // layer层
////        myView.layer.transform = CATransform3DRotate(CATransform3DIdentity, 40, 0, 1, 1)
////        myView.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.3, 0.3, 0.5)
////        myView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 50)
//        
//        // CATransform3D的透视效果通过一个矩阵中一个很简单的元素来控制：m34。用于按比例缩放X和Y的值来计算到底要离视角多远。
//        var transform3D = CATransform3DIdentity
//        transform3D.m34 = -1 / 500
//        transform3D = CATransform3DRotate(transform3D, 40, 0, 1, 0)
//        
////        myView.layer.transform = transform3D
//
//// ---------------------------------------
//        
//        let myView1 = UIView(frame: CGRect(x: 10, y: 130, width: 100, height: 100))
//        
//        myView1.backgroundColor = UIColor.orange
//        myView1.layer.contents = image?.cgImage
//        myView1.layer.contentsGravity = kCAGravityResizeAspect
//        self.view.addSubview(myView1)
//        
//        // sublayerTransform 相同父视图上的子视图拥有相同的变换
////        var perspective = CATransform3DIdentity
////        perspective.m34 = -1 / 500
////        self.view.layer.sublayerTransform = perspective
//
//        let transform1 = CATransform3DMakeRotation(40, 0, 1, 0)
//        myView.layer.transform = transform1
//
//        let transform2 = CATransform3DMakeRotation(40, 0, 1, 0)
//        myView1.layer.transform = transform2
//        
//// ---------------------------------------
//        
//        // CALayer有一个叫做doubleSided的属性来控制图层的背面是否要被绘制。这是一个BOOL类型，默认为YES绘制，如果设置为NO不绘制。

//// ---------------------------------------
        
        containtView = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        containtView.backgroundColor = UIColor.orange
        self.view.addSubview(containtView)
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 500
        perspective = CATransform3DRotate(perspective, -45 * CGFloat(M_PI / 180), 1, 0, 0)
        perspective = CATransform3DRotate(perspective, -45 * CGFloat(M_PI / 180), 0, 1, 0)
        containtView.layer.sublayerTransform = perspective
        
        for i in 0..<6 {
            let l = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            l.textAlignment = .center
            l.font = UIFont.systemFont(ofSize: 90)
            l.text = String(i + 1)
            l.backgroundColor = UIColor.white
            l.isUserInteractionEnabled = false
            
            if i == 2 {
                labels.append(createFace(number: 2))
                containtView.addSubview(createFace(number: 2))
                continue
            }
                containtView.addSubview(l)
                labels.append(l)
        }
        
        var transform = CATransform3DMakeTranslation(0, 0, 100)
        addFace(index: 0, transform: transform)
        
        // CATransform3DMakeTranslation
        // CATransform3DRotate
        transform = CATransform3DMakeTranslation(100, 0, 0)
        transform = CATransform3DRotate(transform, 90 * CGFloat(M_PI / 180), 0, 1, 0)
        addFace(index: 1, transform: transform);
        
        
        transform = CATransform3DMakeTranslation(0, -100, 0)
        transform = CATransform3DRotate(transform, 90 * CGFloat(M_PI / 180), 1, 0, 0)
        addFace(index: 2, transform: transform)
        
        transform = CATransform3DMakeTranslation(0, 100, 0)
        transform = CATransform3DRotate(transform, -90 * CGFloat(M_PI / 180), 1, 0, 0)
        addFace(index: 3, transform: transform)
        
        transform = CATransform3DMakeTranslation(-100, 0, 0)
        transform = CATransform3DRotate(transform, -90 * CGFloat(M_PI / 180), 0, 1, 0)
        addFace(index: 4, transform: transform)
        
        transform = CATransform3DMakeTranslation(0, 0, -100)
        transform = CATransform3DRotate(transform, 180 * CGFloat(M_PI / 180), 0, 1, 0)
        addFace(index: 5, transform: transform)
 
        
//// ---------------------------------------
        
        containtView = UIView(frame: CGRect(x: 0, y: 200, width: 400, height: 400))
        containtView.backgroundColor = UIColor.white
        self.view.addSubview(containtView)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 175, y: 100))
        path.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 25, startAngle: 0, endAngle: 180 * CGFloat(M_PI / 180), clockwise: true)
        path.move(to: CGPoint(x: 150, y: 125))
        path.addLine(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 125, y: 225))
        path.move(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 175, y: 225))
        path.move(to: CGPoint(x: 100, y: 150))
        path.addLine(to: CGPoint(x: 200, y: 150))

        /*
        CAShapeLayer是一个通过矢量图形而不是bitmap来绘制的图层子类。
        1、渲染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
        2、高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
        3、不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。你的图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉（如我们在第二章所见）。
        4、不会出现像素化。当你给CAShapeLayer做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化。
        */
        /*
        let shaper = CAShapeLayer()
        shaper.fillColor = UIColor.clear.cgColor
        shaper.strokeColor = UIColor.orange.cgColor
        shaper.lineWidth = 5
        shaper.lineJoin = kCALineJoinMiter
        shaper.lineCap = kCALineCapRound
        shaper.path = path.cgPath
        containtView.layer.addSublayer(shaper)
         */
        
//// ---------------------------------------

        // 单独指定每个角
        /*
        let path1 = UIBezierPath(roundedRect: CGRect(x: 100, y: 100, width: 100, height: 100), byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        
        let shaper = CAShapeLayer()
        shaper.fillColor = UIColor.clear.cgColor
        shaper.strokeColor = UIColor.orange.cgColor
        shaper.lineWidth = 5
        shaper.lineJoin = kCALineJoinMiter
        shaper.lineCap = kCALineCapRound
        shaper.path = path1.cgPath
        containtView.layer.addSublayer(shaper)
         */
        
//// ---------------------------------------
        
        //create a text layer
        let textLayer = CATextLayer()
        textLayer.frame = containtView.bounds
        
        containtView.layer.addSublayer(textLayer)
        
        //set text attributes
        textLayer.foregroundColor = UIColor.brown.cgColor
        textLayer.alignmentMode = kCAAlignmentJustified
        textLayer.isWrapped = true
        
        //choose a font
        let font = UIFont.systemFont(ofSize: 15)
        let fontName = font.fontName
        let fontRef = CTFontCreateWithName(fontName as CFString?, 15, nil)

        //set layer font
        textLayer.font = fontRef
        textLayer.fontSize = font.pointSize
        textLayer.contentsScale = UIScreen.main.scale
        //choose some text
        let textString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet lobortis"
        
//        textLayer.string = textString
        
//// ---------------------------------------
        
        let attributedString = NSMutableAttributedString(string: textString)
        //convert UIFont to a CTFont
        //set text attributes
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(80, 100))
        attributedString.addAttribute(NSFontAttributeName, value: fontRef, range: NSMakeRange(100, 120))
        attributedString.addAttribute(NSUnderlineStyleAttributeName, value: 2, range: NSMakeRange(20, 60))
        attributedString.addAttribute(NSUnderlineColorAttributeName, value: UIColor.blue, range: NSMakeRange(20, 60))

        //set layer text
        textLayer.string = attributedString
        
//// ---------------------------------------
        
        let l = LayerLabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        l.text = "212312312fafa212312312fafa2123123112312fafa212312312fafa"
        l.textColor = UIColor.red
        l.font = UIFont.systemFont(ofSize: 12)
        self.view.addSubview(l)
    }
    
    func addFace(index: Int, transform: CATransform3D) {
        let f = self.labels[index]
        containtView.addSubview(f)
        let containerSize = self.containtView.bounds.size;
        f.center = CGPoint(x: containerSize.width / 2, y: containerSize.height / 2)
        f.layer.transform = transform
        applyLighting(face: f.layer)
    }
    
    func applyLighting(face: CALayer) {
        // 增加光线层
        let layer = CALayer()
        layer.frame = face.bounds
        face.addSublayer(layer)
        
        // 转换face的变形的矩阵
        // GLKMatrix4有和CATransform3D一样的结构
        let transform = face.transform
        let matrix4: GLKMatrix4 = GLKMatrix4Make(Float(transform.m11), Float(transform.m12), Float(transform.m13), Float(transform.m14), Float(transform.m21), Float(transform.m22), Float(transform.m23), Float(transform.m24), Float(transform.m31), Float(transform.m32), Float(transform.m33), Float(transform.m34), Float(transform.m41), Float(transform.m42), Float(transform.m43), Float(transform.m44))
        let matrix3: GLKMatrix3 = GLKMatrix4GetMatrix3(matrix4)
        
        // 获得face的正常向量
        var normal = GLKVector3Make(0, 0, 1)
        normal = GLKMatrix3MultiplyVector3(matrix3, normal)
        normal = GLKVector3Normalize(normal)
        
        // 获得与光向量的点积
        let light = GLKVector3Normalize(GLKVector3Make(0, 1, -0.5))
        let dotProduct = GLKVector3DotProduct(light, normal)
        
        // 设置光线层的透明度
        let shadow = 1 + CGFloat(dotProduct) - 0.5
        let color = UIColor(white: 0, alpha: shadow)
        layer.backgroundColor = color.cgColor
    }
    
    func getRandomColor() -> UIColor {
        // 创建随机颜色
        let red: CGFloat = CGFloat(arc4random() % 255) / 255.0
        let green: CGFloat = CGFloat(arc4random() % 255) / 255.0
        let blue: CGFloat = CGFloat(arc4random() % 255) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func createFace(number: NSInteger) -> UIView {
        // 创建表面视图
        let face = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        let faceSize = face.bounds.size
        face.backgroundColor = UIColor.white
        
        // 创建按钮
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.red
        button.alpha = 0.1
        button.tag = number
        // 将按钮移到中间
        button.center = CGPoint(x: faceSize.width / 2.0, y: faceSize.height / 2.0)
        
        // 将按钮加入表面
        face.addSubview(button)
        
        button.addTarget(self, action: #selector(HomeViewController.action(sender:)), for: .touchDown)
        
        // 创建标签
        let label = UILabel(frame: CGRect.zero)
        label.text = number.description
        label.textColor = getRandomColor()
        label.font = UIFont.systemFont(ofSize: 40)
        
        // 将标签放在中间
        label.sizeToFit()   // 用于将标签的bounds大小设为恰好符合
        label.center = CGPoint(x: faceSize.width / 2.0, y: faceSize.height / 2.0)
        
        // 将标签加入表面视图
        face.addSubview(label)
        
        return face
    }
    
    func action(sender: UIButton) {
        print(sender.tag)
        
        
        
    }
    
}




