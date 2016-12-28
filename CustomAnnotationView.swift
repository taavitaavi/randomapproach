//
//  CustomAnnotationView.swift
//  randomapproach
//
//  Created by vm mac on 21/12/2016.
//  Copyright © 2016 taavitaavi. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotationView: MKPinAnnotationView {

   
    let selectedLabel:UILabel = UILabel.init(frame:CGRect(x:0, y:0, width:140, height:38))
    
    override func setSelected(_ selected: Bool, animated: Bool) 
    {
        super.setSelected(false, animated: animated)
        // annotation is always selected
        //if(selected)
        //{
            // Do customization, for example:
            selectedLabel.text = (annotation?.subtitle)!
            selectedLabel.textAlignment = .center
            selectedLabel.font = UIFont.init(name: "HelveticaBold", size: 15)
            selectedLabel.backgroundColor = UIColor.lightGray
            selectedLabel.layer.borderColor = UIColor.darkGray.cgColor
            selectedLabel.layer.borderWidth = 2
            selectedLabel.layer.cornerRadius = 5
            selectedLabel.layer.masksToBounds = true
            
            selectedLabel.center.x = 0.5 * self.frame.size.width;
            selectedLabel.center.y = -0.5 * selectedLabel.frame.height;
            self.addSubview(selectedLabel)
        //}
        //else
        //{
          //  selectedLabel.removeFromSuperview()
        //}
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
