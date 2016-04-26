//
//  BalloonSscene.swift
//  XtremeBalloonPopper
//
//  Created by Abdulhakim Ajetunmobi on 23/04/2016.
//  Copyright (c) 2016 5to9 Studios. All rights reserved.
//

import SpriteKit
import AVFoundation


class BalloonScene: SKScene {
    var endGame = false
    var balloons = [SKSpriteNode]()
    var blockSize: CGFloat = 0
    var sound:AVAudioPlayer = AVAudioPlayer()
    let bg = SKSpriteNode(imageNamed: "bg")
    let backBtn = SKSpriteNode(imageNamed: "quitBtn")

    
    var balloonSpeed: CGFloat = 0.0
    var spawnTimer = 0.0
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        blockSize = frame.height / 8
        
        
        //check if 4s and change bg size
        let screenSize =  UIScreen.mainScreen().bounds
        if (screenSize.height == 480 && screenSize.width == 320){
            bg.size = CGSizeMake(frame.width - 500, frame.height)
            
            
        }else{
            bg.setScale(0.7)
        }
        
        bg.position = CGPointMake(frame.width / 2, frame.height / 2)
        bg.zPosition = -2
        bg.alpha = 1
        
        self.addChild(bg)
        
        
        //if it is 6s Plus
        if (screenSize.height == 736 && screenSize.width == 414){
            balloonSpeed = 5
            spawnTimer = 4
        }else{
            balloonSpeed = 2
            spawnTimer = 2
        }
        
        
        
        backBtn.position = CGPointMake(frame.width / 2 + 185, frame.height / 2 + 355)
        backBtn.zPosition = -1
        backBtn.setScale(0.5)
        self.addChild(backBtn)
        
        
        _ = NSTimer.scheduledTimerWithTimeInterval(spawnTimer, target: self, selector: #selector(BalloonScene.playGame), userInfo: nil, repeats: true)
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
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touches.first!.locationInNode(self)
            
            for i in 0 ..< balloons.count{
                if (nodeAtPoint(location) == balloons[i]){
                    ballonTouched(touch.force, balloon: balloons[i], height: balloons[i].position.y)
                    balloons[i].removeFromParent()
                }
                
            }
        }
        
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        for i in 0 ..< balloons.count{
            if (balloons[i].position.y < frame.height + 100) {
                balloons[i].position.y += balloonSpeed
            }
        }
        
        
    }
    
    func playGame(){
        let randomTime = CDouble(arc4random_uniform(11) + 5)
        let timer = NSTimer.scheduledTimerWithTimeInterval(randomTime, target: self, selector: #selector(BalloonScene.spawnBalloon), userInfo: nil, repeats: false)
        
        timer.fire()
        
    }
    
    func spawnBalloon(){
        let track = arc4random_uniform(3)
        let colour = arc4random_uniform(4)
        
        var sprite = SKSpriteNode()
        
        switch colour {
        case 0:
            sprite = SKSpriteNode(imageNamed: "redBalloon")
            break
            
        case 1:
            sprite = SKSpriteNode(imageNamed: "greenBalloon")
            break
            
        case 2:
            sprite = SKSpriteNode(imageNamed: "purpleBalloon")
            break
            
        case 3:
            sprite = SKSpriteNode(imageNamed: "blueBalloon")
            break
            
        default:
            
            break
        }
        
        
        switch track {
        case 0:
            sprite.position = CGPointMake(frame.width / 2, -10.0)
            sprite.setScale(0.2)
            self.addChild(sprite)
            balloons.append(sprite)
            break
            
        case 1:
            sprite.position = CGPointMake(frame.width / 2 + 150, -10.0)
            sprite.setScale(0.2)
            self.addChild(sprite)
            balloons.append(sprite)
            break
            
        case 2:
            sprite.position = CGPointMake(frame.width / 2 - 150, -10.0)
            sprite.setScale(0.2)
            self.addChild(sprite)
            balloons.append(sprite)
            break
            
        default:
            break
        }
        
    }
    
    func ballonTouched(forceAmount: CGFloat, balloon: SKSpriteNode, height: CGFloat){
        playNote(forceAmount * 5, note: getNote(height))
        balloon.removeFromParent()
        
        
    }
    
    func getNote(height: CGFloat) -> String {
        
        if height > 0 && height <= blockSize{
            return "c"
        }
        
        if height > blockSize && height <= (blockSize * 2) {
            return "d"
        }
        
        if height > (blockSize * 2) && height <= (blockSize * 3) {
            return "e"
        }
        
        if height > (blockSize * 3) && height <= (blockSize * 4) {
            return "f"
        }
        
        if height > (blockSize * 4) && height <= (blockSize * 5) {
            return "g"
        }
        
        if height > (blockSize * 5) && height <= (blockSize * 6) {
            return "a"
        }
        
        if height > (blockSize * 6) && height <= (blockSize * 7) {
            return "b"
        }
        
        if height > (blockSize * 7) && height <= (blockSize * 8) {
            return "c octv"
        }
        
        return "fail"
    }
    
    func playNote(forceAmount: CGFloat, note: String){
        
        let soundURL:NSURL = NSBundle.mainBundle().URLForResource(note, withExtension: "wav")!
        do { sound = try AVAudioPlayer(contentsOfURL: soundURL, fileTypeHint: nil) } catch let error as NSError {
            print(error.description)
        }
        
        sound.volume = Float(inRange(forceAmount))
        sound.numberOfLoops = 0
        sound.prepareToPlay()
        sound.play()
        
        
    }
    
    func inRange(val: CGFloat) -> CGFloat {
        print(val)
        if (val < 2){
            return 0.1
        } else if (val > 2 && val < 4.5){
            return 0.3
        }else{
            return 1
        }
    }
}
