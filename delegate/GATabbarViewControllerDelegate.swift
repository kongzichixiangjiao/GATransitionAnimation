//
//  GATabbarViewControllerDelegate.swift
//  GA_TransitionAnimation
//
//  Created by houjianan on 2017/3/16.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class GATabbarViewControllerDelegate: NSObject, UITabBarControllerDelegate {
    var interactive = false
    weak var interactionController = UIPercentDrivenInteractiveTransition()
    
    // 手势执行动画 001
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        let fromIndex = tabBarController.viewControllers!.index(of: fromVC)!
        let toIndex = tabBarController.viewControllers!.index(of: toVC)!
        
        let tabChangeDirection: TabOperationDirection = toIndex < fromIndex ? TabOperationDirection.left : TabOperationDirection.right
        let transitionType = GATransitionType.tabTransition(tabChangeDirection)
        let slideAnimationController = GAAnimationViewController(type: transitionType)
        return slideAnimationController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        return interactive ? interactionController : nil
    }
    
    // 002 tabbar切换动画
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let transition = CATransition()
        transition.type = kCATransitionFade
        tabBarController.view.layer.add(transition, forKey: nil)
    }

}
