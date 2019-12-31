//
//  Tournament.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import Foundation

class Tournament {
    
    /**
     Rules default config plist file
     */
    public static let CONFIG_FILE_NAME = "rules"

    /**
     Tournamen rules.
     Rule is a list of shapes and its interactions.
     */
    public static var rules: Rules {
        let configPath = Bundle.main.path(forResource: Tournament.CONFIG_FILE_NAME, ofType: "plist")!
        guard let data = FileManager.default.contents(atPath: configPath)
            , let config = try? PropertyListDecoder().decode(Rules.self, from: data) else {
                fatalError("Config file loading error exist")
        }
        return config
    }
    
    //MARK: - Public
    public var players: [Player]!
    public var wins: [Player] = []
    public var game: Game?
    
    public var hasHumanPlayer: Bool {
        get {
            if let _ = players.first(where: { ($0 as? Human) != nil }) {
                return true
            }
            return false
        }
    }
}
