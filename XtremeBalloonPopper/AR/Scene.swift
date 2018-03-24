//
//  Scene.swift
//  test2
//
//  Created by Abdulhakim Ajetunmobi on 21/03/2018.
//  Copyright © 2018 abdulajet. All rights reserved.
//

import SpriteKit
import ARKit

class Scene: SKScene {
    
    var creationTime : TimeInterval = 0
    
    override func didMove(to view: SKView) {
        // Setup your scene here
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        spawnBalloon(currentTime: currentTime)
    }
    
    func spawnBalloon(currentTime: TimeInterval) {
        if currentTime > creationTime {
            createBalloonAnchor()
            creationTime = currentTime + TimeInterval(randomFloat(min: 3.0, max: 6.0))
        }
    }
    
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
    func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func createBalloonAnchor() {
        guard let sceneView = self.view as? ARSKView else { return }
        
        let _360degrees = 2.0 * Float.pi
        let rotateX = simd_float4x4(SCNMatrix4MakeRotation(_360degrees * randomFloat(min: 0.0, max: 1.0), 1, 0, 0))
        let rotateY = simd_float4x4(SCNMatrix4MakeRotation(_360degrees * randomFloat(min: 0.0, max: 1.0), 0, 1, 0))
        let rotation = simd_mul(rotateX, rotateY)
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -1 - randomFloat(min: 2.0, max: 3.0)
        let transform = simd_mul(rotation, translation)
        
        let anchor = ARAnchor(transform: transform)
        sceneView.session.add(anchor: anchor)
    }
    
    func getSound() -> SKAction {
        let soundNum = randomInt(min: 1, max: 8)
        
        switch soundNum {
        case 1:
            return SKAction.playSoundFileNamed("b", waitForCompletion: false)
        case 2:
            return SKAction.playSoundFileNamed("c octv", waitForCompletion: false)
        case 3:
            return SKAction.playSoundFileNamed("c", waitForCompletion: false)
        case 4:
            return SKAction.playSoundFileNamed("d", waitForCompletion: false)
        case 5:
            return SKAction.playSoundFileNamed("e", waitForCompletion: false)
        case 6:
            return SKAction.playSoundFileNamed("a", waitForCompletion: false)
        case 7:
            return SKAction.playSoundFileNamed("f", waitForCompletion: false)
        case 8:
            return SKAction.playSoundFileNamed("g", waitForCompletion: false)
        default:
            return SKAction.playSoundFileNamed("b", waitForCompletion: false)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let hit = nodes(at: location)
        
        if let node = hit.first {
            if node.name == "balloon" {
                let fadeOut = SKAction.fadeOut(withDuration: 0.5)
                let remove = SKAction.removeFromParent()
                
                let groupKillingActions = SKAction.group([fadeOut, getSound()])
                let sequenceAction = SKAction.sequence([groupKillingActions, remove])
                
                node.run(sequenceAction)
            }
        }
    }
}
