//
//  PlayersDataSource.swift
//  Teams-Up
//
//  Created by Martin Wildfeuer on 11.12.15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//


import Foundation

/*!
*  The players data source takes care of adding and removing
*  players via NSUserDefaults. It also provides convenient methods
*  that can be used to minimize the code in the view controller.
*
*  Note:
*  Massive view controllers are a common problem with the MVC pattern,
*  see http://khanlou.com/2014/09/8-patterns-to-help-you-destroy-massive-view-controller/
*  on how to prevent this
*
*
*  TODO: Handle player updates
*
*/
struct PlayersDataSource {
    
    private let defaults: NSUserDefaults
    private let playersKey = "Players"
    
    init() {
        defaults = NSUserDefaults.standardUserDefaults()
    }
    
    /*!
    Init the dataSource with the given NSUserDefaults
    This is primarily for injecting fake user defaults
    with unit tests
    - parameter userDefaults: NSUserdefaults
    - returns: PlayersDataSource
    */
    init(userDefaults: NSUserDefaults) {
        defaults = userDefaults
    }
    
    /*!
    Saves the player array to the user defaults
    - parameter players: Array of players
    */
    private func savePlayers(players: [Player]) {
        let archivedPlayers = NSKeyedArchiver.archivedDataWithRootObject(players)
        defaults.setObject(archivedPlayers, forKey: playersKey)
    }
    
    /// Returns an array of players from the user defaults
    var players: [Player] {
        guard let playersData = defaults.objectForKey(playersKey) else {
            return [Player]()
        }
        
        // Nil coalescing operator
        // see https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/BasicOperators.html#//apple_ref/doc/uid/TP40014097-CH6-ID72
        return NSKeyedUnarchiver.unarchiveObjectWithData(playersData as! NSData) as? [Player] ?? [Player]()
    }
    
    /*!
    Returns the player for the given index,
    corresponds to the table view index path
    - parameter indexPath: tableView indexPath
    - returns: Player if found, otherwise nil
    */
    func playerAtIndexPath(indexPath: NSIndexPath) -> Player? {
        
        // Check if the indexPath.row is is valid
        guard players.indices ~= indexPath.row else {
            return nil
        }
        
        return players[indexPath.row]
    }
    
    /*!
    Adds a player instance to the storage
    - parameter player: Player instance
    */
    func addPlayer(player: Player) {
        var persistedPlayers = players
        persistedPlayers.append(player)
        savePlayers(persistedPlayers)
    }
    
    /*!
    Creates and adds a player instance to the storage
    - parameter name:   Player name
    - parameter rating: Player rating
    */
    func addPlayer(name name: String, rating: Double) {
        let player = Player(name: name, rating: rating)
        addPlayer(player)
    }

    /*!
    Removes the player at the given index path
    - parameter indexPath: tableView indexPath
    - returns: Player if removed successfully, otherwise nil
    */
    func removePlayerAtIndexPath(indexPath: NSIndexPath) -> Player? {
        
        guard players.indices ~= indexPath.row else {
            return nil
        }
        
        var persistedPlayers = players
        let removedPlayer = persistedPlayers.removeAtIndex(indexPath.row)
        savePlayers(persistedPlayers)
        
        return removedPlayer
    }
    
    /*!
    Removes all players from the storage
    */
    func removeAll() {
        defaults.removeObjectForKey(playersKey)
    }
}


// MARK: Data source for table views

extension PlayersDataSource {
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return players.count
    }
}
