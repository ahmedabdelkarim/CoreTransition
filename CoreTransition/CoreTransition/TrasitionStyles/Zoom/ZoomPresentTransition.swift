//
//  ZoomPresentTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class ZoomPresentTransition: CTTransition {
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get transition container
        let transitionContainer = transitionContext.containerView
        
        // get required views
        guard let presentingView = transitionContext.getPresentingView(),
              let presentedView = transitionContext.getPresentedView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // set initial values
        presentedView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        presentedView.layer.cornerRadius = presentedView.frame.width / 5
        presentedView.alpha = 0
        
        // add presentedView in transition container
        transitionContainer.addSubview(presentedView)
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            presentingView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            presentedView.transform = CGAffineTransform(scaleX: 1, y: 1)
            presentedView.layer.cornerRadius = 0
            presentedView.alpha = 1
        }
        
        return animator
    }
}
