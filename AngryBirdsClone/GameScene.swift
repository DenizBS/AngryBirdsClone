//
//  GameScene.swift
//  AngryBirdsClone
//
//  Created by Deniz Baran SERBEST on 1.06.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    var brick1 = SKSpriteNode()
    var brick2 = SKSpriteNode()
    var brick3 = SKSpriteNode()
    var brick4 = SKSpriteNode()
    var brick5 = SKSpriteNode()
    
    var gameStarted = false
    var originalPosition : CGPoint?
    
    enum ColliderType: UInt32 {
        case Bird = 1
        case Brick = 2
    }
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        //View
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        
        //Bird
        let birdTexture = SKTexture(imageNamed: "bird")
        bird = childNode(withName: "bird") as! SKSpriteNode
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 13)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        
        originalPosition = bird.position
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Brick.rawValue
        
        //Bricks
        let brickTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: brickTexture.size().width / 6.5, height: brickTexture.size().height / 6.5)
        
        brick1 = childNode(withName: "brick1") as! SKSpriteNode
        brick1.physicsBody = SKPhysicsBody(rectangleOf: size)
        brick1.physicsBody?.isDynamic = true
        brick1.physicsBody?.affectedByGravity = true
        brick1.physicsBody?.allowsRotation = true
        brick1.physicsBody?.mass = 0.3
        
        brick1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        brick2 = childNode(withName: "brick2") as! SKSpriteNode
        brick2.physicsBody = SKPhysicsBody(rectangleOf: size)
        brick2.physicsBody?.isDynamic = true
        brick2.physicsBody?.affectedByGravity = true
        brick2.physicsBody?.allowsRotation = true
        brick2.physicsBody?.mass = 0.3
        
        brick2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        brick3 = childNode(withName: "brick3") as! SKSpriteNode
        brick3.physicsBody = SKPhysicsBody(rectangleOf: size)
        brick3.physicsBody?.isDynamic = true
        brick3.physicsBody?.affectedByGravity = true
        brick3.physicsBody?.allowsRotation = true
        brick3.physicsBody?.mass = 0.3
        
        brick3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        brick4 = childNode(withName: "brick4") as! SKSpriteNode
        brick4.physicsBody = SKPhysicsBody(rectangleOf: size)
        brick4.physicsBody?.isDynamic = true
        brick4.physicsBody?.affectedByGravity = true
        brick4.physicsBody?.allowsRotation = true
        brick4.physicsBody?.mass = 0.3
        
        brick4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        brick5 = childNode(withName: "brick5") as! SKSpriteNode
        brick5.physicsBody = SKPhysicsBody(rectangleOf: size)
        brick5.physicsBody?.isDynamic = true
        brick5.physicsBody?.affectedByGravity = true
        brick5.physicsBody?.allowsRotation = true
        brick5.physicsBody?.mass = 0.3
        
        brick5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        //Label
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            
            score += 1
            scoreLabel.text = String(score)
            
        }
        
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                                
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if let birdPhysicsBody = bird.physicsBody {
            
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPosition!
                
                score = 0
                scoreLabel.text = String(score)
                
                gameStarted = false
            }
            
        }
        
    }
}
