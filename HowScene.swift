//
//  HowScene.swift
//  XtremeBalloonPopper
//
//  Created by Abdulhakim Ajetunmobi on 24/04/2016.
//  Copyright © 2016 5to9 Studios. All rights reserved.
//

import SpriteKit

class HowScene: SKScene {
    let bg = SKSpriteNode(imageNamed: "bg")
    let backBtn = SKSpriteNode(imageNamed: "quitBtn")
    var text = SKLabelNode()
    var text2 = SKLabelNode()
    var text3 = SKLabelNode()
    var text4 = SKLabelNode()

    
    override func didMoveToView(view: SKView) {
        
        text = SKLabelNode(text: "Pop the balloons to relieve stress!")
        text2 = SKLabelNode(text: "When balloons are popped they play a piano note!")
        text3 = SKLabelNode(text: "The higher the ballon is on screen, the higher the note.")
        text4 = SKLabelNode(text: "P.S. use 3D touch to control the volume!")
        
        text.position = CGPointMake(frame.width / 2, frame.width / 2 + 100)
        text2.position = CGPointMake(frame.width / 2, frame.width / 2 + 70)
        text3.position = CGPointMake(frame.width / 2, frame.width / 2 + 40)
        text4.position = CGPointMake(frame.width / 2, frame.width / 2 + 10)

        text.fontSize = 20
        text2.fontSize = 20
        text3.fontSize = 20
        text4.fontSize = 20

        self.addChild(text)
        self.addChild(text2)
        self.addChild(text3)
        self.addChild(text4)
        
        
        
        backBtn.position = CGPointMake(frame.width / 2 + 120, frame.height / 2 + 300)
        
        self.addChild(backBtn)

        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location) == backBtn {
                
                
                let transition = SKTransition.fadeWithDuration(1)
                
                let scene = GameScene(size: self.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.view?.presentScene(scene, transition: transition)
                
            }
            
        }
        
    }

}
