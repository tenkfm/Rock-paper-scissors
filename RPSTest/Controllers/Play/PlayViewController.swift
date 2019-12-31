//
//  PlayViewController.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import UIKit

class PlayViewController: AnimatingViewController {
    
    //MARK: - Inherited
    override func getAppearingWithAnimationViews() -> [UIView]? {
        return nil
    }
    
    //MARK: - Private members    
    
    //MARK: - Public members
    public var viewModel: PlayViewModel!
    
    @IBOutlet weak var topPlayerView: PlayerView!
    @IBOutlet weak var bottomPlayerView: PlayerView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var boardLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var shapesStackView: UIStackView!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    override func setupView() {
        super.setupView()
        
        // Setup view model with player views
        viewModel.startTournament()
        viewModel.setupGame(views: [topPlayerView, bottomPlayerView])
        
        
        // If there are at least one Human player in the Tournament
        if viewModel.tournament!.hasHumanPlayer {
            //TODO: Move to the ModelView
            // Setup action buttons
            Tournament.rules.shapes.forEach { (shape) in
                let button = self.makeShapeButton(shape)
                self.shapesStackView.addArrangedSubview(button)
            }
        }
    }
    
    private func makeShapeButton(_ shape: Shape) ->UIButton {
        let button = ShapeButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(shape.image, for: .normal)
        button.addTarget(self, action: #selector(actionSelectShape(_:)), for: .touchUpInside)
        button.shape = shape
        return button
    }
    
    private func showActions() {
        startButton.isHidden = true
        shapesStackView.isHidden = false
        choiceLabel.isHidden = false
    }
    
    private func hideActions() {
        startButton.isHidden = true
        shapesStackView.isHidden = true
        choiceLabel.isHidden = true
    }
    
    private func showStartButton() {
        startButton.isHidden = false
        shapesStackView.isHidden = true
        choiceLabel.isHidden = true
    }
    
    private func hideStartButton() {
        startButton.isHidden = true
        shapesStackView.isHidden = true
        choiceLabel.isHidden = true
    }
    
    //MARK: - Actions
    @IBAction func actionStart(_ sender: Any) {
        viewModel.startPlaying()
    }
    
    @objc private func actionSelectShape(_ sender: Any) {
        guard let shapeButton = sender as? ShapeButton
            , let selectedShape = shapeButton.shape else {
                fatalError("Shape button has no shape")
        }
        hideActions()
        viewModel.selectShape(selectedShape)
    }
    
    @IBAction func actionFinish(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PlayViewController: GameDelegate {

    func gameStarted(_ game: Game) {
        if viewModel.tournament!.hasHumanPlayer {
            showActions()
        } else {
            hideStartButton()
        }
    }
    
    func gameFinished(_ game: Game, winner: Player?) {
        showStartButton()
        let tournament: Tournament = viewModel.tournament!
        
        let wins1 = tournament.wins.filter({ $0.id == tournament.players.first!.id }).count
        let wins2 = tournament.wins.filter({ $0.id == tournament.players.last!.id }).count
        
        boardLabel.text = String(format: "%d : %d", wins1, wins2)
        
        
    }
}
