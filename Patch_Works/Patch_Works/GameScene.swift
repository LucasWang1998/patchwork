//
//  GameScene.swift
//  Patch_Works
//
//  Created by Ashley Toribio on 11/24/18.
//  Copyright © 2018 cse438. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var background = SKSpriteNode(imageNamed: "Background")
    var num_stitches = type-1
    var needle = SKSpriteNode(imageNamed: "Needle")
    private var currentNode: SKNode?
    let tapRec2 = UITapGestureRecognizer()
    let rotateRec = UIRotationGestureRecognizer()
    var array:[SKShapeNode] = []
    var color:[UIColor] = [UIColor.blue,UIColor.brown,UIColor.cyan,UIColor.green,UIColor.red,UIColor.orange,UIColor.magenta,UIColor.darkGray]
    var label_score:SKLabelNode!
    var score = 0 {
        didSet{
            label_score.text = "Score: \(score)"
        }
    }
    
    

    override func didMove(to view: SKView) {
       
        
        background.position = CGPoint(x: 0, y:0)
        background.size = self.frame.size
        needle.size = CGSize(width:needle.size.width/2,height:needle.size.height/2)
        needle.name = "needle"
        addChild(background)
        addChild(needle)
        
        label_score = SKLabelNode(fontNamed: "Chalkduster")
        label_score.fontSize = 50
        label_score.text = "0"
        label_score.horizontalAlignmentMode = .right
        label_score.position = CGPoint(x:-10+self.frame.width/2,y:(0+self.frame.height/2)-45)
        addChild(label_score)
        
        tapRec2.addTarget(self, action:#selector(GameScene.tappedView2(_:) ))
        tapRec2.numberOfTouchesRequired = 1
        tapRec2.numberOfTapsRequired = 2
        self.view!.addGestureRecognizer(tapRec2)
        
        rotateRec.addTarget(self, action:#selector(GameScene.rotatedView (_:) ))
        self.view!.addGestureRecognizer(rotateRec)
        
        num_stitches = type-1
        for _ in 0...num_stitches{
            let random_length = Double(arc4random_uniform(50)+50) // random length 15-50
            let random_slope = (Double(arc4random())/0xFFFFFFFF)*Double.pi
            let random_x = Int(arc4random_uniform(UInt32(self.frame.size.width-200)))-Int(self.frame.size.width/2)+100
            let random_y = Int(arc4random_uniform(UInt32(self.frame.size.height-200)))-Int(self.frame.size.height/2)+100
            
            let color_num = Int(arc4random_uniform(7))
            
            
            let x2 = (random_length*cos(random_slope))+Double(random_x)
            let y2 = (random_length*sin(random_slope))+Double(random_y)
            
//            let x2 = random_x+random_length
//            let y2
            
            
            //let random_x = 5*i
            //let random_y = 20
//            print(x2)
//            print(y2)
//            print("\n")
            var points = [CGPoint(x: x2, y:y2),
                          CGPoint(x: random_x, y: random_y)]
            let linearShapeNode = SKShapeNode(points: &points,
                                              count: points.count)
            linearShapeNode.lineWidth = 6
            linearShapeNode.strokeColor = color[color_num]
            linearShapeNode.fillColor = linearShapeNode.strokeColor
            array.append(linearShapeNode)
            self.addChild(linearShapeNode)
        }
        
        
        // Get label node from scene and store it for use later
        
        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
    }
    


    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
//        var points = [pos,
//                      CGPoint(x: 0, y: 0)]
//        let linearShapeNode = SKShapeNode(points: &points,
//                                          count: points.count)
//        linearShapeNode.lineWidth = 6
//        self.addChild(linearShapeNode)
        
        
    }
    
    @objc func rotatedView(_ sender:UIRotationGestureRecognizer) {
     
        if (sender.state == .changed) {
          
            needle.zRotation = -sender.rotation
            for node in array{
                if(needle.intersects(node)){
                    if(!(UIColor(red:1,green:1,blue:1,alpha:1)==node.strokeColor)){
                        node.fillColor = node.strokeColor
                    }
                    
                    node.strokeColor = UIColor(red:1,green:1,blue:1,alpha:1)
                }
                else{
                    
                    node.strokeColor = node.fillColor
                }
            }
     
            
        }
       
        
    }
    
    @objc func tappedView2(_ sender:UITapGestureRecognizer) {
        
        
        let point:CGPoint = sender.location(in: self.view)
        
        
        score = score+1
        label_score.text = String(score)
        
        for node in array{
            if(needle.intersects(node)){
                node.strokeColor = UIColor.black
                
                array.remove(at:array.index(of: node)!)
                
            }
        }
        
        if(array.count == 0 ){
            var points = [CGPoint(x: -225, y:175),
                          CGPoint(x: 225, y: 175),
                          CGPoint(x: 225, y: -175),
                          CGPoint(x: -225, y: -175)
                          ]
            let rectangle = SKShapeNode(points: &points,
                                              count: points.count)
            rectangle.fillColor = SKColor.black
            addChild(rectangle)
            var key = "custom"
            if(type==10) {
                key = "small"
            }
            if(type==35) {
                key = "medium"
            }
            if(type==70) {
                key = "large"
            }
            let winTextLabel = SKLabelNode(text: "You Won! \n Your score is \(score)")
            
            let oldScore = UserDefaults.standard.integer(forKey:"small")
            
            let newScore = min(score, oldScore)
            
            UserDefaults.standard.set(newScore, forKey: key)
            
            winTextLabel.fontName = "Chalkduster"
            winTextLabel.numberOfLines = 0
            winTextLabel.horizontalAlignmentMode = .center
            addChild(winTextLabel)
        }
       
        

        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "needle" {
                    self.currentNode = node
                }
            }
        }

        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
            needle.position = touchLocation
        }

        

        for node in array{
            if(needle.intersects(node)){
                if(!(UIColor(red:1,green:1,blue:1,alpha:1)==node.strokeColor)){
                    node.fillColor = node.strokeColor
                }
                
                node.strokeColor = UIColor(red:1,green:1,blue:1,alpha:1)
            }
            else{
              
                node.strokeColor = node.fillColor
            }
        }
        
        
        
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        self.currentNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        self.currentNode = nil
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
