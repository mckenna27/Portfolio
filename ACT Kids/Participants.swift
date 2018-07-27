//
//  Participants.swift
//  ACT Kids
//
//  Created by Patrick E. McKenna on 3/25/18.
//  Copyright © 2018 Patrick McKenna. All rights reserved.
//

import UIKit
import MapKit

class Participants: NSObject, MKAnnotation
{
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var sportType: String
    var businessAddress: String
    var phoneNumber: String
    
    init(title: String?, coordinate: CLLocationCoordinate2D, sportType: String, businessAddress: String, phoneNumber: String)
    {
        self.title = title
        self.coordinate = coordinate
        self.sportType = sportType
        self.businessAddress = businessAddress
        self.phoneNumber = phoneNumber
        
    }
}
