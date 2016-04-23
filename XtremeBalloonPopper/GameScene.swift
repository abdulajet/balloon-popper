//
//  GameScene.swift
//  XtremeBalloonPopper
//
//  Created by Abdulhakim Ajetunmobi on 23/04/2016.
//  Copyright (c) 2016 5to9 Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var sprite = SKSpriteNode(imageNamed: "Spaceship")

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
                sprite.position = CGPointMake(frame.width / 2, frame.height / 2)
                self.addChild(sprite)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        
    }
   
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touches.first!.locationInNode(self)
            if (nodeAtPoint(location) == sprite){
                ballonTouched(touch.force)
                sprite.removeFromParent()
            }
        }

    }
    

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        
    }
    
    
    
    func ballonTouched(forceAmount: CGFloat){
        print(forceAmount * 10)
    }
}
