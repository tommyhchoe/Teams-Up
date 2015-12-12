//
//  PlayerTableViewCell.swift
//  Teams-Up
//
//  Created by Jhoan Arango on 11/27/15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import UIKit

protocol Test {
    func test(cell: PlayerTableViewCell)
}

class PlayerTableViewCell: UITableViewCell {
    
    var rating = 0
    
    // MARK: Properties & Outlets

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
