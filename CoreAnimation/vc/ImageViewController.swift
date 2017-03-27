//
//  ImageViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/27.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import ImageIO

class ImageViewController: UIViewController, CALayerDelegate {
    
    lazy var imageV: UIImageView = {
        let i = UIImageView()
        i.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        return i
    }()
    
    lazy var tiledLayer: CATiledLayer? = {
        let t = CATiledLayer()
        t.frame = self.imageV.bounds
        t.contentsScale = UIScreen.main.scale
        t.tileSize = CGSize(width: self.imageV.bounds.size.width * UIScreen.main.scale, height: self.imageV.bounds.size.height * UIScreen.main.scale)
        t.delegate = self
        t.setValue("row", forKey: "indexPath.row")
        return t
    }()
    
    let urlString = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1491226670&di=f2543c3043646d5be0ae672116c8d68b&imgtype=jpg&er=1&src=http%3A%2F%2Fimg.taopic.com%2Fuploads%2Fallimg%2F140530%2F318753-1405300J54265.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageV)
        
        //        loadImage()
        //        loadImage1()
        //        loadImage2()
        //        loadImage3() // 夭折
                loadImage4()
    }
    
    func loadImage4() {
        GA_ImageLoader.sharedLoader.imageForUrl(urlString: urlString, completionHandler:
            { image, url in
                self.imageV.image = image
        })
    }
    
    func loadImage3() {
        
        self.imageV.layer.addSublayer(tiledLayer!)
        
        tiledLayer?.contents = nil
        tiledLayer?.setValue("row", forKey: "indexPath.row")
        tiledLayer?.setNeedsDisplay()
    }
    
    // CALayerDelegate
    func draw(_ layer: CALayer, in ctx: CGContext) {
        let indexPathRow = layer.value(forKey: "indexPath.row")
        
        //        let data = try! Data(contentsOf: URL(string: self.urlString)!)
        //        let image = UIImage(data: data)
        
        let image = UIImage(named: "01.jpg")
        
        image?.draw(in: self.imageV.bounds)
        
        UIGraphicsPopContext()
    }
    
    func loadImage2() {
        DispatchQueue.global().async {
            
            let data = try! Data(contentsOf: URL(string: self.urlString)!)
            var image = UIImage(data: data)
            UIGraphicsBeginImageContextWithOptions(self.imageV.bounds.size, true, 0)
            image?.draw(in: self.imageV.bounds)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                self.imageV.image = image
            }
        }
    }
    
    func loadImage1() {
        let url = URL(string: urlString)
        // kCGImageSourceShouldCache 表示是否在存储的时候就解码
        let options: NSDictionary = [kCGImageSourceShouldCache as String: NSNumber(value: true)]
        guard let source = CGImageSourceCreateWithURL(url as! CFURL, options) else {
            return
        }
        guard let imageRef = CGImageSourceCreateImageAtIndex(source, 0, options as CFDictionary) else {
            return
        }
        
        let image = UIImage(cgImage: imageRef)
        
        self.imageV.image = image
    }
    
    func loadImage() {
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: URL(string: self.urlString)!)
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.imageV.image = image
            }
        }
    }
    
    
}


