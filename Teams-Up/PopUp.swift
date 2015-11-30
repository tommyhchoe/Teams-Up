//
//  PopUp.swift
//  Teams-Up
//
//  Created by Jhoan Arango on 11/29/15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import Foundation
import UIKit


class PopUp: UITableViewController {
    var popUpWindow: UIImageView!

    func ViewFunc() {
        
        /// Creating of the popup window with a background image
        popUpWindow = UIImageView(image: UIImage(named: "Pop Window"))
        popUpWindow?.frame = CGRect(x: 47, y: 116, width: 280, height: 150)
        popUpWindow?.alpha = 0.50
        popUpWindow.hidden = false
        popUpWindow.userInteractionEnabled = true
        /// Displays the Popup Window
        view.addSubview(popUpWindow!)
        
        /// Add Button
        let addButton = UIButton(frame: CGRect(x: 190 , y: 138, width: 41, height: 29))
        addButton.setTitle("Add", forState: .Normal)
        addButton.tintColor = UIColor.whiteColor()
        /// Displays the Add button.
        popUpWindow?.addSubview(addButton)
        
        /// Done Button
        let doneButton = UIButton(frame: CGRect(x: 50, y: 138, width: 45, height: 29))
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.tintColor = UIColor.whiteColor()
        doneButton.addTarget(self, action: "done:", forControlEvents: UIControlEvents.TouchUpInside)
        /// Displays the Done Button
        popUpWindow?.addSubview(doneButton)
        
        /// Add Player Label
        let addPlayerLabel = UILabel(frame: CGRect(x: 95 , y: 15, width: 90, height: 29))
        addPlayerLabel.text = "Add Player"
        addPlayerLabel.textColor = UIColor.whiteColor()
        /// Displays the Add Player Label
        popUpWindow.addSubview(addPlayerLabel)
        
        /// Add Text Field
        let textField = UITextField(frame: CGRect(x: 36, y: 55, width: 210, height: 28))
        textField.placeholder = "Name"
        textField.alpha = 1.0
        textField.textColor = UIColor.whiteColor()
        textField.backgroundColor = UIColor(red: 98/255, green: 96/255, blue: 96/255, alpha: 90)
        textField.layer.cornerRadius = 5.0
        textField.keyboardAppearance = .Dark
        popUpWindow.addSubview(textField)
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.popUpWindow.alpha = 0.88
            self.popUpWindow?.frame = CGRect(x: 47, y: 146, width: 280, height: 190)
            }, completion: nil)
    }
    
    /// Hide the popUp window
    func done(sender: UIButton){
     popUpWindow.hidden = true
        
    }
    

}
