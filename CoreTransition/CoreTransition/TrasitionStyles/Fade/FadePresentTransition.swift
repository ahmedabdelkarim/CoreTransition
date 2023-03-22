//
//  FadePresentTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class FadePresentTransition: CTTransition {
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get transition container
        let transitionContainer = transitionContext.containerView
        
        // get required views
        guard let presentingVC = transitionContext.getPresentingViewController(),
              let presentedView = transitionContext.getPresentedView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // calculate animation values
        let presentingViewInitialFrame = transitionContext.initialFrame(for: presentingVC)
        
        // set initial values
        presentedView.frame = presentingViewInitialFrame
        presentedView.alpha = 0
        
        // add presentedView in transition container
        transitionContainer.addSubview(presentedView)
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            presentedView.alpha = 1
        }
        
        return animator
    }
}
