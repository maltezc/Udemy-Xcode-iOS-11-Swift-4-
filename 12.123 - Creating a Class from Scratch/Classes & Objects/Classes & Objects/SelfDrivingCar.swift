//
//  SelfDrivingCar.swift
//  Classes & Objects
//
//  Created by Chris Maltez on 10/22/18.
//  Copyright © 2018 Christopher Maltez. All rights reserved.
//

import Foundation
// V how to inherit from car
class SelfDrivingCar : Car {
    
    var destination : String?
    
    override func drive() {
        super.drive()
        
        if let userSetDestination = destination {
            print("Driving towards " + userSetDestination)

        }
    }
}
