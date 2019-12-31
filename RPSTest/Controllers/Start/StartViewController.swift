//
//  StartViewController.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import UIKit

/// Application start (menu) screen view controller
class StartViewController: AnimatingViewController {
    //MARK: - Private members
    private static let SEGUE_CVC = "CvC"
    private static let SEGUE_PVC = "PvC"

    //MARK: - Inherited
    override func getAppearingWithAnimationViews() -> [UIView]? {
        return [titleLabel, playerComputerButton, computerComputerButton]
    }
    
    
    //MARK: - Public members
    private var viewModel = StartViewModel()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playerComputerButton: UIButton!
    @IBOutlet weak var computerComputerButton: UIButton!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Assign models for different game type
        if segue.identifier == StartViewController.SEGUE_CVC {
            (segue.destination as! PlayViewController).viewModel = CvCPlayViewModel()
        } else if segue.identifier == StartViewController.SEGUE_PVC {
            (segue.destination as! PlayViewController).viewModel = PvCPlayViewModel()
        } else {
            fatalError("Unexpectes segue")
        }
    }
    
}

