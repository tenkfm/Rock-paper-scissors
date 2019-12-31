//
//  Human.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import Foundation

class Human: Player {
    
    //MARK: - Private & Constructor
    private static let TITLE = "Player"
    
    init(id: Int, withView view: PlayerView?=nil) {
        self.id = id
        self.playerView = view
        playerView?.nameLabel.text = Human.TITLE
    }
    
    //MARK: - Player
    var id: Int
    var shape: Shape?
    var playerView: PlayerView? {
           didSet {
               playerView?.nameLabel.text = Human.TITLE
           }
       }
    var choiceHandler: (() -> Void)!

    func prepareForGame() {
        shape = nil
    }

    func startPlaying(choiceHandler: @escaping () -> Void) {
        self.choiceHandler = choiceHandler
        if let view = playerView {
            view.startShaking()
        }
    }
    
    func makeChoice(shape: Shape) {
        self.shape = shape
        print("Human selected shape: \(shape.title)")
        self.choiceHandler()
    }

    
}
