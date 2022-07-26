//
//  MorphDismissTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class MorphDismissTransition: CTTransition {
    let originView: UIView
    
    init(originView: UIView) {
        self.originView = originView
    }
    
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        guard let dismissedView = transitionContext.getDismissedView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // calculate animation values
        let dismissedViewFinalFrame = self.originView.superview?.convert(self.originView.frame, to: nil) ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        
        // set initial values
        let clipsToBounds = dismissedView.clipsToBounds // save clipsToBounds to reset after completion
        dismissedView.clipsToBounds = true
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            dismissedView.frame = dismissedViewFinalFrame
            dismissedView.layer.cornerRadius = self.originView.layer.cornerRadius
        }
        
        // reset state
        transitionContext.resetState = {
            // reset clipsToBounds to avoid changing normal state of VC
            dismissedView.clipsToBounds = clipsToBounds
        }
        
        return animator
    }
}
