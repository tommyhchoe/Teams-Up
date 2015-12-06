//
//  PopupWindow.swift
//  Teams-Up
//
//  Created by Jhoan Arango on 12/3/15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import UIKit

@IBDesignable class PopupWindow: UIView {
    
    /// Our custom view from the XIB file
    var view: UIView!

    override init(frame: CGRect) {
        /// 1. setup any properties here
        
        /// 2. call super.init(frame:)
        super.init(frame: frame)
        
        /// 3. Setup view from .xib file
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func xibSetup() {
        view = loadViewFromNib()
        view = UIImageView(image: UIImage(named: "Pop Window"))
        
        /// use bounds not frame or it'll be offset
        view.frame = bounds
        
        /// Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        /// Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "PopupWindow", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }


}
