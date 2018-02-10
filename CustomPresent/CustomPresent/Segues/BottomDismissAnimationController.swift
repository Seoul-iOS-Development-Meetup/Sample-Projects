//
//  BottomDismissAnimationController.swift
//  CustomPresent
//
//  Created by BaekSungwook on 2/10/18.
//  Copyright © 2018 BaekSungwook. All rights reserved.
//

import Foundation
import UIKit

class BottomDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let destinationFrame: CGRect
    
    let interactionController: DissmissInteractionController?
        
    init(destinationFrame: CGRect, interactionController: DissmissInteractionController?) {
        self.destinationFrame = destinationFrame
        self.interactionController = interactionController
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
            else {
                return
        }
        

        snapshot.frame = destinationFrame
        snapshot.layer.masksToBounds = true
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, at: 0)
        containerView.addSubview(snapshot)
        fromVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            
            snapshot.frame = CGRect(x: 0, y: -self.destinationFrame.height, width: self.destinationFrame.width, height: self.destinationFrame.height)
            
        }) { (_) in
            
            fromVC.view.isHidden = false
            snapshot.removeFromSuperview()
            if transitionContext.transitionWasCancelled {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
            
        }
        
     
    }
}

