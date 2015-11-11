//
//  ViewController.swift
//  SJSU Map
//
//  Created by Akshay Bhasme on 11/3/15.
//  Copyright © 2015 Fenders. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UIScrollViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    var campus: Campus!
 
    @IBOutlet weak var king: UIButton!
    @IBOutlet weak var engg: UIButton!
    @IBOutlet weak var yu: UIButton!
    @IBOutlet weak var su: UIButton!
    @IBOutlet weak var bbc: UIButton!
    @IBOutlet weak var southPark: UIButton!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.minimumZoomScale = 0.8
        scrollView.maximumZoomScale = 10
        scrollView.contentSize = CGSizeMake(1280, 960);
        automaticallyAdjustsScrollViewInsets = true
        scrollView.delegate = self
        search.delegate = self
        campus = Campus()
        
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }else{
            print("Location service disabled!")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return contentView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let b: Building? = campus.find(search.text!)
        if b != nil{
            scrollView.zoomToRect(king.accessibilityFrame, animated: true)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    // Mark: zoom buttons
    @IBAction func kingLibrary(sender: UIButton) {
        openBuildingDetails("king")
    }
    
    @IBAction func enggBuilding(sender: UIButton) {
        openBuildingDetails("engg")
    }
    
    @IBAction func yuHall(sender: UIButton) {
        openBuildingDetails("yuh")
    }
    
    @IBAction func studentUnion(sender: UIButton) {
        openBuildingDetails("su")
    }
    
    @IBAction func bbc(sender: UIButton) {
        openBuildingDetails("bbc")
    }
    
    @IBAction func southParking(sender: UIButton) {
        openBuildingDetails("spg")
    }
    
    func openBuildingDetails(key: String){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle());
        let buildingDetailsController: BuildingDetailsViewController = storyboard.instantiateViewControllerWithIdentifier("BuildingDetailsViewController") as! BuildingDetailsViewController;
        buildingDetailsController.setBuilding(campus.buildings[key]!)
        presentViewController(buildingDetailsController, animated: true, completion: nil)
    }
}

