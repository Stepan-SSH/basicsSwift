

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        // вызывает при подготовке к выводу экрана, когда первый раз грузится приложение
        super.viewDidLoad()
        // Здесь будем содавать сцену игры, наследуем от класса  GameScene <- класс описан в отдельном файле
        // ЕСть варианты инициализации, можно sks вызват, можно руками написать сцену, также задать размеры. Можно ловить ошибки
        //The bounds rectangle, which describes the view’s location and size in its own coordinate system.

        
        let scene = GameScene(size: view.bounds.size)
                        
        let skView = view as! SKView // приводим к типу
        
        // skView  - описания настроек экрана и отображаемых параметров
        //  выведем отображение fps
        skView.showsFPS = true
        //каждый обьект называется node, выводим их количество
        skView.showsNodeCount = true
        // подключаем рандомный порядок рендеринга обьектов
        skView.ignoresSiblingOrder = true
        //растягиваем на весь экран
        scene.scaleMode = .resizeFill
        // передаем сцену на экран
        skView.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}


