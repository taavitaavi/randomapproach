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
    @IBOutlet weak var followButton:UIButton!
    
    var pinAnnotationView:MKPinAnnotationView!
    var pinCount:Int=0
    let locationManager = CLLocationManager()
    var compassModeActive = false
    var following = true
    
    
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
        
        //self.map.removeAnnotations(map.annotations)
        //
        
           }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fromMapToAddHousehold"){
            let destinationVC = segue.destination as! AddHouseholdViewController
            let tapRecognizer = sender as! UITapGestureRecognizer
            let location = tapRecognizer.location(in:self.map)
            //destinationVC.location = location
            destinationVC.locCoord = self.map.convert(location, toCoordinateFrom: self.map)
        }
        if(segue.identifier == "editHousehold"){
            print("preparing for edit household Segue")
            let destinationVC = segue.destination as! AddHouseholdViewController
            var issuer =  sender as? PinTapGestureRecognizer
            let annotation = issuer?.annotation as! Household
            destinationVC.annotation = annotation
            destinationVC.locCoord = annotation.coordinate
            print(annotation.name ?? "annotation name")
            //destinationVC.nameField.text = annotation.name
            //destinationVC.location
        }
    }
    
    
    @IBAction func cancelUnwindToMapVC(segue: UIStoryboardSegue ){
    
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
            //anno?.canShowCallout=false
            anno?.isHighlighted=true
            anno?.isDraggable=true
            anno?.image = UIImage(named: "bus")
            anno?.isUserInteractionEnabled=true
            let tapRecognizer = PinTapGestureRecognizer(target: self, action: #selector(handlePinTap(recognizer:)))
            tapRecognizer.annotation=annotation as? MKPointAnnotation
            anno?.addGestureRecognizer(tapRecognizer)
            
            
            
            
        }
    return anno;
    
    }

    
    func handlePinTap(recognizer:PinTapGestureRecognizer){
        print("handlePinTap mapview")
       
        performSegue(withIdentifier: "editHousehold", sender: recognizer)
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("annotationview selected")
    }

    

    @IBAction func toggleCompassMode(){
        if self.compassModeActive{
           map.setUserTrackingMode(MKUserTrackingMode.none, animated: true)
            self.compassModeActive = false
            self.following=false
            self.followButton.setTitle("unfollow",for: .normal)
            locationManager.stopUpdatingLocation()
        }
        else{
            map.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
            self.locationManager.startUpdatingLocation()
            self.compassModeActive = true
            self.following=true
            self.followButton.setTitle("unfollow",for: .normal)
            let region = MKCoordinateRegion(center: self.map.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            self.map.setRegion(region, animated: true)}
        
    }
    @IBAction func centerMapOnUserButtonClicked() {
        if self.following{
            self.map.setUserTrackingMode( MKUserTrackingMode.none, animated: true)
            self.following=false
            self.followButton.setTitle("follow",for: .normal)
            self.locationManager.stopUpdatingLocation()
        }
        else{
            self.map.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
            self.following=true
            self.followButton.setTitle("unfollow",for: .normal)
            self.locationManager.startUpdatingLocation()
            let region = MKCoordinateRegion(center: self.map.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            self.map.setRegion(region, animated: true)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //print("locations = \(locValue.latitude) \(locValue.longitude)")

        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        print("dragging")
        
    }
    //MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
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
