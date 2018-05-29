//
//  prizeHazard.swift
//  Assignment2
//
//  Created by Keertika on 5/20/18.
//  Copyright © 2018 Keertika. All rights reserved.
//

import UIKit

class prizeHazard: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.*/
    override func draw(_ rect: CGRect) {
        // Drawing code
        UIRectFill(bounds);
        
        let rect = CGRect(x: 5, y: 5, width: 10, height: 10)
        
        UIColor.red.set()
        UIRectFill(rect);
        
        UIColor.black.set()
        UIRectFrame(rect)
    }
 

}
