//
//  Building.swift
//  SJSU Map
//
//  Created by Akshay Bhasme on 11/7/15.
//  Copyright © 2015 Fenders. All rights reserved.
//

import Foundation
import UIKit

class Building {
    
    var name: String
    var address: String
    var image: UIImage
//    var x: Int
//    var y: Int
//    var w: Int
//    var h: Int
    
    init(name: String, address: String, image: UIImage/*x: Int, y: Int, w: Int, h: Int*/){
        self.name = name
        self.address = address
//        self.x = x
//        self.y = y
//        self.w = w
//        self.h = h
        self.image = image
    }
    
    func getName() -> String {
        return name
    }
    
    func getAddress() -> String {
        return address
    }
    
//    func getCGRect() -> CGRect {
//        return CGRect(x: x, y: y, width: w, height: h)
//    }
    
}
