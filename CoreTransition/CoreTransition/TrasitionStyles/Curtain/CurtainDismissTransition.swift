//
//  CurtainDismissTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim on 28/10/2021.
//

import UIKit

class CurtainDismissTransition: CTTransition {
    let orientation: CTTransitionOrientation
    
    init(orientation: CTTransitionOrientation) {
        self.orientation = orientation
    }
    
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        guard let dismissingView = transitionContext.getDismissingView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // reset alpha to 1 because (it's set to 0 in present transition)
        dismissingView.alpha = 1
        
        // update screenshots of images to match presenting view at this time
        let (firstHalfImage, firstHalfFrame, secondHalfImage, secondHalfFrame) = orientation == .horizontal ? dismissingView.getHorizontalHalfImages() : dismissingView.getVerticalHalfImages()
        
        let firstImageView = UIImageView(image: firstHalfImage)
        let secondImageView = UIImageView(image: secondHalfImage)
        
        // calculate animation values
        let firstImageViewFinalFrame = firstHalfFrame
        var firstImageViewInitialFrame = firstHalfFrame
        switch orientation {
            case .horizontal:
                firstImageViewInitialFrame.origin.x = -firstHalfFrame.size.width
            case .vertical:
                firstImageViewInitialFrame.origin.y = -firstHalfFrame.size.height
        }
        
        let secondImageViewFinalFrame = secondHalfFrame
        var secondImageViewInitialFrame = secondHalfFrame
        switch orientation {
            case .horizontal:
                secondImageViewInitialFrame.origin.x = secondHalfFrame.size.width * 2
            case .vertical:
                secondImageViewInitialFrame.origin.y = secondHalfFrame.size.height * 2
        }
        
        // set initial values
        firstImageView.frame = firstImageViewInitialFrame
        secondImageView.frame = secondImageViewInitialFrame
        
        // add views in transition container
        let transitionContainer = transitionContext.containerView
        transitionContainer.addSubview(firstImageView)
        transitionContainer.addSubview(secondImageView)
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            firstImageView.frame = firstImageViewFinalFrame
            secondImageView.frame = secondImageViewFinalFrame
        }
        
        return animator
    }
}
