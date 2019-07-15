//
//  UserViewController.swift
//  RedditBest
//
//  Created by Bhavik Soni on 15/07/19.
//  Copyright © 2019 Bhavik Soni. All rights reserved.
//

import UIKit

class SideTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to), let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
        
        if isPresenting{
            containerView.addSubview(toViewController.view)
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        let transfrom = { toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0) }
    
        let identity = {
            fromViewController.view.transform = .identity
        }
        
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transfrom() : identity()
        } ){ (_) in
            transitionContext.completeTransition(!isCancelled)
        }
    
    
    }
    

   
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
