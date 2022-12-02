
import UIKit
import SpriteKit
import GameplayKit

// Стуктура с номерами обьектов для битовых масок для реализации взаимодействия обьектов

struct collisionCategory  {
    static let Snake: UInt32 = 0x1 << 0
    static let SnakeHead: UInt32 = 0x1 << 1
    static let Apple: UInt32 = 0x1 << 2
    static let Border: UInt32 = 0x1 << 3
}


class GameScene: SKScene {
    
  
var snake: Snake?


    override func didMove(to view: SKView) {
        // вызывается при первом запуске
        
        // Добавляем физику, в самом конце
        self.physicsWorld.contactDelegate = self
        
        // задаем цвет фона
        backgroundColor = SKColor.black
        
        // настраиваем гравитацию
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        // отключаем изменение гравитации при перевороте устройства
        self.physicsBody?.allowsRotation = false
        
        // Логическое значение, указывающее, отображает ли представление отладочную информацию, связанную с физикой.
        view.showsPhysics = true
        
        createNavigation()
        
        // создадим яблоко
        createApple()
        createSnake()
      

    }
    
    
    func createSnake() {
        
        snake = Snake(atPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))

        self.addChild(snake!)
        self.physicsBody?.categoryBitMask = collisionCategory.Snake
        self.physicsBody?.collisionBitMask = collisionCategory.Border
        
     
    }

    func createNavigation(){
        // Добавляем кнопки
        let conterClockwiseButton = SKShapeNode()
        let clockwiseButton = SKShapeNode()
        
        // определяем параметры формы кнопки и где рисуется. Привязываемся к координатам сцены. Располагаем в нижних углах
        
        conterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        conterClockwiseButton.position = CGPoint(x: view!.scene!.frame.minX + 30, y: view!.scene!.frame.minY + 30)
        
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view!.scene!.frame.maxX - 80, y: view!.scene!.frame.minY + 30)
        
        
        // Цвета кнопки и рамки
        conterClockwiseButton.fillColor = SKColor.blue
        conterClockwiseButton.strokeColor = SKColor.cyan
        
        clockwiseButton.fillColor = SKColor.blue
        clockwiseButton.strokeColor = SKColor.cyan
        
        //Зададим толщину рамки
        conterClockwiseButton.lineWidth = 5
        clockwiseButton.lineWidth = 5
        
        conterClockwiseButton.name = "conterClockwiseButton"
        clockwiseButton.name = "clockwiseButton"
        //создадим кнопки
       
        let border = Border(XX: Int(view!.scene!.frame.maxX), YY: Int(view!.scene!.frame.maxY))
        self.addChild(border)
        
        self.addChild(conterClockwiseButton)
        self.addChild(clockwiseButton)
        
        
      
        
    }
    
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 5) + 1))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 5) + 1))
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
    }
 

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       // вызывается при нажатии на экран
        
        // контролируем нажатия в области кнопок
        // for используем для пробега по коллекции элементов touches, которые устанавливаются Set<UITouch>
        // когда touch пробегается по коллекции touches можно с ними взаимодействовать
        for touch in touches {
            // определим точку касания через параметр location и передадим в coordinate
            let coordinate = touch.location(in: self)
            
            // проверяем жмет ли на обьект и его имя
            guard let touchesNode = self.atPoint(coordinate) as? SKShapeNode,
                  touchesNode.name == "conterClockwiseButton" || touchesNode.name == "clockwiseButton"
            else {
                return
            }
            touchesNode.fillColor = SKColor.red
            if touchesNode.name == "clockwiseButton" {
                snake!.moveClockwise()
            }else if touchesNode.name == "conterClockwiseButton" {
                snake!.conterMoveClockwise()
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        // Красим обратно, после прекращения нажатия
        for touch in touches {
            
            let coordinate = touch.location(in: self)
            
            guard let touchesNode = self.atPoint(coordinate) as? SKShapeNode,
                  touchesNode.name == "conterClockwiseButton" || touchesNode.name == "clockwiseButton"
            else {
                return
            }
            touchesNode.fillColor = SKColor.green
        }
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       // используется при обрыве нажатия на экран - телефонный звонок или т.п.
    }
       
    override func update(_ currentTime: TimeInterval) {
      // обрабатывает кадр сцены
        snake!.move()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
       
        let collisionObject = bodyes - collisionCategory.SnakeHead
        
        switch collisionObject {
        
        case collisionCategory.Apple:
            
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
           
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
      
       case collisionCategory.Border:
            
            _ = contact.bodyA.node is Border ? contact.bodyA.node : contact.bodyB.node
           
            removeAllChildren()
            createSnake()
            createNavigation()
            createApple()
            

        default:
            break
        }

        
    }
    
}
