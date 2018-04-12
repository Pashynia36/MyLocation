//
//  Annotation.swift
//  MyLocation
//
//  Created by Pavlo Novak on 4/12/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import MapKit

class Annotation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let picture: UIImage
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, picture: UIImage, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.locationName = locationName
        self.picture = picture
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
