//
//  CurtainZoomPresentTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class CurtainZoomPresentTransition: CTTransition {
    let orientation: CTTransitionOrientation
    
    init(orientation: CTTransitionOrientation) {
        self.orientation = orientation
    }
    
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get transition container
        let transitionContainer = transitionContext.containerView
        
        // get required views
        guard let presentingVC = transitionContext.getPresentingViewController(),
              let presentingView = transitionContext.getPresentingView(),
              let presentedView = transitionContext.getPresentedView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // get screenshot half images
        let (firstHalfImage, firstHalfFrame, secondHalfImage, secondHalfFrame) = orientation == .horizontal ? presentingView.getHorizontalHalfImages() : presentingView.getVerticalHalfImages()
        
        let firstImageView = UIImageView(image: firstHalfImage)
        let secondImageView = UIImageView(image: secondHalfImage)
        
        // calculate animation values
        let presentingViewInitialFrame = transitionContext.initialFrame(for: presentingVC)
        let firstImageViewInitialFrame = firstHalfFrame
        var firstImageViewFinalTransform = firstImageView.transform
        switch orientation {
            case .horizontal:
                firstImageViewFinalTransform = firstImageViewFinalTransform.translatedBy(x: -firstImageViewInitialFrame.size.width, y: 0)
            case .vertical:
                firstImageViewFinalTransform = firstImageViewFinalTransform.translatedBy(x: 0, y: -firstImageViewInitialFrame.size.height)
        }
        
        let secondImageViewInitialFrame = secondHalfFrame
        var secondImageViewFinalTransform = secondImageView.transform
        switch orientation {
            case .horizontal:
                secondImageViewFinalTransform = firstImageViewFinalTransform.translatedBy(x: secondImageViewInitialFrame.size.width * 2, y: 0)
            case .vertical:
                secondImageViewFinalTransform = firstImageViewFinalTransform.translatedBy(x: 0, y: secondImageViewInitialFrame.size.height * 2)
        }
        
        // set initial values
        presentedView.frame = presentingViewInitialFrame
        firstImageView.frame = firstImageViewInitialFrame
        secondImageView.frame = secondImageViewInitialFrame
        presentedView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        presentedView.layer.cornerRadius = presentedView.frame.width / 5
        
        presentingView.alpha = 0
        
        // add views in transition container
        transitionContainer.insertSubview(presentedView, at: 0)
        transitionContainer.addSubview(firstImageView)
        transitionContainer.addSubview(secondImageView)
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            firstImageView.transform = firstImageViewFinalTransform
            secondImageView.transform = secondImageViewFinalTransform
            
            presentedView.transform = CGAffineTransform(scaleX: 1, y: 1)
            presentedView.layer.cornerRadius = 0
        }
        
        // reset state
        transitionContext.resetState = {
            // remove images to free memory space
            firstImageView.removeFromSuperview()
            secondImageView.removeFromSuperview()
        }
        
        return animator
    }
}
