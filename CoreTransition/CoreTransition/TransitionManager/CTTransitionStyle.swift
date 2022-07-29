//
//  CTTransitionStyle.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

/// Style of animation that will happen while transitioning from presenting to presented UIViewController, and vice versa. The animation is reversed on dismiss.
public enum CTTransitionStyle {
    case fade
    case zoom
    case cover(entranceEdge: CTTransitionEdge)
    case slide(entranceEdge: CTTransitionEdge)
    
    case curtain(orientation: CTTransitionOrientation)
    case curtainZoom(orientation: CTTransitionOrientation)
    case door(openingEdge: CTTransitionEdge)
    case window(orientation: CTTransitionOrientation)
    case puzzleBoard
    
    case morph(originView: UIView)
    case matchedMorph
    
    var descriptor: CTTransitionDescriptor {
        switch self {
            case .fade:
                return CTTransitionDescriptor(presentTransition: FadePresentTransition(), dismissTransition: FadeDismissTransition())
                
            case .zoom:
                return CTTransitionDescriptor(presentTransition: ZoomPresentTransition(), dismissTransition: ZoomDismissTransition())
                
            case .cover(let entranceEdge):
                return CTTransitionDescriptor(presentTransition: CoverPresentTransition(entranceEdge: entranceEdge), dismissTransition: CoverDismissTransition(entranceEdge: entranceEdge))
            
            case .slide(let entranceEdge):
                return CTTransitionDescriptor(presentTransition: SlidePresentTransition(entranceEdge: entranceEdge), dismissTransition: SlideDismissTransition(entranceEdge: entranceEdge))
             
            case .curtain(let orientation):
                return CTTransitionDescriptor(presentTransition: CurtainPresentTransition(orientation: orientation), dismissTransition: CurtainDismissTransition(orientation: orientation))
                
            case .curtainZoom(let orientation):
                return CTTransitionDescriptor(presentTransition: CurtainZoomPresentTransition(orientation: orientation), dismissTransition: CurtainZoomDismissTransition(orientation: orientation))
                
            case .door(let openingEdge):
                return CTTransitionDescriptor(presentTransition: DoorPresentTransition(openingEdge: openingEdge), dismissTransition: DoorDismissTransition(openingEdge: openingEdge))
                
            case .window(let orientation):
                return CTTransitionDescriptor(presentTransition: WindowPresentTransition(orientation: orientation), dismissTransition: WindowDismissTransition(orientation: orientation))
                
            case .puzzleBoard:
                return CTTransitionDescriptor(presentTransition: PuzzleBoardPresentTransition(), dismissTransition: PuzzleBoardDismissTransition(orientation: .horizontal))
                
            case .morph(let originView):
                return CTTransitionDescriptor(presentTransition: MorphPresentTransition(originView: originView), dismissTransition: MorphDismissTransition(originView: originView))
                
            case .matchedMorph:
                return CTTransitionDescriptor(presentTransition: MatchedMorphPresentTransition(), dismissTransition: MatchedMorphDismissTransition())
        }
    }
}
