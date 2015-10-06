//
//  FirstViewController.swift
//  NearMe
//
//  Created by Alex Oh on 10/5/15.
//  Copyright © 2015 Alex Oh. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var myMapView: MKMapView!
    
    let lManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMapView.delegate = self
      
        // NSLocationWhenInUseUsageDescription requires the key in info.plist
        // Need to ask for location
        lManager.requestWhenInUseAuthorization()
        
        
        // the view controller knows how to talk to lManager, but lManager has to talk to ViewController
        // to get this to work, we have to give the FirstViewController class a protocol type
        // so the location manager can call methods on the view controller
        // specifically we want to be able to call didUpdateLocations
        // the view controller is the delegate of lManager
        lManager.delegate = self
        
        // shows pretty blue dot
        myMapView.showsUserLocation = true
        
//        lManager.startUpdatingLocation()
        
        // this is to request location once
        lManager.requestLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            
            print(location.coordinate.latitude, location.coordinate.longitude)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = location.coordinate
            annotation.title = "This is Cool"
            annotation.subtitle = "And Fun!"
            
            myMapView.addAnnotation(annotation)
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
       print(error)
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        
//        annotationView.pinTintColor = UIColor.cyanColor()
        
        annotationView.canShowCallout = true
        
//        annotationView.image = UIImage(named: "line")
        
//        print(annotationView.image)
        
        
        let button = UIButton(type: .DetailDisclosure)
        
        button.addTarget(self, action: "showDetail:", forControlEvents: .TouchUpInside)
        
        annotationView.rightCalloutAccessoryView = button
        
        
        
        return annotationView
    
    }
    
    func showDetail(button: UIButton) {
        
        // changed storyboard ID to DetailVC
        if let viewController = storyboard?.instantiateViewControllerWithIdentifier("DetailVC") {
            
        
        viewController.view.backgroundColor = UIColor.lightGrayColor()
        
        navigationController?.pushViewController(viewController, animated:true)
        
        }
        
    }

}

