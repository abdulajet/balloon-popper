//
//  GameScene.swift
//  XtremeBalloonPopper
//
//  Created by Abdulhakim Ajetunmobi on 24/04/2016.
//  Copyright © 2016 5to9 Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    let bg = SKSpriteNode(imageNamed: "h_bg")
    
    let playBtn = SKSpriteNode(texture: SKTexture(imageNamed: "playBtn"))
    let howBtn = SKSpriteNode(texture: SKTexture(imageNamed: "howBtn"))


    override func didMoveToView(view: SKView) {
    
        //check if 4s
        let screenSize =  UIScreen.mainScreen().bounds
        if (screenSize.height == 480 && screenSize.width == 320){
            print("4s")
            bg.size = CGSizeMake(frame.width - 500, frame.height)
            
            
        }else{
            bg.setScale(0.7)
        }
        
        bg.position = CGPointMake(frame.width / 2, frame.height / 2)
        bg.zPosition = -1
        
        howBtn.position = CGPointMake(frame.width / 2, frame.height / 2 - 50)
        playBtn.position = CGPointMake(frame.width / 2, frame.height / 2 + 80)
        playBtn.setScale(0.75)
        howBtn.setScale(0.75)
        
        
        self.addChild(howBtn)
        self.addChild(playBtn)
        self.addChild(bg)

    
    
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
        
            if (nodeAtPoint(location) == playBtn){
            
            let transition = SKTransition.fadeWithDuration(1)
            
            let scene = BalloonScene(size: self.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.view?.presentScene(scene, transition: transition)
            }
            
            
            if (nodeAtPoint(location) == howBtn){
                
                let transition = SKTransition.fadeWithDuration(1)
                
                let scene = HowScene(size: self.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.view?.presentScene(scene, transition: transition)
            }
        
        }
    }



}