//
//  MatchedMorphDismissTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim on 26/10/2021.
//

import UIKit

class MatchedMorphDismissTransition: CTTransition {
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        let fromVC = transitionContext.viewController(forKey: .from)!
        let fromView = fromVC.view!
        let toView = transitionContext.viewController(forKey: .to)!.view!
        
        // calculate animation values
        // let toViewFinalFrame = self.originView.superview?.convert(self.originView.frame, to: nil) ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        
        // set initial values
        
        let morphViewMap = getMorphViewMap(fromView: fromView, toView: toView)
        
        // var oldFrames = Dictionary<UIView, CGRect>()
        
//        for item in morphViewMap {
//            //oldFrames[item.value] = item.value.superview?.convert(item.value.frame, to: nil) ?? CGRect(x: 0, y: 0, width: 0, height: 0)
//
//            item.value.frame = item.key.superview?.convert(item.key.frame, to: nil) ?? CGRect(x: 0, y: 0, width: 0, height: 0)
//
//            item.value.layoutIfNeeded()
//        }
        
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .linear) {
            for item in morphViewMap {
                item.key.frame = item.value.superview?.convert(item.value.frame, to: nil) ?? CGRect(x: 0, y: 0, width: 0, height: 0)
            }
        }
        
        return animator
    }
}
