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
    
    static let SJSU_SW : CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.331361, -121.886478);
    static let SJSU_NE : CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.338800, -121.876243);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.minimumZoomScale = 0.8
        scrollView.maximumZoomScale = 5
        scrollView.contentSize = UIImage(named: "campusmap")!.size;
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
        self.locationManager.stopUpdatingLocation()
        let userX = Double(self.contentView.bounds.height) * (fabs(locValue.longitude)-fabs(self.dynamicType.SJSU_SW.longitude))/(fabs(self.dynamicType.SJSU_NE.longitude)-fabs(self.dynamicType.SJSU_SW.longitude));
        let userY = Double(self.contentView.bounds.width) - (Double(self.contentView.bounds.width) * (fabs(locValue.latitude)-fabs(self.dynamicType.SJSU_SW.latitude))/(fabs(self.dynamicType.SJSU_NE.latitude)-fabs(self.dynamicType.SJSU_SW.latitude)));
        let locationPoint : CGPoint = CGPointMake(CGFloat(userX), CGFloat(userY));
        
        displayRedCircleAt(locationPoint);
        
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
    
    func displayRedCircleAt(point : CGPoint) {
        
        if let tempView = self.contentView.viewWithTag(999) {
            
            tempView.removeFromSuperview();
        }
        
        let xStart : Int = Int(point.x);
        let yStart : Int = Int(point.y);
        
        let innerCircleRect : CGRect = CGRectMake(CGFloat(xStart), CGFloat(yStart), 20, 20);
        
        let innerCircleView : UIView = UIView(frame: innerCircleRect);
        innerCircleView.tag = 999;
        
        innerCircleView.backgroundColor = UIColor.redColor();
        innerCircleView.layer.cornerRadius = 10.0;
        self.contentView.addSubview(innerCircleView);
        print("Red dot displayed")
    }
}

