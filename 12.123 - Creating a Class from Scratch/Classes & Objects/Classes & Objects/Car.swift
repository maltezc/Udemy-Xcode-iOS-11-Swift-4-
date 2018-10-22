//
//  Car.swift
//  Classes & Objects
//
//  Created by Chris Maltez on 10/22/18.
//  Copyright © 2018 Christopher Maltez. All rights reserved.
//

import Foundation

// enums are capitalized
enum CarType {
    case Sedan
    case Coupe
    case Hatchback
}
// class should be Sentence case
// vars should be camel case
class Car {
    var color = "Black"
    var numberOfSeats = 5
    var typeOfCar : CarType = .Coupe
    
    
    init() {
        
    }
    
    convenience init(customerChosenColor : String) {
        self.init()
        color = customerChosenColor
    }
    
    func drive() {
        print("Car is moving")
    }
    // this kind of designated initialiser(below) requires an input
//    init(customerChosenColor : String) {
//        color = customerChosenColor
//    }
    
}


