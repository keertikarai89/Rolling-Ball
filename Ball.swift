//
//  Ball.swift
//  Assignment2
//
//  Created by Keertika on 5/16/18.
//  Copyright © 2018 Keertika. All rights reserved.
//

import UIKit

class Ball: UIView {
    
    var score: Int = 0
    
    var x: CGFloat = 0, y: CGFloat = 0, r: CGFloat = 25
    var velocity: CGFloat = 1
    var dx: CGFloat = 1, dy: CGFloat = 1
    var done = false
    
    var xPrize: [CGFloat] = [0,0,0,0,0,0,0,0,0,0,0]
    var yPrize: [CGFloat] = [0,0,0,0,0,0,0,0,0,0,0]
    var rPrize: [CGFloat] = [20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20]
    var velocityPrize: [CGFloat] = [0.4, 0.7, 0.6, 0.8, 0.6, 0.5, 0.7, 0.8, 0.2, 0.1, 0.4]
    var dxPrize: [CGFloat] = [1, 2, 3, 1, 2, 1, 2, 1, 2, 1, 2]
    var dyPrize: [CGFloat] = [1, 2, 3, 1, 2, 1, 1, 2, 2, 2, 3]
    
    var rectBall: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
    var rectPrize: [CGRect] = [CGRect]()
    var isCollide: [Bool] = [false, false, false, false, false, false, false, false, false, false, false]
    var colorPrize: [UIColor] = [.green, .red, .green, .red, .green, .red, .green, .green, .red, .green, .green]
    var staticPrize: [Bool] = [false, true, false, true, false, true, true, true, false, true, true]
    
    var width1: CGFloat = 0;
    var height1: CGFloat = 0;
    
    
    // Only override draw if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        //UIColor.gray.set()
        //UIRectFill(bounds);
        if let context = UIGraphicsGetCurrentContext() {
            
            playerBall(context)
            
            for a in 0 ... 10 {
                if !isCollide[a] {
                    prize(context, a, colorPrize[a], xPrize[a], yPrize[a], rPrize[a], rPrize[a])
                    collision(a, rectBall: rectBall, rectPrize: rectPrize[a])
                }
            }
        }
        
        if !done {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(15)) {
                self.update()
            }
        }
    }
    
    func playerBall(_ context: CGContext) {
        context.setFillColor(UIColor.orange.cgColor)
        rectBall = CGRect(x: x - r, y: y - r, width: 2 * r, height: 2 * r)
        context.fillEllipse(in: rectBall)
    }
    
    func prize(_ context: CGContext, _ prizeNumber: Int, _ color: UIColor, _ x1: CGFloat, _ y1: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        context.setFillColor(color.cgColor)
        
        rectPrize.insert(CGRect(x: x1 - width, y: y1 - height, width: width, height: height), at: prizeNumber)
        context.fill(rectPrize[prizeNumber])
    }
    
    func collision(_ prizeNumber: Int, rectBall rect1: CGRect, rectPrize rect2: CGRect) {
        if rect1.intersects(rect2) {
            
            isCollide[prizeNumber] = true
            
            if colorPrize[prizeNumber] == .red && score >= 1 {
                score -= 1
            }
            else if colorPrize[prizeNumber] == .red && score == 0 {
                stop() // game end
                gameOver()
            }
            else  {
                if velocity > 35.0 {
                    score += 2
                }
                else {
                    score += 1
            }
            
        }
    }
    }
    
    func gameOver() {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes = [
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 22.0),
            NSAttributedStringKey.foregroundColor: UIColor.blue,
            NSAttributedStringKey.strokeColor: UIColor.black
        ]
        
        let myText = "GAME OVER"
        let attributedString = NSAttributedString(string: myText, attributes: attributes)
        
        let stringRect = CGRect(x: bounds.width/2, y: bounds.height/2, width: 200, height: 200)
        attributedString.draw(in: stringRect)
        
    }
    
    func start() {
        
        score = -1
        x = bounds.width / 2
        y = bounds.height / 2
        
        for a in 0 ... 10 {
            xPrize[a] = x/CGFloat(a + 1) // start x from different positions
            yPrize[a] = y/CGFloat(a + 1) // start y from different positions
        }
        
        done = false
        self.setNeedsDisplay()
        
    }
    
    //func restartGame() {
      //  start()
    //}
    
    func stop() {
        done = true
    }
    
    func update() {
        
        updatePlayer(true, &x, &y, &dx, &dy, &r, &velocity)
        
        for a in 0 ... 10 {
            if staticPrize[a] {
                updatePlayer(false, &xPrize[a], &yPrize[a], &dxPrize[a], &dyPrize[a], &rPrize[a], &velocityPrize[a])
            }
        }
        self.setNeedsDisplay()
    }
    
    func updatePlayer(_ player: Bool, _ x: inout CGFloat, _ y: inout CGFloat, _ dx: inout CGFloat, _ dy: inout CGFloat, _ r: inout CGFloat, _ velocity: inout CGFloat) {
        
        x += dx * velocity
        y += dy * velocity
        
        if player {
            // to touch player ball with the wall otherwise player ball will go half inside the wall.
            width1 = bounds.width - r
            height1 = bounds.height - r
        } else {
            // for prize and hazard
            width1 = bounds.width
            height1 = bounds.height
        }
        
        if x < r || x > width1  {
            dx = -dx
            if player {
                dx = dx * 2
            }
        }
        
        if y < r || y > height1  {
            dy = -dy
            if player {
                dy = dy * 2
            }
        }
    }
    
}
