//
//  Player.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import Foundation

class AI: Player {
    
    //MARK: - Private & Constructor
    private static let TITLE = "Computer"

    init(id: Int, withView view: PlayerView?=nil) {
        self.id = id
        self.playerView = view
        playerView?.nameLabel.text = AI.TITLE
    }
    
    //MARK: - Private members
    private var timer: Timer?
    
    //MARK: - Player
    var id: Int
    var shape: Shape?
    var playerView: PlayerView? {
        didSet {
            playerView?.nameLabel.text = AI.TITLE
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

        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
            let selectedShape = Tournament.rules.shapes[Int.random(in: 0..<Tournament.rules.shapes.count)]
            self.makeChoice(shape: selectedShape)
        })
    }
    
    func makeChoice(shape: Shape) {
        self.shape = shape
        print("AI selected shape: \(shape.title)")
        self.choiceHandler()
    }

}
