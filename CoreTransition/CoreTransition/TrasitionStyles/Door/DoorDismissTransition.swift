//
//  DoorDismissTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim on 30/10/2021.
//

import UIKit

class DoorDismissTransition: CTTransition {
    let openingEdge: CTTransitionEdge
    
    // Smaller -> Closer to the 'camera', more distorted
    let skewFactor = CGFloat(1.0 / 1000.0)
    
    init(openingEdge: CTTransitionEdge) {
        self.openingEdge = openingEdge
    }
    
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        guard let presentingVC = transitionContext.getPresentingViewController(),
              let dismissingView = transitionContext.getDismissingView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // reset alpha to 1 because it was set to 0 in present transition
        dismissingView.alpha = 1
        
        // update screenshot of image to match presenting view at this time
        let screenshotImage = dismissingView.getScreenshot()
        
        let imageView = UIImageView(image: screenshotImage)
        
        // calculate animation values
        let dismissingViewInitialFrame = transitionContext.initialFrame(for: presentingVC)
        let imageViewInitialFrame = dismissingViewInitialFrame
        
        var imageRotationTransform = CATransform3DIdentity
        switch openingEdge {
            case .left:
                imageView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
                imageView.layer.position = CGPoint(x: imageViewInitialFrame.width, y: imageViewInitialFrame.height / 2)
                
                imageRotationTransform.m34 = skewFactor
                imageRotationTransform = CATransform3DRotate(imageRotationTransform, CGFloat.pi / 2, 0, 1, 0)
            case .right:
                imageView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
                imageView.layer.position = CGPoint(x: 0.0, y: imageViewInitialFrame.height / 2)
                
                imageRotationTransform.m34 = skewFactor
                imageRotationTransform = CATransform3DRotate(imageRotationTransform, -CGFloat.pi / 2, 0, 1, 0)
            case .top:
                imageView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
                imageView.layer.position = CGPoint(x: imageViewInitialFrame.width / 2, y: dismissingView.frame.height)
                
                imageRotationTransform.m34 = skewFactor
                imageRotationTransform = CATransform3DRotate(imageRotationTransform, -CGFloat.pi / 2, 1, 0, 0)
            case .bottom:
                imageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
                imageView.layer.position = CGPoint(x: imageViewInitialFrame.width / 2, y: 0.0)
                
                imageRotationTransform.m34 = skewFactor
                imageRotationTransform = CATransform3DRotate(imageRotationTransform, CGFloat.pi / 2, 1, 0, 0)
        }
        
        // set initial values
        imageView.frame = imageViewInitialFrame
        imageView.layer.transform = imageRotationTransform
        
        // MOST IMPORTANT: set z position to appear above other views
        imageView.layer.zPosition = 100
        
        // add views in transition container
        let transitionContainer = transitionContext.containerView
        transitionContainer.addSubview(imageView)
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            imageView.transform = .identity
        }
        
        return animator
    }
}
