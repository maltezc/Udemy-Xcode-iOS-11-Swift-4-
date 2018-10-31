//
// Created by Chris Maltez on 10/31/18.
// Copyright (c) 2018 Christopher Maltez. All rights reserved.
//

import Foundation
import RealmSwift


class Data: Object {
// dynamic = allows to be monitored for change during runtime
    @objc dynamic var name : String = ""
    @objc var age : Int = 0

}
