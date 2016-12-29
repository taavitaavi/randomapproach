//
//  MapViewController.swift
//  randomapproach
//
//  Created by vm mac on 14/12/2016.
//  Copyright © 2016 taavitaavi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate{
    
     @IBOutlet weak var map: MKMapView!
    
    var pinAnnotationView:MKPinAnnotationView!
    var pinCount:Int=0
    let locationManager = CLLocationManager()
    var compassModeActive = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("this is mapview")
        map.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        map.showsCompass=true
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        map.mapType = MKMapType.hybrid
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            map.showsUserLocation=true
        }
        
        
       
    }
    
    @IBAction func addPin(_ sender: UITapGestureRecognizer) {
        print("tap")
        let location=sender.location(in: self.map)
        let locCoord = self.map.convert(location, toCoordinateFrom: self.map)
        
        performSegue(withIdentifier: "fromMapToAddHousehold", sender: sender)
        
        /*let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "addHousehold") as! AddHouseholdViewController
        self.present(nextViewController, animated:true, completion:nil)
        */
        
        /*let annotation = Household()
        pinCount += 1
        annotation.coordinate=locCoord
        annotation.title = "annotation title"
        annotation.subtitle = String(pinCount)
        
        */
        
        
        //self.map.removeAnnotations(map.annotations)
        //
        
           }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fromMapToAddHousehold"){
            let destinationVC = segue.destination as! AddHouseholdViewController
            let tapRecognizer = sender as! UITapGestureRecognizer
            let location = tapRecognizer.location(in:self.map)
            destinationVC.location = location
            destinationVC.locCoord = self.map.convert(location, toCoordinateFrom: self.map)
        }
    }
    
    
    
    @IBAction func unwindToMapVC(segue: UIStoryboardSegue) {
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
    
        var anno = mapView.dequeueReusableAnnotationView(withIdentifier: "Anno")
        if anno == nil
        {
            anno = CustomAnnotationView.init(annotation: annotation, reuseIdentifier: "Anno")
            //anno = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: "Anno")
            anno?.setSelected(true, animated: true)
            anno?.canShowCallout=false
            anno?.isHighlighted=true
            anno?.isDraggable=true
            
            
            
        }
    return anno;
    
    }
    
 
    

    @IBAction func toggleCompassMode(){
        if self.compassModeActive{
           map.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: false)
            self.compassModeActive = false
        }
        else{
            map.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
            self.compassModeActive = true
        }
        
    }
    @IBAction func centerMapOnUserButtonClicked() {
        self.map.setUserTrackingMode( MKUserTrackingMode.follow, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //print("locations = \(locValue.latitude) \(locValue.longitude)")

        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        print("dragging")
        
    }
    //MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: self.map.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
