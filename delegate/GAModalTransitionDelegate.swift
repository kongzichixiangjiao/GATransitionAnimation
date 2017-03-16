//
//  GAModalTransitionDelegate.swift
//  GA_TransitionAnimation
//
//  Created by houjianan on 2017/3/16.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class GAModalTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitionType = GATransitionType.modalTransition(.present)
        return GAAnimationViewController(type: transitionType)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitionType = GATransitionType.modalTransition(.dismiss)
        return GAAnimationViewController(type: transitionType)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return GAOverlayPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
