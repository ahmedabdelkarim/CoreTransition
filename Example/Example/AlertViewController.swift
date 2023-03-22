//
//  AlertViewController.swift
//  Example
//
//  Created by Ahmed Abdelkarim on 05/08/2022.
//

import UIKit

class AlertViewController: UIViewController {
    
    @IBOutlet weak var dimView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.dimView.alpha = 1
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.dimView.alpha = 0.5
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
}
