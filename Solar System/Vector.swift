//
//  Vector.swift
//  Solar System
//
//  Created by Mohan Lakshmanan on 7/16/15.
//  Copyright (c) 2015 AD. All rights reserved.
//

import Foundation

class Vector : NSObject {
    var x : Double
    var y : Double
    
    init(x : Double, y : Double) {        
        self.x = x
        self.y = y
    }
    
    func distance(v2 : Vector) -> Double {
        return sqrt((self.x-v2.x)*(self.x-v2.x) + (self.y-v2.y)*(self.y-v2.y))
    }
    
    func add(v2 : Vector) -> Vector {
        return Vector(x: self.x + v2.x, y: self.y + v2.y)
    }
    
    func scale(factor : Double) -> Vector {
        return Vector(x: self.x * factor, y: self.y * factor)
    }
}