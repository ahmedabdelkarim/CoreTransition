//
//  MatchedMorphPresentTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class MatchedMorphPresentTransition: CTTransition {
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get transition container
        let transitionContainer = transitionContext.containerView
        
        // get required views
        let fromVC = transitionContext.viewController(forKey: .from)!
        let fromView = fromVC.view!
        let toView = transitionContext.view(forKey: .to)!
        
        // calculate animation values
        
        
        // set initial values
        
        let morphViewMap = getMorphViewMap(fromView: fromView, toView: toView)
        
        var oldFrames = Dictionary<UIView, CGRect>()
        
        for item in morphViewMap {
            oldFrames[item.value] = item.value.superview?.convert(item.value.frame, to: nil) ?? CGRect(x: 0, y: 0, width: 0, height: 0)
            
            item.value.frame = item.key.superview?.convert(item.key.frame, to: nil) ?? CGRect(x: 0, y: 0, width: 0, height: 0)
            
            item.value.layoutIfNeeded()
        }
        
        
        // add toView in transition container
        transitionContainer.addSubview(toView)
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .linear) {
            for item in morphViewMap {
                item.value.frame = oldFrames[item.value]!
            }
        }
        
        return animator
    }
}

func getMorphViewMap(fromView: UIView, toView: UIView) -> Dictionary<UIView, UIView> {
    var fromMorphIDs = Dictionary<String, UIView>()
    
    if let morphId = fromView.morphId {
        fromMorphIDs[morphId] = fromView
    }
    
    let fromSubViews = getFlattenedViewHierarchy(view: fromView)
    
    for view in fromSubViews {
        if let morphId = view.morphId {
            fromMorphIDs[morphId] = view
        }
    }
    
    
    var toMorphIDs = Dictionary<String, UIView>()
    
    if let morphId = toView.morphId {
        fromMorphIDs[morphId] = toView
    }
    
    let toSubViews = getFlattenedViewHierarchy(view: toView)
    
    for view in toSubViews {
        if let morphId = view.morphId {
            toMorphIDs[morphId] = view
        }
    }
    
    
    var morphViewMap = Dictionary<UIView, UIView>()
    
    for item in fromMorphIDs {
        if let matchedToView = toMorphIDs[item.key] {
            morphViewMap[item.value] = matchedToView
        }
    }
    
    return morphViewMap
}

func getFlattenedViewHierarchy(view: UIView) -> [UIView] {
    if view.subviews.count == 0 {
        return [view]
    }
    else {
        return [view] + view.subviews.flatMap { getFlattenedViewHierarchy(view: $0) }
    }
}
