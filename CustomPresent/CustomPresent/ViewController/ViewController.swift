//
//  ViewController.swift
//  CustomPresent
//
//  Created by BaekSungwook on 2/10/18.
//  Copyright © 2018 BaekSungwook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segueIdentifier(for: segue) == .reveal,
            let destinationViewController = segue.destination as? TargetViewController {
            destinationViewController.transitioningDelegate = self
        }
    }


}

extension ViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case reveal
        case plan
    }
}


extension ViewController: UIViewControllerTransitioningDelegate {

    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
        
        guard let _ = presented as? TargetViewController else {
            return nil
        }
        
        return BottomPresentAnimationController(originFrame: self.view.frame)
    
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        guard let targetVC = dismissed as? TargetViewController else {
            return nil
        }
        
        return BottomDismissAnimationController(destinationFrame: self.view.frame, interactionController: targetVC.dismissInteractionController)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? BottomDismissAnimationController,
            let interactionController = animator.interactionController,
            interactionController.interactionInProgress
            else {
                return nil
        }
        return interactionController
    }
}
