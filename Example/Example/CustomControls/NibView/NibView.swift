//
//  NibView.swift
//  Example
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

@IBDesignable
class NibView: UIView {
    // MARK: - Variables
    /** Root view of xib file. */
    var xibRootView: UIView!
    
    // MARK: - Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup()
        setupUI()
    }
    
    // MARK: - Methods
    /** Setup view from xib file. */
    func xibSetup() {
        xibRootView = getXibView()
        fitXibView()
    }
    
    /** Loads instance of xib with the same name, and returns its root view. */
    func getXibView() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    /** Fits Xib view in container. */
    func fitXibView() {
        xibRootView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(xibRootView)
        //to show subviews added in IB or by code, last subview (which is xibRootView) must be sent back because at this point it was added on top of those subviews
        self.sendSubviewToBack(self.subviews.last!)
        
        //Constraints
        xibRootView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        xibRootView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        xibRootView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        xibRootView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setupUI() {
        
    }
}
