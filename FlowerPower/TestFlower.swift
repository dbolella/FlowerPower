//
//  TestFlowers.swift
//  FlowerPower
//
//  Created by Daniel Bolella on 7/12/19.
//  Copyright © 2019 Daniel Bolella. All rights reserved.
//

import SwiftUI

struct TestFlower : Identifiable {
    var id = UUID()
    var name : String
    var actualClass : String
    var imageName : String { return name }
}

let testFlowerData = [
    TestFlower(name: "test", actualClass: "daisy"),
    TestFlower(name: "testD", actualClass: "dandelion"),
    TestFlower(name: "testR", actualClass: "rose"),
    TestFlower(name: "testS", actualClass: "sunflower"),
    TestFlower(name: "testT", actualClass: "tulip")
]
