//
//  BuildingDetailsViewController.swift
//  SJSU Map
//
//  Created by Akshay Bhasme on 11/7/15.
//  Copyright © 2015 Fenders. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class BuildingDetailsViewController: UIViewController, CLLocationManagerDelegate {
    
    var building: Building!
    
    @IBOutlet weak var buildingName: UILabel!
    @IBOutlet weak var buildingImage: UIImageView!
    @IBOutlet weak var buildingAddress: UILabel!
    @IBOutlet weak var walkingDistance: UILabel!
    
    let locationManager = CLLocationManager()
    
    var requesting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.locationManager.stopUpdatingLocation()
        if(!self.requesting){
            self.requesting = true
            let encodedBuilding = building.getAddress().stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
            let origin = "\(locValue.latitude),\(locValue.longitude)"
            let url: String = "https://maps.googleapis.com/maps/api/distancematrix/json?origins="+origin+"&destinations="+encodedBuilding!+"&key=AIzaSyC38E7xpJJ1pCfvCLZ5arZs8s5cJqlM5sE&mode=walking"
            
            NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { data, response, error in
                do{
                    let jsonResult: NSDictionary! = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    let elements = jsonResult["rows"]![0]!["elements"]
//                    print(elements!![0]["distance"]!!["text"])
//                    print(elements!![0]["duration"]!!["text"])
                    let distance = elements!![0]["distance"]!!["text"]
                    let duration = elements!![0]["duration"]!!["text"]
                    self.walkingDistance.text = "\(distance!!.description) | \(duration!!.description)"
//                    self.walkingDistance.text = jsonResult["rows"]![0]!["elements"]!![0]!["distance"]!!["text"]
                }catch {
                    print(error)
                }
                
                }.resume()
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: "+error.localizedDescription)
    }
    
}
