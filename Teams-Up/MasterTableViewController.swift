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
    let playersDataSource = PlayersDataSource()
    var teamA = [Player]()
    var teamB = [Player]()
    var sortedGroup = [AnyObject]()

    @IBOutlet weak var popViewTextField: UITextField!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD

=======
        /// Setting the background image.
        tableView.backgroundColor = UIColor.blackColor()
        
>>>>>>> origin/my-develop-branch
        /// Calling the method that loads the Nib
        xibSetup()
        popViewTextField.delegate = self
        
        /// Calling the method that updates the header.
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
<<<<<<< HEAD
        if players.count == 0 {
            headerLabel.alpha = 0
            tableView.backgroundView = UIImageView(image: UIImage(named: "Background Empty"))
        } else {
            headerLabel.alpha = 1.0
            headerLabel.text = "Players: \(players.count)"
            tableView.backgroundView = nil
            tableView.backgroundColor = UIColor.blackColor()
        }
=======
        headerLabel.text = "Players: \(playersDataSource.numberOfRows)"
>>>>>>> origin/my-develop-branch
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return playersDataSource.numberOfSections
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersDataSource.numberOfRows
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("player cell", forIndexPath: indexPath) as! PlayerTableViewCell

        
        guard let player = playersDataSource.playerAtIndexPath(indexPath) else {
            return cell
        }
        
        cell.playerNameLabel.text = player.name
        cell.starRating.rating = player.rating
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
            
            if let _ = playersDataSource.removePlayerAtIndexPath(indexPath) {
                updateHeader()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } else {
                // TODO: Player could not be removed, display an error message
            }
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "teams" {
            let teamTableViewController = segue.destinationViewController as! TeamTableViewController
            
            /// This sorts the players in order from high to low
            let players = playersDataSource.players
            let sortedGroup = players.sort { (player: Player, player2: Player) -> Bool in
                let player = player.rating < player2.rating
                return player
            }
            /// Assigning each player to a team
            for player in sortedGroup {
                if sortedGroup.count > 0 {
                    if teamA.count >= teamB.count {
                        teamB.append(player)
                    } else if teamB.count >= teamA.count {
                        teamA.append(player)
                    }
                }
            }
            
            /// Creating the instances of Teams to be sent to the TeamTableViewController, with players in them.
            let team1 = Teams(team: "Team 1", player: teamA)
            let team2 = Teams(team: "Team 2", player: teamB)
           
            teamTableViewController.teams += [team1, team2]

        }
    }
    
    /// Removes the teams created, so that it will not double the teams on the TeamsTableViewController
    override func viewWillDisappear(animated: Bool) {
        teamA.removeAll()
        teamB.removeAll()
    }

    
    //////////////////////////////////////////////////// POP UP WINDOW ///////////////////////////////////////////////////////////
    
    // MARK: - POPUP WINDOW
    
    /// Properties & Outlets
    var popView: UIView!
    @IBOutlet weak var starRating: CosmosView!
    
    
    @IBAction func popViewAddButton(sender: UIButton) {
        if popViewTextField.text != ""{
            playersDataSource.addPlayer(name: popViewTextField.text!, rating: self.starRating.rating)
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
