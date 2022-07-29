//
//  CardView.swift
//  Example
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class CardView: NibView {
    // MARK: - Outlets
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Attributes
    @IBInspectable var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    @IBInspectable var title: String? {
        didSet {
            label.text = title
        }
    }
    
    @IBInspectable var background: UIColor? {
        didSet {
            if mainView != nil {
                mainView.backgroundColor = background
            }
        }
    }
    
    @IBInspectable var titleColor: UIColor? {
        didSet {
            label.textColor = titleColor
            imageView.tintColor = titleColor
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.systemIndigo {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 12 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Properties
    var clicked: ((CardView)->Void)?
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        self.layer.borderWidth = 2
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    // MARK: - Actions
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
            case .began:
                mainView.alpha = 0.5
            case .ended:
                mainView.alpha = 1
                clicked?(self)
            default:
                break
        }
    }
}
