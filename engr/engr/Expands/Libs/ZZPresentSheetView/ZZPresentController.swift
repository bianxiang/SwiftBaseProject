//
//  ZZPresentController.swift
//  SampleDemo
//
//  Created by duzhe on 16/7/26.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit
class ZZPresentController:UIPresentationController,UIViewControllerTransitioningDelegate {
    
    var presentationWrappingView: UIView? = nil // 被添加动画效果的view，在presentedViewController的基础上添加了其他效果
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom    // 这种模式不会移除fromViewController
    }
    
    override var presentedView : UIView? {
        return self.presentationWrappingView
    }
}

// MARK: - 两组对应的方法，实现自定义presentation
extension ZZPresentController {
    //present 将要执行
    override func presentationTransitionWillBegin() {
        let presentationWrapperView = UIView(frame: self.frameOfPresentedViewInContainerView) // 添加阴影效果
        
        /// 在重写父类的presentedView方法中，返回了self.presentationWrappingView，这个方法表示需要添加动画效果的视图
        /// 这里对self.presentationWrappingView赋值，从后面的代码可以看到这个视图处于视图层级的最上层
        self.presentationWrappingView = presentationWrapperView
        
        let presentationRoundedCornerView = UIView(frame: UIEdgeInsetsInsetRect(presentationWrapperView.bounds, UIEdgeInsetsMake(0, 0, 0, 0))) // 添加圆角效果
        presentationRoundedCornerView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        
        let presentedViewControllerWrapperView = UIView(frame: UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsetsMake(0, 0, 0, 0)))
        presentedViewControllerWrapperView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        let presentedViewControllerView = super.presentedView
        presentedViewControllerView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        presentedViewControllerView?.frame = presentedViewControllerWrapperView.bounds
        presentedViewControllerWrapperView.addSubview(presentedViewControllerView!)
        presentationRoundedCornerView.addSubview(presentedViewControllerWrapperView)
        presentationWrapperView.addSubview(presentationRoundedCornerView)
        
    }
    
    /// 如果present没有完成，把dimmingView和wrappingView都清空，这些临时视图用不到了
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            self.presentationWrappingView = nil
        }
    }
    
    /// dismiss结束时，把dimmingView和wrappingView都清空，这些临时视图用不到了
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.presentationWrappingView = nil
        }
    }
}

// MARK: - UI事件处理
extension ZZPresentController {
    func dimmingViewTapped(_ sender: UITapGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Autolayout
extension ZZPresentController {
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if let container = container as? UIViewController ,
            container == self.presentedViewController{
            self.containerView?.setNeedsLayout()
        }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if let container = container as? UIViewController ,
            container == self.presentedViewController{
            return container.preferredContentSize
        }
        else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }
    
    override var frameOfPresentedViewInContainerView : CGRect {
        let containerViewBounds = self.containerView?.bounds
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: (containerViewBounds?.size)!)
        let presentedViewControllerFrame = CGRect(x: containerViewBounds!.origin.x, y: containerViewBounds!.maxY - presentedViewContentSize.height, width: (containerViewBounds?.size.width)!, height: presentedViewContentSize.height)
        return presentedViewControllerFrame
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        self.presentationWrappingView?.frame = self.frameOfPresentedViewInContainerView
    }
}

// MARK: - 实现协议UIViewControllerTransitioningDelegate
extension ZZPresentController {
    
    @objc(animationControllerForPresentedController:presentingController:sourceController:) func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZZAnimator()
    }
    
    @objc(animationControllerForDismissedController:) func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZZAnimator()
    }
    
    
    @objc(presentationControllerForPresentedViewController:presentingViewController:sourceViewController:) func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        return self
//    }
//    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return ZZAnimator()
//    }
//    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return ZZAnimator()
//    }
    
}




class ZZAnimator: NSObject, UIViewControllerAnimatedTransitioning {
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
        
        let fromViewFinalFrame = transitionContext.finalFrame(for: fromViewController!)
        let toViewFinalFrame = transitionContext.finalFrame(for: toViewController!)
        
        if toView != nil {
            containerView.addSubview(toView!)
        }
        
        if isPresenting {
            toView?.frame = toViewFinalFrame
        }else {
            fromView?.frame = fromViewFinalFrame
        }
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        if isPresenting{
            toView?.alpha = 0
        }else{
            fromView?.alpha = 1
        }
        
        UIView.animate(withDuration: transitionDuration, animations: {
            if isPresenting{
                toView?.alpha = 1
            }else{
                fromView?.alpha = 0
            }
        }, completion: { (finished: Bool) -> Void in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }) 
    }
}
