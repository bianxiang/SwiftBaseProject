//
//  SharePresentVC.swift
//  zuber
//
//  Created by duzhe on 16/8/10.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

class SharePresentCustomeVC: CustomPresentationController {
    
    override func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    override func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SharePresentAnimator()
    }
    
    override func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SharePresentAnimator()
    }
}


class SharePresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if let isAnimated = transitionContext?.isAnimated {
            return isAnimated ? 0.3 : 0
        }
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let isPresenting = (toViewController?.presentingViewController == fromViewController)
        
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromViewController!)
        var toViewInitialFrame = transitionContext.initialFrame(for: toViewController!)
        let toViewFinalFrame = transitionContext.finalFrame(for: toViewController!)
        
        if toView != nil {
            containerView.addSubview(toView!)
        }
        
        if isPresenting {
            toViewInitialFrame.origin = CGPoint(x: containerView.bounds.minX, y: containerView.bounds.maxY)
            toViewInitialFrame.size = toViewFinalFrame.size
            toView?.frame = toViewInitialFrame
        } else {
            fromViewFinalFrame = fromView!.frame.offsetBy(dx: 0, dy: fromView!.frame.height)
        }
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
//        if isPresenting{
//            if let rect = fromViewController?.view.frame{
//                fromViewController?.view.center = CGPoint(x: rect.width/2 , y:rect.height)
//                fromViewController?.view.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
//            }
//        }
        
//        UIView.animateWithDuration(transitionDuration*0.5, animations: { () -> Void in
//            if isPresenting {
//                
//                var trans = CATransform3DIdentity
//                trans.m34 = -1 / 1000
//                trans = CATransform3DRotate(trans, CGFloat(M_PI/18) , 1 , 0 , 0)
//                fromViewController?.view.layer.transform = trans
//                
//            }else{
//                
//                var trans = CATransform3DIdentity
//                trans.m34 = -1 / 1000
//                trans = CATransform3DRotate(trans, CGFloat(M_PI/18) , 1 , 0 , 0)
//                toViewController?.view.layer.transform = trans
//                
//            }
//            
//        }) { (b) -> Void in
//            UIView.animateWithDuration(transitionDuration*0.5, animations: { () -> Void in
//                if isPresenting {
//                    var trans = CATransform3DIdentity
//                    trans = CATransform3DScale(trans, 0.85, 0.95, 1)
//                    fromViewController?.view.layer.transform = trans
//                }else{
//                    toViewController?.view.layer.transform = CATransform3DIdentity
//                }
//            })
//        }
        
        UIView.animate(withDuration: transitionDuration, animations: {
            if isPresenting {
                toView?.frame = toViewFinalFrame
            }
            else {
                fromView?.frame = fromViewFinalFrame
            }
        }, completion: { (finished: Bool) -> Void in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }) 
    }
}
