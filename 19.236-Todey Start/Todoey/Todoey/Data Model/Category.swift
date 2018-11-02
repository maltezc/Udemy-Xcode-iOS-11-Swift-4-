//
// Created by Chris Maltez on 10/31/18.
// Copyright (c) 2018 Christopher Maltez. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
//    let array : [Int] = [1,2,3]
//    let array = Array<Int>()
//    ^initialises an array of items
}