//
//  MasterTableViewController.swift
//  Teams-Up
//
//  Created by Jhoan Arango on 11/27/15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import UIKit

class MasterTableViewController: PopUp {
    
    // MARK: Properties & Outlets
        
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpWindow?.hidden = true
        
        let playerOne = Player(name: "Jhoan", rating: 5)
        let playerTwo = Player(name: "Harold", rating: 5)
        let playerThree = Player(name: "Daniel", rating: 5)
        let playerFour = Player(name: "Gustavo", rating: 5)
        let playerFive = Player(name: "Vicky", rating: 5)
        let playerSix = Player(name: "Leo", rating: 5)
        players.append(playerOne)
        players.append(playerTwo)
        players.append(playerThree)
        players.append(playerFour)
        players.append(playerFive)
        players.append(playerSix)
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "Star 3"))
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func addButton(sender: UIBarButtonItem) {
        if popUpWindow?.hidden != false {
        ViewFunc()
        }
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

}
