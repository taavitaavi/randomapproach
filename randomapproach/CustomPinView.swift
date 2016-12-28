//
//  CustomPinView.swift
//  randomapproach
//
//  Created by vm mac on 21/12/2016.
//  Copyright © 2016 taavitaavi. All rights reserved.
//

import UIKit
import MapKit

class CustomPinView: MKPinAnnotationView {
    var price = 0
    
  
    func addLabel(text:String!) -> Void {
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        label.text = text
        self.addSubview(label)
        self.superview?.bringSubview(toFront: label)
        self.setSelected(false, animated: false)
        print("addlabel")
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var rect = self.bounds;
        var isInside = rect.contains(point);
        if(!isInside)
        {
          
          
            for view in self.subviews{
                isInside = view.frame.contains(point);
                if(isInside){
                    break;
                }
                
            }
        }
        return isInside;
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
