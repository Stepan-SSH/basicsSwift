import UIKit
import SpriteKit
import Foundation


class Border: SKShapeNode {
    convenience init ( XX: Int, YY: Int){
        self.init()
        
    path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: XX, height: YY)).cgPath
        

        strokeColor = SKColor.gray
        lineWidth = 1


        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: XX, height: YY))
        self.physicsBody?.categoryBitMask = collisionCategory.Border
    }
}


