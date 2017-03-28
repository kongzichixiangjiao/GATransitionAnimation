//
//  OpenGLViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/27.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import OpenGLES

// http://www.cocoachina.com/special/2010/0126/404.html
// http://www.cocoachina.com/game/20090611/213.html
// http://www.cocoachina.com/game/20141127/10335.html
// http://www.cocoachina.com/game/20141127/10335.html
// http://sdgdfgdsfgfg.iteye.com/blog/1113829

class OpenGLViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let gl = EAGLContext(api: .openGLES1)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }

}
