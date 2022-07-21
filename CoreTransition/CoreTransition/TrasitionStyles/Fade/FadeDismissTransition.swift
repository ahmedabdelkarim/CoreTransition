//
//  FadeDismissTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim on 21/10/2021.
//

import UIKit

class FadeDismissTransition: CTTransition {
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        guard let dismissedView = transitionContext.getDismissedView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            dismissedView.alpha = 0
        }
        
        return animator
    }
}
