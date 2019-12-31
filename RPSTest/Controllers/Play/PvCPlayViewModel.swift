//
//  P2CPlayViewModel.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import Foundation

/// Player vs Computer playing process view model protocol
class PvCPlayViewModel: PlayViewModel {
    
    //MARK: - Private
    
    
    //MARK: - PlayViewModel
    var tournament: Tournament?
    weak var delegate: GameDelegate? {
        didSet {
            tournament?.game?.delegate = self
        }
    }
    
    func startTournament() {
        self.tournament = Tournament()
        self.tournament?.players = [Human(id: 1),
                                    AI(id: 2)]
    }
    
    func setupGame(views: [PlayerView]) {
        guard let tournament = self.tournament else {
            fatalError("Tournament is not created")
        }
        
        for (idx, var player) in tournament.players.enumerated() {
            if views.count >= idx {
                player.playerView = views[idx]
            }
        }
        
        tournament.game = Game(players: tournament.players)
        tournament.game?.delegate = delegate
    }
    
    public func startPlaying() {
        tournament?.game?.start()
    }
    
    func selectShape(_ shape: Shape) {
        // Find a human player and set selected shape
        tournament?.game?.players.forEach({ (player) in
            guard let human = player as? Human else {
                return
            }
            human.makeChoice(shape: shape)
        })
    }
    
}

extension PvCPlayViewModel: GameDelegate {
    func gameStarted(_ game: Game) {
        delegate?.gameStarted(game)
    }
    
    func gameFinished(_ game: Game, winner: Player?) {
        if let winner = winner {
            tournament?.wins.append(winner)
        }
        delegate?.gameFinished(game, winner: winner)
    }
}

