//
//  PresentedViewController.swift
//  Example
//
//  Created by Ahmed Abdelkarim on 24/07/2022.
//

import UIKit

class PresentedViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var descriptionLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTrailingConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var transition: Transition?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        display()
    }
    
    // MARK: - Methods
    private func display() {
        titleLabel.text = transition?.name
        descriptionLabel.text = transition?.description
        
        switch transition?.style {
            case .morph:
                descriptionLeadingConstraint.isActive = false
                descriptionTrailingConstraint.isActive = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + (transition?.duration ?? 0), execute: {
                    self.titleLabel.isHidden = false
                    self.dismissButton.isHidden = false
                })
            default:
                self.titleLabel.isHidden = false
                self.dismissButton.isHidden = false
        }
    }
    
    // MARK: - Actions
    @IBAction func dismiss(_ sender: Any) {
        switch transition?.style {
            case .morph:
                self.titleLabel.isHidden = true
                self.dismissButton.isHidden = true
            default:
                break
        }
        
        dismiss(animated: true, completion: nil)
    }
}
