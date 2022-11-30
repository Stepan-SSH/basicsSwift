import Foundation
import UIKit
import SpriteKit

class snakeHead: snakeBodyPart {
    
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
       
        self.physicsBody?.categoryBitMask = collisionCategory.SnakeHead
        
        //  с кем сталкивается
        self.physicsBody?.contactTestBitMask = collisionCategory.EdgeBody | collisionCategory.Snake | collisionCategory.Apple
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Нет иницилизатора")
    }
    
    
}
