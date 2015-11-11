//
//  BuildingDetailsViewController.swift
//  SJSU Map
//
//  Created by Akshay Bhasme on 11/7/15.
//  Copyright © 2015 Fenders. All rights reserved.
//

import Foundation
import UIKit

class BuildingDetailsViewController: UIViewController {
    
    var building: Building!
    
    @IBOutlet weak var buildingName: UILabel!
    @IBOutlet weak var buildingImage: UIImageView!
    @IBOutlet weak var buildingAddress: UILabel!
    @IBOutlet weak var walkingDistance: UILabel!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if building != nil {
            buildingName.text = building.getName()
            buildingAddress.text = building.getAddress()
            buildingImage.image = building.image
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setBuilding(building: Building){
        self.building = building
    }
    
    @IBAction func goBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
