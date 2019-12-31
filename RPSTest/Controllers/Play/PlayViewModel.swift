//
//  PlayViewModel.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import Foundation

/// Playing process view model protocol
protocol PlayViewModel {
    
    var delegate: GameDelegate? { get set }
    var tournament: Tournament? { get set }
    
    func startTournament()
    func setupGame(views: [PlayerView])
    func startPlaying()
    func selectShape(_ shape: Shape)
    
}
