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
