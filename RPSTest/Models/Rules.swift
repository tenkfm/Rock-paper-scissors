//
//  Rules.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import Foundation

/**
 Rule structure:
 
 - id: shape ID
 - title: shape name
 - asset: shape image asset
 - rules: shapes interaction rules:
    - Interactive shape id
    - Interactive shape rule (-1 - defeat, 0 - draw, 1 - win)
 <dict>
     <key>id</key>
     <string>rock</string>
     <key>title</key>
     <string>Rock</string>
     <key>asset</key>
     <string>rock</string>
     <key>rules</key>
     <dict>
         <key>rock</key>
         <integer>0</integer>
         <key>paper</key>
         <integer>-1</integer>
         <key>scissors</key>
         <integer>1</integer>
     </dict>
 </dict>
 */

struct Rules: Codable {
    var shapes: [Shape]
}
