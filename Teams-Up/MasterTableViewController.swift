//
//  MasterTableViewController.swift
//  Teams-Up
//
//  Created by Jhoan Arango on 11/27/15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: Properties & Outlets
    var players = [Player]()

    @IBOutlet weak var popViewTextField: UITextField!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Setting the background image.
        tableView.backgroundView = UIImageView(image: UIImage(named: "Star 3"))
        
        /// Loading the Nib View
        xibSetup()
        popViewTextField.delegate = self
        
        updateHeader()
    }

    // MARK: - Actions
    
    @IBAction func addButton(sender: UIBarButtonItem) {
        popView.hidden = false
        popViewTextField.becomeFirstResponder()
        popViewAnimation()
    }
    @IBAction func teamsButton(sender: UIBarButtonItem) {
        popViewTextField.text = ""
        self.popView.hidden = true
    }
    
    func updateHeader(){
        headerLabel.text = "Players: \(players.count)"
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("main cell", forIndexPath: indexPath) as! PlayerTableViewCell

        let player = players[indexPath.row]
        cell.playerNameLabel.text = player.name
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            players.removeAtIndex(indexPath.row)
            updateHeader()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - POPUP WINDOW
    var popView: UIView!
    
    
    @IBAction func popViewAddButton(sender: UIButton) {
        
        if popViewTextField.text != ""{
            let player = Player(name: popViewTextField.text!, rating: 0)
            players.append(player)
            tableView.reloadData()
            popViewTextField.text = ""
            updateHeader()
        }
    }
    
    @IBAction func doneButton(sender: UIButton) {
        popView.hidden = true
        /// Enables the tableViews scroll.
        tableView.scrollEnabled = true
        /// Hide the keyboard
        self.popView.endEditing(true)
    }
    
    func xibSetup() {
        /// Loading the Nib View
        popView = loadViewFromNib()
        popView.hidden = true
        popView.translatesAutoresizingMaskIntoConstraints = false
        /// Adding custom subview on top of  super view.
        self.view.addSubview(popView)
        
        /// Constraints to center the popView to the superview
        let popViewCenterXConstraint = NSLayoutConstraint(item: self.popView!, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let popViewCenterYConstraint = NSLayoutConstraint(item: self.popView!, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: -120)

        self.view.addConstraints([popViewCenterXConstraint,popViewCenterYConstraint])
        
        /// Disables the tableViews scroll
        tableView.scrollEnabled = false
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "PopupWindow", bundle: bundle)
       let popView = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return popView
    }
    
    /// Hides the keyboard when use presses done in the keyboard.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        /// Hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    /// Clears the text field and hides the popView
    func textFieldDidEndEditing(textField: UITextField) {
        popViewTextField.text = ""
        self.popView.hidden = true
    }
    
    func popViewAnimation() {
        /// Animation
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
            self.popView.center.y = 445
            }, completion: nil)
    }
}
