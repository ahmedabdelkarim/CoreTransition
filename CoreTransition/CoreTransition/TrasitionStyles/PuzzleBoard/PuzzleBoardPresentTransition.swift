//
//  PuzzleBoardPresentTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim on 18/11/2021.
//

import UIKit

class PuzzleBoardPresentTransition: CTTransition {
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        guard let presentingView = transitionContext.getPresentingView(),
              let presentedView = transitionContext.getPresentedView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // calculate translation bounds
        let minDimension = min(presentingView.frame.width, presentingView.frame.height)
        let translateMinX =  -minDimension
        let translateMaxX =  presentingView.frame.width + minDimension
        let translateMinY =  -minDimension
        let translateMaxY =  presentingView.frame.height + minDimension
        
        // add presentedView
        let transitionContainer = transitionContext.containerView
        transitionContainer.addSubview(presentedView)
        
        // get screenshot images
        var rows = 0, columns = 0
        
        if presentingView.frame.width < presentingView.frame.height {
            columns = 5
            rows = columns * Int(presentingView.frame.height / presentingView.frame.width)
        }
        else {
            rows = 5
            columns = rows * Int(presentingView.frame.width / presentingView.frame.height)
        }
        
        let portions = presentedView.getImagePortions(rows: rows, columns: columns)
        
        // setup portion images
        var portionImageViews = [UIImageView]()
        
        for rowPortions in portions {
            for portion in rowPortions {
                let portionImageView = UIImageView(image: portion.image)
                
                // set frame
                portionImageView.frame = portion.frame
                
                // set transform
                let randomX = CGFloat.randomFromRanges([translateMinX...(-portion.frame.width), (presentingView.frame.width)...translateMaxX])
                let randomY = CGFloat.randomFromRanges([translateMinY...(-portion.frame.height), (presentingView.frame.height)...translateMaxY])
                
                let translateRandomX = randomX - portion.frame.minX
                let translateRandomY = randomY - portion.frame.minY
                
                let initialTransform = CGAffineTransform(translationX: translateRandomX, y: translateRandomY).rotated(by: CGFloat.random(in: -60...60)).scaledBy(x: 1.5, y: 1.5)
                
                portionImageView.transform = initialTransform
                
                // add image view
                portionImageView.layer.zPosition = 100 // to make it appear above all other views
                
                transitionContainer.addSubview(portionImageView)
                
                portionImageViews.append(portionImageView)
            }
        }
        
        // hide presentedView
        presentedView.alpha = 0
        
        // setup animator
        
        // TODO: - animate all portions with the same duration (or at least they don't finish animation with each other)
        
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeOut)
        
        
        for imageView in portionImageViews {
            animator.addAnimations({
                imageView.transform = .identity
            }, delayFactor: CGFloat.random(in: 0...0.8))
        }
        
//        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeOut) {
//
//            for imageView in portionImageViews {
//                imageView.transform = .identity
//            }
//
//        }
        
        // reset state
        transitionContext.resetState = {
            presentedView.alpha = 1
            
            for imageView in portionImageViews {
                imageView.removeFromSuperview()
            }
        }
        
        return animator
    }
}
