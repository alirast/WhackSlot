//
//  GameViewController.swift
//  WhackSlot
//
//  Created by n on 21.09.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .fill
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
//MARK: - supportedInterfaceOrientations
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
//MARK: - prefersStatusBarHidden
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
