//
//  PresentingViewController.swift
//  Example
//
//  Created by Ahmed Abdelkarim on 24/07/2022.
//

import UIKit
import CoreTransition

class PresentingViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!// temp
    
    // MARK: - Properties
    var transitions: [Transition]?
    let transitionManager = CTTransitionManager()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTransitions()
        
        self.titleLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)// temp
    }
    
    // MARK: - Methods
    func showTransitions() {
        guard let transitions = transitions else {
            return
        }
        
        for i in 0..<transitions.count {
            let transition = transitions[i]
            addView(for: transition, index: i)
        }
    }
    
    func addView(for transition: Transition, index: Int) {
        let view = getPresentingView(for: transition)
        view.tag = index
        addView(view, for: transition)
        
        // Special case for morph
        if transition.style == nil {
            self.transitions?[index].style = .morph(originView: view)
        }
        
        handleClick(on: view, using: transition)
    }
    
    func getPresentingView(for transition: Transition) -> CardView {
        let view = CardView()
        view.stackView.axis = .horizontal
        view.title = transition.name
        if let icon = transition.icon {
            view.image = icon
        }
        else {
            view.imageView.isHidden = true
        }
        view.backgroundColor = transition.background
        view.borderColor = transition.borderColor
        view.titleColor = transition.titleColor
        view.cornerRadius = transition.cornerRadius
        
        return view
    }
    
    func addView(_ view: UIView, for transition: Transition) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(view)
        
        view.widthAnchor.constraint(equalToConstant: transition.size?.width ?? 270).isActive = true
        view.heightAnchor.constraint(equalToConstant: transition.size?.height ?? 80).isActive = true
    }
    
    func handleClick(on view: CardView, using transition: Transition) {
        view.clicked = present
    }
    
    @objc func present(_ view: CardView) {
        let index = view.tag
        guard let transition = transitions?[index] else {
            return
        }
        
        applyTransition(transition)
    }
    
    func applyTransition(_ transition: Transition) {
        let vc = getPresentedVC()
        vc.transition = transition
        
        if transition.background != .clear {
            vc.view.backgroundColor = transition.background
        }
        
        if let transitionStyle = transition.style {
            transitionManager.transition(from: self, to: vc, style: transitionStyle, duration: transition.duration)
        }
    }
    
    func getPresentedVC() -> PresentedViewController {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PresentedViewController") as! PresentedViewController
        
        return vc
    }
    
    // MARK: - Actions
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Morph", message: "Description...", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            alert.dismiss(animated: true)
        }))
        
        //self.providesPresentationContextTransitionStyle = true
        
        alert.modalPresentationStyle = .custom
        
        //alert.definesPresentationContext = true
        
        alert.view.backgroundColor = .cyan
        
        
        //present(alert, animated: false)
        
        let al = AlertViewController()
        
        infoButton.layer.cornerRadius = 10.5
        
        transitionManager.transition(from: self, to: al, style: .morph(originView: infoButton))
    }
    
    @IBOutlet weak var cardview: UIView!
    
    @IBAction func viewTap(_ sender: Any) {
        let vc = CardViewController()
        
        transitionManager.transition(from: self, to: vc, style: .morph(originView: cardview), duration: 1)
    }
    
}
