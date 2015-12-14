//
//  TeamTableViewController.swift
//  Teams-Up
//
//  Created by Jhoan Arango on 11/27/15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController {
    
    var teams = [Teams]()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    // MARK: Actions


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return teams.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let team = teams[section]
        let players = team.player.count
        return players
    }

    // Code by tommyhchoe
    /// Average team score displayed by string interpolation. This could use rework by using viewForHeading instead.
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let team = teams[section]
        var counter = 0.0
        let numOfPlayers = Double(team.player.count)
        
        for player in team.player{
            counter += Double(player.rating)
        }
        
        let avgTeamScore = round((counter / numOfPlayers) * 10) / 10
        return "\(team.team) \n Avg Score: \(avgTeamScore)"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("team cell", forIndexPath: indexPath) as! TeamTableViewCell

        let team = teams[indexPath.section]
        let player = team.player[indexPath.row]
        let name = player.name
        
        
        cell.teamPlayerLabel.text = name
        return cell
    }
    
    // Code by thedan84
    /// Logo VS for section 1
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section >= 1 {
            return nil
        }
    
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))

        let image = UIImage(named: "VS Oval")
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(footerView.center.x - 35, footerView.center.y, 70, 70)
        
        footerView.addSubview(imageView)
    
        return footerView
        
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80.0
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
