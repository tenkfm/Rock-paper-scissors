//
//  PlayViewModel.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import Foundation

/// Playing process view model protocol
/// Using flow:
/// 1. startTournament()
/// 2. setupGame(_, _)
/// 3. startPlaying()
protocol PlayViewModel {
    
    var delegate: GameDelegate? { get set }
    var tournament: Tournament? { get set }
    
    /**
     Create tournament and add players
     */
    func startTournament()

    /**
     Assign player views and create game
     */
    func setupGame(views: [PlayerView])

    /**
     Start current game
     */
    func startPlaying()
    
    /**
     Select current shape for a human player
     */
    func selectShape(_ shape: Shape)
    
}
