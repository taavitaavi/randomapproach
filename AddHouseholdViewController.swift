//
//  AddHouseholdViewController.swift
//  randomapproach
//
//  Created by vm mac on 29/12/2016.
//  Copyright © 2016 taavitaavi. All rights reserved.
//

import UIKit
import MapKit

class AddHouseholdViewController: UIViewController {
    @IBOutlet var nameField:UITextField!
    @IBOutlet var recommenderField:UITextField!
    var location:CGPoint?
    var locCoord:CLLocationCoordinate2D?
    var annotation = Household()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("addhouseholdviewcontroller")
        print(location!)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Cancel(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mapViewController") as! MapViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func launchCalendar(){
        
        UIApplication.shared.openURL(NSURL(string: "calshow://")! as URL)
    }
    
    @IBAction func saveHousehold(){
        
        
        annotation.coordinate = self.locCoord!
        annotation.title = "annotation title"
        annotation.subtitle = nameField.text
        performSegue(withIdentifier: "unwindToMapVC", sender: self)
        //self.map.addAnnotation(annotation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "unwindToMapVC"){
            let destinationVC = segue.destination as! MapViewController
            destinationVC.map.addAnnotation(self.annotation)
        }
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
