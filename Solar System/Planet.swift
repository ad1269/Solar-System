//
//  Planet.swift
//  Solar System
//
//  Created by Mohan Lakshmanan on 7/16/15.
//  Copyright (c) 2015 AD. All rights reserved.
//

import Foundation

class Planet {
    var position : Vector
    var velocity : Vector
    var acceleration : Vector
    let mass : Double
    let name : String
    
    init(position : Vector, velocity : Vector, mass : Double, name : String) {
        self.position = position
        self.velocity = velocity
        self.mass = mass
        self.acceleration = Vector(x: 0, y: 0)
        self.name = name
    }
    
    func update() {
        let dt : Double = 10000
        position = position.add(velocity.scale(dt))
        velocity = velocity.add(acceleration.scale(dt))
    }
    
    func orbitalGravity(sun : Planet) {
        if self.name != "sun" {
            let vel = velocity.distance(Vector(x: 0, y: 0))
            let r = position.distance(Vector(x: 0, y: 0))
            
            acceleration.x = pow(vel, 2) * (sun.position.x-self.position.x) / pow(r, 2)
            acceleration.y = pow(vel, 2) * (sun.position.y-self.position.y) / pow(r, 2)
        }
    }
    
    func gravity(planetX : Planet) {
        let G : Double = 6.674 * pow(10,-11)
        let r : Double = self.position.distance(planetX.position)
        
        let force : Double = G * self.mass * planetX.mass / (r * r)
        
        acceleration.x += force * (planetX.position.x-self.position.x) / (self.mass * r)
        acceleration.y += force * (planetX.position.y-self.position.y) / (self.mass * r)
    }
}