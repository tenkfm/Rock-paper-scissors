//
//  Player.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import Foundation

protocol Player {
    var id: Int { set get }
    var shape: Shape? { get }
    var playerView: PlayerView? { get set }
    
    func prepareForGame()
    func startPlaying(choiceHandler: @escaping () -> Void)
    func makeChoice(shape: Shape)
}
