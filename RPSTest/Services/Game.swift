//
//  Game.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import Foundation

protocol GameDelegate: AnyObject {
    
    /**
     Start game delegate
     - Parameter game: Current game instance
     */
    func gameStarted(_ game: Game)

    /**
     Game finished
     - Parameters
        - game: Current game instance
        - winner: Winner player instance, nil is draw
     */
    func gameFinished(_ game: Game, winner: Player?)
}

class Game {

    //MARK: - Private members
    private init() { }
    private var gameDispatch = DispatchGroup()
    
    private(set) var rules: Rules!
    private(set) var players: [Player]!
    private(set) var winner: Player?
    
    //MARK: - Constructor

    /**
     Game constructor
     - Parameter players: game players, min. 2
     */

    convenience init(players: [Player]) {
        assert(players.count > 1, "You can't start game with less than 2 players")
        
        self.init()
        self.rules = Tournament.rules
        self.players = players
    }
    
    //MARK: - Public members
    public weak var delegate: GameDelegate?
    
    public func start() {
        players.forEach { (player) in
            player.prepareForGame()
            gameDispatch.enter()
            player.startPlaying {
                self.gameDispatch.leave()
            }
        }
        gameDispatch.notify(queue: .main) {
            self.finish()
        }
        delegate?.gameStarted(self)
    }
    
    public func finish() {
        // Process game for two players with 3 possible results:
        // - First player wins
        // - Second player wins
        // - Draw
        let firstPlayer = players.first!
        let secondPlayer = players.last!
        
        
        firstPlayer.playerView?.showShape(firstPlayer.shape!)
        secondPlayer.playerView?.showShape(secondPlayer.shape!)
        
        let rule = firstPlayer.shape!.rules.first { (rules) -> Bool in
            return rules.key == secondPlayer.shape!.id
        }
        guard let value = rule?.value else {
            fatalError("No win rule for \(firstPlayer.shape!.id) & \(secondPlayer.shape!.id) shapes")
        }
        
        var winner: Player?
        if value == 1 {
            print("First player \(firstPlayer.playerView?.nameLabel.text ?? "") wins")
            winner = firstPlayer
        } else if  value == -1 {
            print("Second player \(secondPlayer.playerView?.nameLabel.text ?? "") wins")
            winner = secondPlayer
        } else {
            print("Draw")
        }
        
        delegate?.gameFinished(self, winner: winner)
    }
}
