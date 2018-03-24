//
//  ViewController.swift
//  test2
//
//  Created by Abdulhakim Ajetunmobi on 21/03/2018.
//  Copyright © 2018 abdulajet. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate {
        
    @IBOutlet var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        let balloonId = randomInt(min: 1, max: 4)
        let balloon = SKSpriteNode(imageNamed: "b\(balloonId)")
        balloon.name = "balloon"
        balloon.setScale(0.3)
        
        let moveUP =  SKAction.move(to: CGPoint(x: balloon.position.x, y: view.bounds.maxY), duration: 10)
        
        let moveUPForever = SKAction.repeatForever(moveUP)
        
        balloon.run(moveUPForever)
        
        return balloon
    }
}
