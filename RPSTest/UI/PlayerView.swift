//
//  PlayerView.swift
//  RPSTest
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import UIKit

//enum Shape: Int {
//    case rock       = 0
//    case paper
//    case scissors
//    
//    func image() -> UIImage {
//        switch self {
//        case .rock:
//            return #imageLiteral(resourceName: "rock")
//        case .paper:
//            return #imageLiteral(resourceName: "paper.png")
//        case .scissors:
//            return #imageLiteral(resourceName: "scissors")
//        }
//    }
//
//    static func random() -> Shape {
//        return Shape(rawValue: Int.random(in: 0...2))!
//    }
//}

@IBDesignable
class PlayerView: UIView {
    enum State {
        case idle
        case shaking
        case shape(Shape)
    }

    //MARK: - Private members
    private var state: State = .idle
    
    //MARK: - Public members
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shapeImageView: UIImageView!
    
    //MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewInit()
    }

    func viewInit() {
        let bundle = Bundle.init(for: PlayerView.self)
        if let xibViews = bundle.loadNibNamed("PlayerView", owner: self, options: nil), let contentView = xibViews.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
    }
    //MARK: - Private functions
    private func shake() {
        state = .shaking
        shapeImageView.setAnchorPoint(CGPoint(x: 0.4, y: 0.5))
        
        func shakeUp() {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                self.shapeImageView.transform = self.shapeImageView.transform.rotated(by: -(.pi / 2))
            }) { (finished) -> Void in
                shakeDown()
            }
        }
        
        func shakeDown() {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: { () -> Void in
                
                self.shapeImageView.transform = self.shapeImageView.transform.rotated(by: .pi / 2)
            }) { (finished) -> Void in
                switch self.state {
                case .shaking:
                    shakeUp()
                case let .shape(shape):
                    self.shapeImageView.image = shape.image
                    break
                default:
                    break
                }
            }
        }
        shakeUp()
    }
    
    //MARK: - Actions
    
    public func startShaking() {
        shapeImageView.image = #imageLiteral(resourceName: "rock.png")
        shake()
    }
    
    public func stopShaking() {
        state = .idle
    }
    
    public func showShape(_ shape: Shape) {
        state = .shape(shape)
    }
    
}
