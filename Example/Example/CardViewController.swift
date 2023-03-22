//
//  CardViewController.swift
//  Example
//
//  Created by Ahmed Abdelkarim on 07/08/2022.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.titleLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 1, animations: {
            self.titleLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dismissButton.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 1, animations: {
            self.titleLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        })
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismissButton.isHidden = true
        
        dismiss(animated: true)
    }
}
