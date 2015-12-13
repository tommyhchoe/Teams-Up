//
//  PlayersDataSourceTests.swift
//  Teams-Up
//
//  Created by Martin Wildfeuer on 11.12.15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//


import XCTest


class PlayersDataSourceTests: XCTestCase {
    
    let playersDataSource = PlayersDataSource(userDefaults: FakeUserDefaults(suiteName: "TeamsUpTest")! )
    
    override func setUp() {
        super.setUp()
        
        // Remove all players before running individual tests
        playersDataSource.removeAll()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatPlayerIsAddedCorrectly() {
        
        // Player list should be empty when running this test
        XCTAssertEqual(playersDataSource.numberOfRows, 0, "Players data source should be empty")
        
        playersDataSource.addPlayer(name: "Testname", rating: 4.0)
        
        XCTAssertEqual(playersDataSource.numberOfRows, 1, "Players data source should contain one entry")
        XCTAssertEqual(playersDataSource.players.count, 1, "Players data source should contain one entry")
        
        if let player = playersDataSource.players.first {
            XCTAssertEqual(player.name, "Testname", "Player name does not match expected player")
            XCTAssertEqual(player.rating, 4.0, "Player rating does not match expected player")
        } else {
            XCTFail("Player was not added to data source correctly")
        }
    }
    
    func testThatPlayerForIndexPathWorksCorrectly() {
        
        // Player list should be empty when running this test
        XCTAssertEqual(playersDataSource.numberOfRows, 0, "Players data source should be empty")
        
        playersDataSource.addPlayer(name: "TestnameOne", rating: 1.0)
        playersDataSource.addPlayer(name: "TestnameTwo", rating: 2.0)
        playersDataSource.addPlayer(name: "TestnameThree", rating: 3.0)
        
        let indexPath = NSIndexPath(forRow: 1, inSection: 1)
        
        if let player = playersDataSource.playerAtIndexPath(indexPath) {
            XCTAssertEqual(player.name, "TestnameTwo", "Player name does not match expected player")
            XCTAssertEqual(player.rating, 2.0, "Player rating does not match expected player")
        } else {
            XCTFail("Player was not added to data source correctly")
        }
    }
    
    func testThatPlayerForInvalidIndexPathWorksCorrectly() {
        
        // Player list should be empty when running this test
        XCTAssertEqual(playersDataSource.numberOfRows, 0, "Players data source should be empty")
        
        playersDataSource.addPlayer(name: "Testname", rating: 1.0)
        
        let indexPath = NSIndexPath(forRow: 2, inSection: 1)
        
        if let _ = playersDataSource.playerAtIndexPath(indexPath) {
            XCTFail("No player should be returned for invalid index paths")
        }
    }
    
    func testThatPlayerIsUpdatedCorrectly() {
        
        // Player list should be empty when running this test
        XCTAssertEqual(playersDataSource.numberOfRows, 0, "Players data source should be empty")
        
        playersDataSource.addPlayer(name: "TestnameOne", rating: 1.0)
        let updatedPlayer = Player(name: "TestnameNew", rating: 2.0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 1)
        playersDataSource.updatePlayerAtIndexPath(indexPath, player: updatedPlayer)
        
        XCTAssertEqual(playersDataSource.numberOfRows, 1, "Number of players does not match expected count")
        
        if let player = playersDataSource.playerAtIndexPath(indexPath) {
            XCTAssertEqual(player.name, "TestnameNew", "Player name does not match expected player")
            XCTAssertEqual(player.rating, 2.0, "Player rating does not match expected player")
        } else {
            XCTFail("Player was not updated correctly")
        }
        
    }
    
    func testThatPlayerIsRemovedCorrectly() {
        
        // Player list should be empty when running this test
        XCTAssertEqual(playersDataSource.numberOfRows, 0, "Players data source should be empty")
        
        playersDataSource.addPlayer(name: "TestnameOne", rating: 1.0)
        playersDataSource.addPlayer(name: "TestnameTwo", rating: 2.0)
        playersDataSource.addPlayer(name: "TestnameThree", rating: 3.0)
        
        XCTAssertEqual(playersDataSource.numberOfRows, 3, "Players data source entries count does not match expected result")
        
        let indexPath = NSIndexPath(forRow: 1, inSection: 1)
        
        if let removedPlayer = playersDataSource.removePlayerAtIndexPath(indexPath) {
            XCTAssertEqual(removedPlayer.name, "TestnameTwo", "Player name does not match expected player")
            XCTAssertEqual(removedPlayer.rating, 2.0, "Player rating does not match expected player")
        } else {
            XCTFail("Player was not removed from data source correctly")
        }
        
        XCTAssertEqual(playersDataSource.numberOfRows, 2, "Players data source entries count does not match expected result")
    }
    
}
