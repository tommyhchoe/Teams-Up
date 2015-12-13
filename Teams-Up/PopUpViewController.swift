//
//  PopUpViewController.swift
//  Teams-Up
//
//  Created by Martin Wildfeuer on 12.12.15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import UIKit

private enum AnimationDirection {
    case In, Out
}

typealias CompletionBlock = (player: Player?, cancelled: Bool) -> Void

class PopUpViewController: UIViewController {

    @IBOutlet weak var shadowContainer: UIView!
    @IBOutlet weak var dialogContainer: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    var completion: CompletionBlock?
    var player: Player?
    
    private (set) var isVisible : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize shadow container appearance
        shadowContainer.layer.cornerRadius = 6
        shadowContainer.layer.shadowColor = UIColor.blackColor().CGColor
        shadowContainer.layer.shadowOffset = CGSize(width: 3, height: 3)
        shadowContainer.layer.shadowOpacity = 0.8
        view.alpha = 0
        
        // Customize layer appearance
        dialogContainer.layer.cornerRadius = 6
        dialogContainer.layer.borderWidth = 1
        dialogContainer.layer.borderColor = UIColor(red:0.2, green:0.42, blue:0.87, alpha:1.0).CGColor
        dialogContainer.clipsToBounds = true
        
        // Generally, this is not a good idea, we should also use constraints here
        // This was even more important if we supported interface rotation
        if let parentVC = parentViewController {
            view.frame = parentVC.view.frame
        }
        
        // Set the initial dialog position off screen
        topConstraint.constant = -150
        
        textField.delegate = self
    }

    func addPlayer(completion: CompletionBlock) {
        if isVisible {
            return
        }
        
        headerLabel.text = "Add Player"
        leftButton.setTitle("Done", forState: .Normal)
        rightButton.setTitle("Add", forState: .Normal)
        
        textField.text = ""
        starRating.rating = 3.0
        textField.becomeFirstResponder()
        
        self.completion = completion
        
        animate(.In)
    }
    
    func updatePlayer(player: Player, completion: CompletionBlock) {
        if isVisible {
            return
        }
        
        headerLabel.text = "Update Player"
        leftButton.setTitle("Cancel", forState: .Normal)
        rightButton.setTitle("Update", forState: .Normal)
        
        textField.text = player.name
        starRating.rating = player.rating
        textField.becomeFirstResponder()
        
        self.completion = completion
        
        animate(.In)
    }
    
    func dismiss() {
        animate(.Out)
        textField.resignFirstResponder()
    }
    
    private func animate(direction: AnimationDirection) {
        var position: CGFloat
        var alpha: CGFloat
        
        switch direction {
        case .In:
            position = 70
            alpha = 1.0
            isVisible = true
        case .Out:
            position = -150
            alpha = 0.0
            isVisible = false
        }
        
        topConstraint.constant = position
        
        UIView.animateWithDuration(0.8, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            self.view.alpha = alpha
            self.view.layoutIfNeeded()
        }) { (finished) -> Void in
        }
    }
    
    /*!
    Shakes our dialog to indicate missing input
    http://stackoverflow.com/questions/1632364/shake-visual-effect-on-iphone-not-shaking-the-device
    */
    private func shake() {
        let anim = CAKeyframeAnimation( keyPath:"transform" )
        anim.values = [
            NSValue( CATransform3D:CATransform3DMakeTranslation(-8, 0, 0 ) ),
            NSValue( CATransform3D:CATransform3DMakeTranslation( 8, 0, 0 ) )
        ]
        anim.autoreverses = true
        anim.repeatCount = 2
        anim.duration = 9/100
        
        shadowContainer.layer.addAnimation( anim, forKey:nil )
    }
}

// MARK: Button Actions

extension PopUpViewController {
    
    @IBAction func leftButtonTouched(sender: UIButton) {
        textField.resignFirstResponder()
        completion?(player: nil, cancelled: true)
    }
    
    @IBAction func rightButtonTouched(sender: UIButton) {
        guard let name = textField.text else {
            shake()
            return
        }
        
        guard !name.isEmpty else {
            shake()
            return
        }
        
        let player = Player(name: name, rating: starRating.rating)
        textField.text = ""
        starRating.rating = 3.0
        completion?(player: player, cancelled: false)
    }
}

// MARK: TextField Delegate

extension PopUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
