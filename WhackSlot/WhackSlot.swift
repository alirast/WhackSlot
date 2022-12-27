//
//  WhackSlot.swift
//  WhackSlot
//
//  Created by n on 21.09.2022.
//

import SpriteKit
import UIKit

class WhackSlot: SKNode {
//MARK: - propeties
    var charNode: SKSpriteNode!
    var isVisible = false
    var isHit = false
//MARK: - configure
    func configure(at position: CGPoint) {
        self.position = position
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        addChild(cropNode)
    }
//MARK: - show
    func show(hideTime: Double) {
        if isVisible { return }

        charNode.xScale = 1
        charNode.yScale = 1
        
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
            self?.hide()
        }
    }
//MARK: - hide
    func hide() {
        if !isVisible { return }
        
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
        
        if isHit == false {
            if let hideParticles = SKEmitterNode(fileNamed: "badSpark") {
                hideParticles.position = CGPoint(x: charNode.position.x, y: charNode.position.y + 80)
                addChild(hideParticles)
            }
        }
    }
//MARK: - hit
    func hit() {
        isHit = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)

        let notVisible = SKAction.run { [unowned self] in self.isVisible = false }
        charNode.run(SKAction.sequence([delay, hide, notVisible]))
        
        if let smokeParticles = SKEmitterNode(fileNamed: "smoke") {
            smokeParticles.position = charNode.position
            addChild(smokeParticles)
        }
    }
}
