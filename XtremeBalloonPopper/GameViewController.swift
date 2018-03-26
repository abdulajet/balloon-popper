//
//  GameViewController.swift
//  XtremeBalloonPopper
//
//  Created by Abdulhakim Ajetunmobi on 23/04/2016.
//  Copyright (c) 2016 5to9 Studios. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
        }
    }
}
