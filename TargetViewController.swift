//
//  ViewController.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/16.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class TargetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

