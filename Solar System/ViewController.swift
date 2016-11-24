//
//  ViewController.swift
//  Solar System
//
//  Created by Mohan Lakshmanan on 7/16/15.
//  Copyright (c) 2015 AD. All rights reserved.
//

import UIKit

class SolarSystem {
    var sun : Planet
    var planets : [Planet] = [Planet]()
    
    init() {
        //Initializing sun here
        sun = Planet(position: Vector(x: 0, y: 0), velocity: Vector(x: 0, y: 0), mass: 1.989 * pow(10, 30), name: "sun")
        
        //Initialize planets here with vectors and mass
        let mercury : Planet = Planet(position: Vector(x: 5.791 * pow(10, 10), y: 0), velocity: Vector(x: 0, y: 48000), mass: 3.285 * pow(10, 23), name: "mercury")
        let venus : Planet = Planet(position: Vector(x: 1.082 * pow(10, 11), y: 0), velocity: Vector(x: 0, y: 35020), mass: 4.867 * pow(10, 24), name: "venus")
        let earth : Planet = Planet(position: Vector(x: 1.496 * pow(10, 11), y: 0), velocity: Vector(x: 0, y: 30000), mass: 5.972 * pow(10, 24), name: "earth")
        let mars : Planet = Planet(position: Vector(x: 2.279 * pow(10, 11), y: 0), velocity: Vector(x: 0, y: 24070), mass: 6.39 * pow(10, 23), name: "mars")
        let jupiter : Planet = Planet(position: Vector(x: 7.785 * pow(10, 11), y: 0), velocity: Vector(x: 0, y: 100000), mass: 1.898 * pow(10, 27), name: "jupiter")
        let saturn : Planet = Planet(position: Vector(x: 1.433 * pow(10, 12), y: 0), velocity: Vector(x: 0, y: 9680), mass: 5.6836 * pow(10, 26), name: "saturn")
        let neptune : Planet = Planet(position: Vector(x: 2.877 * pow(10, 12), y: 0), velocity: Vector(x: 0, y: 6800), mass: 8.6816 * pow(10, 25), name: "neptune")
        let uranus : Planet = Planet(position: Vector(x: 4.503 * pow(10, 12), y: 0), velocity: Vector(x: 0, y: 5430), mass: 1.0242 * pow(10, 26), name: "uranus")
        
        
        //Add planets to list
        planets.append(mercury)
        planets.append(venus)
        planets.append(earth)
        planets.append(mars)
        planets.append(jupiter)
        planets.append(saturn)
        planets.append(neptune)
        planets.append(uranus)
    }
    
    func interact() {
        for i in 0...planets.count-1 {
            //Calculate acceleration from sun
            planets[i].orbitalGravity(sun)
            
            //Calculate acceleration from other planets
            for c in 0...planets.count-1 {
                if c != i {
                    planets[i].gravity(planets[c])
                }
            }
        }
        
        for p in planets {
            p.update()
        }
    }
    
    func simulate() -> [NSMutableDictionary] {
        //var output : String
        var pos = [NSMutableDictionary]()
        for _ in 0...16000 {
            //output = ""
            let planetPos : NSMutableDictionary = NSMutableDictionary()
            interact()
            for p in planets {
                planetPos.setValue(p.position, forKey: p.name)
                //output += "\(p.position.x) \(p.position.y) "
            }
            pos.append(planetPos)
            //println(output)
        }
        return pos
    }
}

class ViewController: UIViewController {

    @IBOutlet var sun : UIImageView!
    
    @IBOutlet var mercury : UIImageView!
    @IBOutlet var venus : UIImageView!
    @IBOutlet var earth : UIImageView!
    @IBOutlet var mars : UIImageView!
    @IBOutlet var jupiter : UIImageView!
    @IBOutlet var saturn : UIImageView!
    @IBOutlet var neptune : UIImageView!
    @IBOutlet var uranus : UIImageView!
    
    var currentFrame = 0
    var arr : [NSMutableDictionary] = [NSMutableDictionary]()
    
    func calculateCoords(x1: Double, y1: Double) -> (x: CGFloat, y: CGFloat) {
        var x = x1
        var y = y1
        
        let scaleFactor : Double = 16
        
        x = (x / ((1.8684 * pow(10, 8)) * scaleFactor))
        y = (y / ((1.8684 * pow(10, 8)) * scaleFactor))
        x = x + Double(sun.frame.midX)
        y = y + Double(sun.frame.midY)
        
        return (CGFloat(x), CGFloat(y))
    }
    
    func animate() {
        if(currentFrame >= arr.count) {
            currentFrame = 0
        }
        var x1 = arr[currentFrame]["earth"]?.x
        var y1 = arr[currentFrame]["earth"]?.y
        var (x, y) = calculateCoords(x1!, y1: y1!)
        earth.frame = CGRect(x: x, y: y, width: earth.frame.width, height: earth.frame.height)
        
        x1 = arr[currentFrame]["mercury"]?.x
        y1 = arr[currentFrame]["mercury"]?.y
        (x, y) = calculateCoords(x1!, y1: y1!)
        mercury.frame = CGRect(x: x, y: y, width: mercury.frame.width, height: mercury.frame.height)
        
        x1 = arr[currentFrame]["venus"]?.x
        y1 = arr[currentFrame]["venus"]?.y
        (x, y) = calculateCoords(x1!, y1: y1!)
        venus.frame = CGRect(x: x, y: y, width: venus.frame.width, height: venus.frame.height)
        
        x1 = arr[currentFrame]["mars"]?.x
        y1 = arr[currentFrame]["mars"]?.y
        (x, y) = calculateCoords(x1!, y1: y1!)
        mars.frame = CGRect(x: x, y: y, width: mars.frame.width, height: mars.frame.height)
        
        x1 = arr[currentFrame]["jupiter"]?.x
        y1 = arr[currentFrame]["jupiter"]?.y
        (x, y) = calculateCoords(x1!, y1: y1!)
        jupiter.frame = CGRect(x: x/1.25, y: y/1.25, width: jupiter.frame.width, height: jupiter.frame.height)
        
        x1 = arr[currentFrame]["saturn"]?.x
        y1 = arr[currentFrame]["saturn"]?.y
        (x, y) = calculateCoords(x1!, y1: y1!)
        saturn.frame = CGRect(x: x/1.25, y: y/1.25, width: saturn.frame.width, height: saturn.frame.height)
        
        x1 = arr[currentFrame]["neptune"]?.x
        y1 = arr[currentFrame]["neptune"]?.y
        (x, y) = calculateCoords(x1!, y1: y1!)
        neptune.frame = CGRect(x: x/2, y: y/2, width: neptune.frame.width, height: neptune.frame.height)
        
        x1 = arr[currentFrame]["uranus"]?.x
        y1 = arr[currentFrame]["uranus"]?.y
        (x, y) = calculateCoords(x1!, y1: y1!)
        uranus.frame = CGRect(x: x/2.5, y: y/2.5, width: uranus.frame.width, height: uranus.frame.height)
        
        currentFrame++
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swag = SolarSystem()
        arr = swag.simulate()
        
        _ = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: "animate", userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

