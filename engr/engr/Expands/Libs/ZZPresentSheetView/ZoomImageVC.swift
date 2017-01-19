//
//  ZoomImageVC.swift
//  zuber
//
//  Created by duzhe on 16/8/22.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation
/*

class ZoomImageVC: CustomPresentationController {
    override func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    override func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = ZoomImageAnimator()
        animator.originFrame = self.originImageFrame
        return animator
    }
    
    override func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = ZoomImageAnimator()
        animator.originFrame = self.originImageFrame
        return animator
    }
}




class ZoomImageAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame:CGRect? = nil
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        if let isAnimated = transitionContext?.isAnimated() {
            return isAnimated ? 0.3 : 0
        }
        return 0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containerView = transitionContext.containerView()
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let isPresenting = (toViewController?.presentingViewController == fromViewController)
        
        var fromViewFinalFrame = transitionContext.finalFrameForViewController(fromViewController!)
        var toViewInitialFrame = transitionContext.initialFrameForViewController(toViewController!)
        let toViewFinalFrame = transitionContext.finalFrameForViewController(toViewController!)
        
        if toView != nil {
            containerView.addSubview(toView!)
        }
        
        if isPresenting {
            toViewInitialFrame = originFrame!
            toView?.frame = toViewInitialFrame
        } else {
            fromViewFinalFrame = CGRectOffset(fromView!.frame, 0, CGRectGetHeight(fromView!.frame))
        }
        
        let transitionDuration = self.transitionDuration(transitionContext)

        UIView.animateWithDuration(transitionDuration, animations: {
            if isPresenting {
                toView?.frame = toViewFinalFrame
            }
            else {
                fromView?.frame = fromViewFinalFrame
            }
        }) { (finished: Bool) -> Void in
            let wasCancelled = transitionContext.transitionWasCancelled()
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}

 */
