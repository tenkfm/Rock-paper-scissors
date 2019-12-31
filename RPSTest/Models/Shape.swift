//
//  Shape.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import UIKit

struct Shape: Codable {
    
    //MARK: - Decodable
    var id      : String
    var title   : String
    var asset   : String
    var rules   : [String: Int]
    
    //MARK: - Convenience
    var image: UIImage? {
        get {
            return UIImage(named: asset)
        }
    }
    
    
}
