//
//  BalloonSscene.swift
//  XtremeBalloonPopper
//
//  Created by Abdulhakim Ajetunmobi on 23/04/2016.
//  Copyright (c) 2016 5to9 Studios. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    var endGame = false
    var balloons = [SKSpriteNode]()
    var blockSize: CGFloat = 0
    var sound:AVAudioPlayer = AVAudioPlayer()
    let bg = SKSpriteNode(imageNamed: "bg")
    
    var balloonSpeed: CGFloat = 0.0
    var spawnTimer = 0.0
    
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        blockSize = frame.height / 8
        
        //check if 4s and change bg size
        let screenSize =  UIScreen.main.bounds
        if (screenSize.height == 480 && screenSize.width == 320){
            bg.size = CGSize(width: frame.width - 500, height: frame.height)
        }else{
            bg.setScale(0.7)
        }
        
        bg.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
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
        
        _ = Timer.scheduledTimer(timeInterval: spawnTimer, target: self, selector: #selector(self.playGame), userInfo: nil, repeats: true)
    }
    
 override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touches.first!.location(in: self)
            
            for i in 0 ..< balloons.count{
                if (atPoint(location) == balloons[i]){
                    ballonTouched(touch.force, balloon: balloons[i], height: balloons[i].position.y)
                    balloons[i].removeFromParent()
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        for i in 0 ..< balloons.count{
            if (balloons[i].position.y < frame.height + 100) {
                balloons[i].position.y += balloonSpeed
            }
        }
    }
    
    func playGame(){
        let randomTime = CDouble(arc4random_uniform(11) + 5)
        let timer = Timer.scheduledTimer(timeInterval: randomTime, target: self, selector: #selector(self.spawnBalloon), userInfo: nil, repeats: false)
        
        timer.fire()
    }
    
    func spawnBalloon(){
        let track = arc4random_uniform(3)
        let colour = arc4random_uniform(4)
        
        var sprite = SKSpriteNode()
        
        switch colour {
        case 0:
            sprite = SKSpriteNode(imageNamed: "redBalloon")
        case 1:
            sprite = SKSpriteNode(imageNamed: "greenBalloon")
        case 2:
            sprite = SKSpriteNode(imageNamed: "purpleBalloon")
        case 3:
            sprite = SKSpriteNode(imageNamed: "blueBalloon")
        default:
            break
        }
        
        switch track {
        case 0:
            sprite.position = CGPoint(x: frame.width / 2, y: -10.0)
            sprite.setScale(0.2)
            self.addChild(sprite)
            balloons.append(sprite)
        case 1:
            sprite.position = CGPoint(x: frame.width / 2 + 150, y: -10.0)
            sprite.setScale(0.2)
            self.addChild(sprite)
            balloons.append(sprite)
        case 2:
            sprite.position = CGPoint(x: frame.width / 2 - 150, y: -10.0)
            sprite.setScale(0.2)
            self.addChild(sprite)
            balloons.append(sprite)
        default:
            break
        }
    }
    
    func ballonTouched(_ forceAmount: CGFloat, balloon: SKSpriteNode, height: CGFloat){
        playNote(forceAmount * 5, note: getNote(height))
        balloon.removeFromParent()
    }
    
    func getNote(_ height: CGFloat) -> String {
        if height > 0 && height <= blockSize {
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
    
    func playNote(_ forceAmount: CGFloat, note: String){
        guard let soundURL:URL = Bundle.main.url(forResource: note, withExtension: "wav") else { return }
        do { sound = try AVAudioPlayer(contentsOf: soundURL, fileTypeHint: nil) } catch let error as NSError {
            print(error.description)
        }
        
        sound.volume = Float(inRange(forceAmount))
        sound.numberOfLoops = 0
        sound.prepareToPlay()
        sound.play()
    }
    
    func inRange(_ val: CGFloat) -> CGFloat {
        if (val < 2){
            return 0.1
        } else if (val > 2 && val < 4.5){
            return 0.3
        }else{
            return 1
        }
    }
}

