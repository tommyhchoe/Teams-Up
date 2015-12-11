//
//  Player.swift
//  Teams-Up
//
//  Created by Jhoan Arango on 11/28/15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import Foundation


// Martin Wildfeuer sayz:
// Using an enum for keys instead of constants
// might be a bit too much for a class with only
// two properties. I like this approach though,
// as it keeps the class itself more readable.
// This is open for discussion

private enum Keys: String {
    case Name   = "Name"
    case Rating = "Rating"
}


class Player: NSObject, NSCoding {
    let name: String
    let rating: Double
    
    init(name: String, rating: Double){
        self.name = name
        self.rating = rating
    }
    
    // MARK: NSCoding compliance
    // We need this so we can persist our players via NSUserdefaults
    // NSUserdefaults does not store custom types by default, so we
    // need to store them as NSData via NSKeyedArchiver
    // see: PlayersDataSource
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(Keys.Name.rawValue) as! String
        rating = aDecoder.decodeDoubleForKey(Keys.Rating.rawValue)
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: Keys.Name.rawValue)
        aCoder.encodeDouble(rating, forKey: Keys.Rating.rawValue)
    }
}

