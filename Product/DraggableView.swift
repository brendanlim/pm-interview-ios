//
//  DraggableView.swift
//  Product
//
//  Created by Brendan G. Lim on 6/9/14.
//  Copyright (c) 2014 Brendan Lim. All rights reserved.
//

import UIKit

class DraggableView: UIView {
    var isDragging: Bool = false
    var oldX: CGFloat = 0.0
    var oldY: CGFloat = 0.0
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        var touch : AnyObject! = event!.allTouches().anyObject()
        var location = touch.locationInView(self)
        
        if (CGRectContainsPoint(self.frame, location)) {
            self.isDragging = true;
            self.oldX = location.x
            self.oldY = location.y
        }
    }
}
