//
//  CTTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim on 21/10/2021.
//

import UIKit

class CTTransition: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Properties
    private var animator: UIViewImplicitlyAnimating?
    var duration: TimeInterval = 0.75
    
    // MARK: - Methods
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }
    
    open func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // reuse animator if already initialized
        if let animator = self.animator {
            return animator
        }
        
        // build animator
        let animator = buildAnimator(using: transitionContext)
        
        // handle completion (TODO: don't duplicate addCompletion if handled inside subclass)
        animator.addCompletion? { _ in
            transitionContext.resetState?()
            transitionContext.completeTransition(true)
        }
        
        // save animator for reuse
        self.animator = animator
        
        return animator
    }
    
    /// Override this method inside subclass to build animator for each special transition.
    open func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let animator = UIViewPropertyAnimator.empty
        
        return animator
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.animator = nil
    }
}
