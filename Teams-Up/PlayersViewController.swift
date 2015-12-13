//
//  PlayersViewController.swift
//  Teams-Up
//
//  Created by Martin Wildfeuer on 12.12.15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    
    let playersDataSource = PlayersDataSource()
    let popUpViewController = PopUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Let this class be the tableViews delegate and dataSource
        // Dragging a tableViewController to the storyboard, this is
        // automatically hooked up for you. This can also be done in
        // storyboard via connections, but I prefer this way.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add the "add player" popUpView
        addChildViewController(popUpViewController)
        view.addSubview(popUpViewController.view)
        
        updateHeader()
    }
    
    func updateHeader() {
        // Changes the TableViews background when empty
        if playersDataSource.numberOfRows == 0 {
            headerLabel.alpha = 0
            tableView.backgroundView = UIImageView(image: UIImage(named: "Background Empty"))
        } else {
            headerLabel.alpha = 1.0
            tableView.backgroundView = nil
            tableView.backgroundColor = UIColor.blackColor()
            headerLabel.text = "Players: \(playersDataSource.numberOfRows)"
        }
    }
}


// MARK: TableView DataSource

extension PlayersViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return playersDataSource.numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersDataSource.numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("player cell", forIndexPath: indexPath) as! PlayerTableViewCell
        
        guard let player = playersDataSource.playerAtIndexPath(indexPath) else {
            return cell
        }
        
        cell.playerNameLabel.text = player.name
        cell.starRating.rating = player.rating
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            if let _ = playersDataSource.removePlayerAtIndexPath(indexPath) {
                updateHeader()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } else {
                // TODO: Player could not be removed, display an error message
            }
            
        }
    }
    
}


// MARK: TableView Delegate

extension PlayersViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let player = playersDataSource.playerAtIndexPath(indexPath) else {
            return
        }
        
        popUpViewController.updatePlayer(player) { (player, cancelled) -> Void in
            if !cancelled {
                if let player = player {
                    if let _ = self.playersDataSource.updatePlayerAtIndexPath(indexPath, player: player) {
                        self.tableView.reloadData()
                    } else {
                        // TODO: Player could not be updated, display error message
                    }
                }
            }
            self.popUpViewController.dismiss()
        }
    }
}


// MARK: - Segue transition

extension PlayersViewController {
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "teams" {
            
            // TODO: this logic has to be moved either to its designated
            // view controller or a helper class
            let teamTableViewController = segue.destinationViewController as! TeamTableViewController
            
            var teamA = [Player]()
            var teamB = [Player]()
            
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
}

// MARK: Actions

extension PlayersViewController {
    
    @IBAction func addPlayerTouched(sender: UIBarButtonItem) {
        popUpViewController.addPlayer { (player, cancelled) -> Void in
            if !cancelled {
                if let player = player {
                    self.playersDataSource.addPlayer(player)
                    self.updateHeader()
                    self.tableView.reloadData()
                }
            } else {
                self.popUpViewController.dismiss()
            }
        }
    }
}
