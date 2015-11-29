//
//  Teams.swift
//  Teams-Up
//
//  Created by Jhoan Arango on 11/28/15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import Foundation

class Team {
    let team: String
    let player: [Player]
    
    init(team: String, player: [Player]) {
        self.team = team
        self.player = player
    }
}