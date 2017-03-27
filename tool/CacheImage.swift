//
//  CacheImage.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/27.
//  Copyright © 2017年 houjianan. All rights reserved.
//

/*
 -- API --
 1、The NSCache class incorporates various auto-eviction policies, which ensure that a cache doesn’t use too much of the system’s memory. If memory is needed by other applications, these policies remove some items from the cache, minimizing its memory footprint.
 
 2、You can add, remove, and query items in the cache from different threads without having to lock the cache yourself.
 
 3、Unlike an NSMutableDictionary object, a cache does not copy the key objects that are put into it.
 
 / 线程安全 不用加锁 自动删除 减少内存占用 不需要实现NSCopying/
 */

import UIKit

class GA_ImageLoader {
    
    static let instance : GA_ImageLoader = GA_ImageLoader()
    
    class var sharedLoader : GA_ImageLoader {
        return instance
    }
    
    // 使用NSCache
    var cache = NSCache<AnyObject, AnyObject>()

    
    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        // 异步获取图片
        DispatchQueue.global().async {
            // 从缓存中取
            let data: Data? = self.cache.object(forKey: urlString as AnyObject) as? Data
            // 缓存中存在直接去除并在主线程返回
            if let goodData = data {
                let image = UIImage(data: goodData as Data)
                DispatchQueue.main.async {
                    completionHandler(image, urlString)
                }
                return
            }
            // 不存在去下载 使用 URLSession
            let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) in
                if (error != nil) {
                    completionHandler(nil, urlString)
                    return
                }
                // 获得图片并且保存 主线程返回
                if data != nil {
                    let image = UIImage(data: data!)
                    self.cache.setObject(data as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async {
                        completionHandler(image, urlString)
                    }
                    return
                }
            })
            downloadTask.resume()
        }
    }
}
