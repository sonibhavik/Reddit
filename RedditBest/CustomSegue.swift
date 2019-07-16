//
//  CustomSegue.swift
//  RedditBest
//
//  Created by Bhavik Soni on 16/07/19.
//  Copyright © 2019 Bhavik Soni. All rights reserved.
////
//
//import UIKit
//
//class CustomSegue: UIStoryboardSegue {
//    override func perform() {
//        scale()
//    }
//    func scale(){
//        let toVC = "DetailPostView" as? DetailPostViewController
//        let fromVC = self.source
//        let containerView = fromVC.view.superview
//        let originalCenter = fromVC.view.center
//        
//        toVC!.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
//        toVC!.view.center = originalCenter
//        
//        containerView?.addSubview(toVC!.view)
//        
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
//            toVC!.view.transform = CGAffineTransform.identity
//        }, completion: { sucess in
//            fromVC.present(toVC!, animated: false, completion: nil)
//            
//        })
//        
//    }
//}
