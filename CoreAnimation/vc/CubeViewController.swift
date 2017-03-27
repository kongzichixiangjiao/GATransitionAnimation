//
//  CubeViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/24.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import GLKit // 增加光线层

class CubeViewController: UIViewController {
    
    var labels: [UIView] = []
    
    lazy var myView: UIView = {
        let v = UIView(frame: CGRect(x: 140, y: 300, width: 200, height: 200))
        v.backgroundColor = UIColor.orange
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(myView)
        
        creatCube()
        
//        create3Dcube()
    }
    
    func creatCube() {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 500
        perspective = CATransform3DRotate(perspective, -CGFloat.GA_M_PI_4, 1, 0, 0)
        perspective = CATransform3DRotate(perspective, -CGFloat.GA_M_PI_4, 0, 1, 0)
        myView.layer.sublayerTransform = perspective

        for i in 0..<6 {
            let l = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            l.textAlignment = .center
            l.font = UIFont.systemFont(ofSize: 90)
            l.text = String(i + 1)
            l.backgroundColor = UIColor.white
            l.isUserInteractionEnabled = false
            
            if i == 2 {
                labels.append(createFace(number: 2))
                myView.addSubview(createFace(number: 2))
                continue
            }
            myView.addSubview(l)
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
    }
    
    func addFace(index: Int, transform: CATransform3D) {
        let f = self.labels[index]
        self.myView.addSubview(f)
        let containerSize = self.myView.bounds.size;
        f.center = CGPoint(x: containerSize.width / 2, y: containerSize.height / 2)
        f.layer.transform = transform
        
        applyLighting(face: f.layer)
    }
    // 给面增加光线层
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
        
        button.addTarget(self, action: #selector(CubeViewController.action(sender:)), for: .touchDown)
        
        // 创建标签
        let label = UILabel(frame: CGRect.zero)
        label.text = number.description
        label.textColor = UIColor.randomColor()
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
    
    //=====上面是平面创建cube方法--下面是3d创建立方体方法=====//
    
    func create3Dcube() {
        //set up the perspective transform
        var pt = CATransform3DIdentity
        pt.m34 = -1.0 / 500.0
        self.myView.layer.sublayerTransform = pt
        //set up the transform for cube 1 and add it
        var c1t = CATransform3DIdentity
        c1t = CATransform3DTranslate(c1t, -100, 0, 0);
        let cube1 = cube(transform: c1t)
        self.myView.layer.addSublayer(cube1)
        //
        var c2t = CATransform3DIdentity
        c2t = CATransform3DTranslate(c2t, 100, 0, 0);
        c2t = CATransform3DRotate(c2t, CGFloat.GA_M_PI_4, 1, 0, 0);
        c2t = CATransform3DRotate(c2t, CGFloat.GA_M_PI_4, 0, 1, 0);
        let cube2 = cube(transform: c2t)
        self.myView.layer.addSublayer(cube2)
    }

    func face(transform: CATransform3D) -> CALayer {
        let face = CALayer()
        face.frame = CGRect(x: -50, y: -50, width: 100, height: 100)
        face.backgroundColor = UIColor.randomCGColor()
        face.transform = transform
        return face
    }
    
    func cube(transform: CATransform3D) -> CALayer {
        let cube = CATransformLayer()
        // 1
        var ct = CATransform3DMakeTranslation(0, 0, 50)
        cube.addSublayer(face(transform: ct))
        // 2
        ct = CATransform3DMakeTranslation(50, 0, 0)
        ct = CATransform3DRotate(ct, CGFloat.GA_M_PI_2, 0, 1, 0)
        cube.addSublayer(face(transform: ct))
        // 3
        ct = CATransform3DMakeTranslation(0, -50, 0)
        ct = CATransform3DRotate(ct, CGFloat.GA_M_PI_2, 1, 0, 0)
        cube.addSublayer(face(transform: ct))
        // 4
        ct = CATransform3DMakeTranslation(0, 50, 0)
        ct = CATransform3DRotate(ct, -CGFloat.GA_M_PI_2, 1, 0, 0)
        cube.addSublayer(face(transform: ct))
        // 5
        ct = CATransform3DMakeTranslation(-50, 0, 0)
        ct = CATransform3DRotate(ct, -CGFloat.GA_M_PI_2, 0, 1, 0)
        cube.addSublayer(face(transform: ct))
        // 6
        ct = CATransform3DMakeTranslation(0, 0, 50)
        ct = CATransform3DRotate(ct, CGFloat.GA_M_PI, 0, 1, 0)
        cube.addSublayer(face(transform: ct))
        
        cube.position = CGPoint(x: myView.bounds.size.width / 2, y: myView.bounds.size.height / 2)
        cube.transform = transform
        
        return cube
    }
}

extension CGFloat {
    static var GA_M_PI: CGFloat = 180 * CGFloat(M_PI / 180)
    static var GA_M_PI_2: CGFloat = 90 * CGFloat(M_PI / 180)
    static var GA_M_PI_4: CGFloat = 45 * CGFloat(M_PI / 180)
}
