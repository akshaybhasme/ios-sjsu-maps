//
//  Campus.swift
//  SJSU Map
//
//  Created by Akshay Bhasme on 11/7/15.
//  Copyright © 2015 Fenders. All rights reserved.
//

import Foundation
import UIKit

class Campus {
    
    var buildings: [String: Building] = [
        "king": Building(
            name: "King Library",
            address: "Dr. Martin Luther King, Jr. Library, 150 East San Fernando Street, San Jose, CA 95112",
//            x: 0, y: 0, w: 50, h: 60
            image: UIImage(named: "king")!
        ),
        "engg":Building(
            name: "Engineering Building",
            address: "San José State University Charles W. Davidson College of Engineering, 1 Washington Square, San Jose, CA 95112",
//            x: 0, y: 0, w: 0, h: 0
            image: UIImage(named: "engineering")!
        ),
        "yuh": Building(
            name: "Yoshihiro Uchida Hall",
            address: "Yoshihiro Uchida Hall, San Jose, CA 95112",
//            x: 0, y: 0, w: 0, h: 0
            image: UIImage(named: "uchida")!
        ),
        "su": Building(
            name: "Student Union",
            address: "Student Union Building, San Jose, CA 95112",
//            x: 0, y: 0, w: 0, h: 0
            image: UIImage(named: "studentunion")!
        ),
        "bbc": Building(
            name: "BBC",
            address: "Boccardo Business Complex, San Jose, CA 95112",
//            x: 0, y: 0, w: 0, h: 0
            image: UIImage(named: "boccardo")!
        ),
        "spg": Building(
            name: "South Parking Garage:",
            address: "San Jose State University South Garage, 330 South 7th Street, San Jose, CA 95112",
//            x: 0, y: 0, w: 0, h: 0
            image: UIImage(named: "southgarage")!
        )
    ]
    
    func find(query: String) -> Building {
        var b: Building? = nil
        for (_, building) in buildings{
            if building.getName().rangeOfString(query) != nil || building.getAddress().rangeOfString(query) != nil{
                b = building
            }
        }
        return b!
    }
    
}