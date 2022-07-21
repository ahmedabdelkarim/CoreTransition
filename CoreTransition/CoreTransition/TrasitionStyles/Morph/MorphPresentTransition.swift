//
//  MorphPresentTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim on 21/10/2021.
//

import UIKit

class MorphPresentTransition: CTTransition {
    let originView: UIView
    
    init(originView: UIView) {
        self.originView = originView
    }
    
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
        
        let presentedViewInitialFrame = self.originView.superview?.convert(self.originView.frame, to: nil) ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        let presentedViewFinalFrame = presentingViewInitialFrame
        
        // set initial values
        presentedView.frame = presentedViewInitialFrame
        presentedView.layer.cornerRadius = self.originView.layer.cornerRadius
        let clipsToBounds = presentedView.clipsToBounds // save clipsToBounds to reset after completion
        presentedView.clipsToBounds = true
        
        // apply auto layout to refresh positions
        presentedView.layoutIfNeeded()
        
        // add presentedView in transition container
        transitionContainer.addSubview(presentedView)
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            presentedView.frame = presentedViewFinalFrame
            presentedView.layer.cornerRadius = 0
        }
        
        // reset state
        transitionContext.resetState = {
            // reset clipsToBounds to avoid changing normal state of VC
            presentedView.clipsToBounds = clipsToBounds
        }
        
        return animator
    }
}
