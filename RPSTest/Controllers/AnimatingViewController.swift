//
//  AnimatingViewController.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import UIKit

class AnimatingViewController: GameViewController {
    
    func getAppearingWithAnimationViews() -> [UIView]? {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Appearing with animation - pre-appearing setup
        if let awaViews = getAppearingWithAnimationViews() {
            awaViews.forEach { $0.isHidden = true }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Appearing with animation - appearing aimation
        if let awaViews = getAppearingWithAnimationViews() {
            var delay = 0
            awaViews.forEach {
                let view = $0
                let deadlineTime = DispatchTime.now() + .milliseconds(delay)
                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                    UIView.transition(with: view, duration: 1, options: [.transitionFlipFromTop], animations: {
                        view.isHidden = false
                    }, completion: nil)
                }
                delay += 100
            }
        }
    }
    
}
