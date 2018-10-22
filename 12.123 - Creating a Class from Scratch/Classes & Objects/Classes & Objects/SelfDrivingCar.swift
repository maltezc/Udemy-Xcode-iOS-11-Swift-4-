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
    var destination : String = "1 Infinite Loop"
    override func drive() {
        super.drive()
        print("Driving towards " + destination)
    }
}
