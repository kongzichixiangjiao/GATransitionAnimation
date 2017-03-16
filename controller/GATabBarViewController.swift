//
//  GATabBarViewController.swift
//  GA_TransitionAnimation
//
//  Created by houjianan on 2017/3/16.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class GATabBarViewController: UITabBarController {

    private let tabBarVCDelegate = GATabbarViewControllerDelegate()
    private var panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    private var subViewControllerCount: Int{
        let count = viewControllers != nil ? viewControllers!.count : 0
        return count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = tabBarVCDelegate
        
        panGesture.addTarget(self, action: #selector(GATabBarViewController.handlePan(panGesture:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func handlePan(panGesture: UIPanGestureRecognizer){
        let translationX =  panGesture.translation(in: view).x
        let translationAbs = translationX > 0 ? translationX : -translationX
        let progress = translationAbs / view.frame.width
        switch panGesture.state{
        case .began:
            tabBarVCDelegate.interactive = true
            let velocityX = panGesture.velocity(in: view).x
            if velocityX < 0{
                if selectedIndex < subViewControllerCount - 1{
                    selectedIndex += 1
                }
            }else {
                if selectedIndex > 0{
                    selectedIndex -= 1
                }
            }
        case .changed:
            tabBarVCDelegate.interactionController.update(progress)
        case .cancelled, .ended:
            if progress > 0.3{
                tabBarVCDelegate.interactionController.completionSpeed = 0.99
                tabBarVCDelegate.interactionController.finish()
            }else{
                tabBarVCDelegate.interactionController.completionSpeed = 0.99
                tabBarVCDelegate.interactionController.cancel()
            }
            tabBarVCDelegate.interactive = false
        default: break
        }
    }
    
}
