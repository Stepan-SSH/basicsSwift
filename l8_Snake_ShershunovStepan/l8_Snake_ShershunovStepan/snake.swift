import Foundation
import UIKit
import SpriteKit

class Snake: SKShapeNode {
    
    let moveSpeed = 125.0
    var angel = 0.0

    var body = [snakeBodyPart]()
    convenience init(atPoint point: CGPoint) {
        self.init()
        
        let head = snakeHead(atPoint: point)
        
        body.append(head)
        
        addChild(head)
    }
    
    func addBodyPart() {
        let newBodyPart = snakeBodyPart(atPoint: CGPoint(x: body[0].position.x, y: body[0].position.y))
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
    
    
    func move() {
        
        guard !body.isEmpty else {return}
        let head = body[0]
        
        moveHead(head)
        
        for index in (0 ..< body.count) where index > 0{
            let previousBodyPart = body[index-1]
            let currentBodyPart = body[index]
            
            moveBodyPart( previousBodyPart, c: currentBodyPart)
        }
    }
    
    func moveHead(_ head: snakeBodyPart) {
        let dx = CGFloat(moveSpeed) * sin(angel)
        let dy = CGFloat(moveSpeed) * cos(angel)
        
        let nexPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        let moveAcction = SKAction.move(to: nexPosition, duration: 1.0)
        
        head.run(moveAcction)
    }
    
    func moveBodyPart(_ p:snakeBodyPart, c:snakeBodyPart){
        let moveAction = SKAction.move(to: CGPoint(x: p.position.x, y: p.position.y), duration: 0.2)
        
        c.run(moveAction)
    }
    
    // Разворот направления движения, по кнопкам
    
    func moveClockwise() {
        angel += CGFloat(Double.pi/2)
    }
    
    func conterMoveClockwise() {
        angel -= CGFloat(Double.pi/2)
    }
    
}
