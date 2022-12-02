import Foundation
import UIKit
import SpriteKit

class snakeBodyPart: SKShapeNode {
    
    let diametr = 10
    init(atPoint point: CGPoint){
        super.init()
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: CGFloat(diametr), height: CGFloat(diametr))).cgPath
        fillColor = SKColor.green
        strokeColor = SKColor.green
        
        lineWidth = 5
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr) , center: CGPoint(x: 5, y: 5))
        self.physicsBody?.categoryBitMask = collisionCategory.Snake
        self.physicsBody?.contactTestBitMask =  collisionCategory.SnakeHead
        
        self.physicsBody?.isDynamic = true
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("Нет иницилизатора")
    }
    
}

