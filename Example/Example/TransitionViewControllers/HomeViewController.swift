//
//  HomeViewController.swift
//  Example
//
//  Created by Ahmed Abdelkarim on 24/07/2022.
//

import UIKit
import CoreTransition

class HomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var fadeCard: CardView!
    @IBOutlet weak var zoomCard: CardView!
    @IBOutlet weak var coverCard: CardView!
    @IBOutlet weak var slideCard: CardView!
    @IBOutlet weak var curtainCard: CardView!
    @IBOutlet weak var curtainZoomCard: CardView!
    @IBOutlet weak var doorCard: CardView!
    @IBOutlet weak var windowCard: CardView!
    @IBOutlet weak var puzzleBoardCard: CardView!
    @IBOutlet weak var morphCard: CardView!
    
    // MARK: - Properties
    let transitionManager = CTTransitionManager()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleCards()
    }
    
    // MARK: - Methods
    func handleCards() {
        fadeCard.clicked = fade
        zoomCard.clicked = zoom
        coverCard.clicked = cover
        slideCard.clicked = slide
        curtainCard.clicked = curtain
        curtainZoomCard.clicked = curtainZoom
        doorCard.clicked = door
        windowCard.clicked = window
        puzzleBoardCard.clicked = puzzleBoard
        morphCard.clicked = morph
    }
    
    func getPresentingVC(for transitions: [Transition]) -> PresentingViewController {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PresentingViewController") as! PresentingViewController
        
        vc.modalPresentationStyle = .fullScreen
        vc.transitions = transitions
        
        return vc
    }
    
    // MARK: - Actions
    func show(_ transitions: [Transition]) {
        let vc = getPresentingVC(for: transitions)
        
        transitionManager.transition(from: self, to: vc, style: .cover(entranceEdge: .bottom), duration: 0.75)
    }
    
    func fade(_ view: CardView) {
        let transitions = [
            Transition(name: "Fade", description: "Fade in the presented view. Fade out when dismissed.", icon: UIImage(named: "fade"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .fade, duration: 1)
        ]
        
        show(transitions)
    }
    
    func zoom(_ view: CardView) {
        let transitions = [
            Transition(name: "Zoom", description: "Zoom in the presented view. Zoom out when dismissed.", icon: UIImage(named: "zoom"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .zoom, duration: 1)
        ]
        
        show(transitions)
    }
    
    func cover(_ view: CardView) {
        let transitions = [
            Transition(name: "Cover (Top)", description: "Presented view covers current view from top edge.", icon: UIImage(systemName: "chevron.down"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .cover(entranceEdge: .top), duration: 1),
            Transition(name: "Cover (Left)", description: "Presented view covers current view from left edge.", icon: UIImage(systemName: "chevron.right"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .cover(entranceEdge: .left), duration: 1),
            Transition(name: "Cover (Right)", description: "Presented view covers current view from right edge.", icon: UIImage(systemName: "chevron.left"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .cover(entranceEdge: .right), duration: 1),
            Transition(name: "Cover (Bottom)", description: "Presented view covers current view from bottom edge.", icon: UIImage(systemName: "chevron.up"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .cover(entranceEdge: .bottom), duration: 1)
        ]
        
        show(transitions)
    }
    
    func slide(_ view: CardView) {
        let transitions = [
            Transition(name: "Slide (Top)", description: "Presented view slides on current view from top edge.", icon: UIImage(systemName: "chevron.down"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .slide(entranceEdge: .top), duration: 1),
            Transition(name: "Slide (Left)", description: "Presented view slides on current view from left edge.", icon: UIImage(systemName: "chevron.right"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .slide(entranceEdge: .left), duration: 1),
            Transition(name: "Slide (Right)", description: "Presented view slides on current view from right edge.", icon: UIImage(systemName: "chevron.left"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .slide(entranceEdge: .right), duration: 1),
            Transition(name: "Slide (Bottom)", description: "Presented view slides on current view from bottom edge.", icon: UIImage(systemName: "chevron.up"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .slide(entranceEdge: .bottom), duration: 1)
        ]
        
        show(transitions)
    }
    
    func curtain(_ view: CardView) {
        let transitions = [
            Transition(name: "Curtain (Horizontal)", description: "Transition like curtain on a window to show the presented view. This is horizontal orientation.", icon: UIImage(named: "curtain"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .curtain(orientation: .horizontal), duration: 1.5),
            Transition(name: "Curtain (Vertical)", description: "Transition like curtain on a window to show the presented view. This is vertical orientation.", icon: UIImage(named: "curtain"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .curtain(orientation: .vertical), duration: 1.5)
        ]
        
        show(transitions)
    }
    
    func curtainZoom(_ view: CardView) {
        let transitions = [
            Transition(name: "Curtain Zoom\n(Horizontal)", description: "Transition like curtain on a window to show the presented view (zooming in). This is horizontal orientation.", icon: UIImage(named: "curtain-zoom"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .curtainZoom(orientation: .horizontal), duration: 1.5),
            Transition(name: "Curtain Zoom\n(Vertical)", description: "Transition like curtain on a window to show the presented view (zooming in). This is vertical orientation.", icon: UIImage(named: "curtain-zoom"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .curtainZoom(orientation: .vertical), duration: 1.5)
        ]
        
        show(transitions)
    }
    
    func door(_ view: CardView) {
        let transitions = [
            Transition(name: "Door (Top)", description: "Transition like door opening to show the presented view. This is top opening.", icon: UIImage(named: "door"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .door(openingEdge: .top), duration: 1.5),
            Transition(name: "Door (Left)", description: "Transition like door opening to show the presented view. This is left opening.", icon: UIImage(named: "door"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .door(openingEdge: .left), duration: 1.5),
            Transition(name: "Door (Right)", description: "Transition like door opening to show the presented view. This is right opening.", icon: UIImage(named: "door"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .door(openingEdge: .right), duration: 1.5),
            Transition(name: "Door (Bottom)", description: "Transition like door opening to show the presented view. This is bottom opening.", icon: UIImage(named: "door"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .door(openingEdge: .bottom), duration: 1.5)
        ]
        
        show(transitions)
    }
    
    func window(_ view: CardView) {
        let transitions = [
            Transition(name: "Window (Horizontal)", description: "Transition like window opening to show the presented view. This is horizontal opening.", icon: UIImage(named: "window"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .window(orientation: .horizontal), duration: 1.5),
            Transition(name: "Window (Vertical)", description: "Transition like window opening to show the presented view. This is vertical opening.", icon: UIImage(named: "window"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .window(orientation: .vertical), duration: 1.5)
        ]
        
        show(transitions)
    }
    
    func puzzleBoard(_ view: CardView) {
        let transitions = [
            Transition(name: "Puzzle Board", description: "Transition like puzzle board showing the presented view piece by piece. Hiding the presented view like crashed glass.", icon: UIImage(named: "puzzle-board"), background: .clear, borderColor: .systemIndigo, titleColor: .systemIndigo, cornerRadius: 12, style: .puzzleBoard, duration: 3)
        ]
        
        show(transitions)
    }
    
    func morph(_ view: CardView) {
        let transitions = [
            Transition(name: "Morph View 1", description: "Morph View 1", icon: nil, background: .systemIndigo, borderColor: .systemIndigo, titleColor: .white, cornerRadius: 0, style: nil, duration: 1, size: CGSize(width: 280, height: 120)),
            Transition(name: "Morph View 3", description: "Morph View 3", icon: nil, background: .systemPink, borderColor: .systemPink, titleColor: .white, cornerRadius: 30, style: nil, duration: 2, size: CGSize(width: 280, height: 120)),
            Transition(name: "Morph View 4", description: "Morph View 4", icon: nil, background: .black, borderColor: .black, titleColor: .white, cornerRadius: 75, style: nil, duration: 2.5, size: CGSize(width: 150, height: 150))
        ]
        
        show(transitions)
    }
}
