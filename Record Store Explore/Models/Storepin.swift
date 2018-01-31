//
//  Storepin.swift
//  Record Store Explore
//
//  Created by Timo den Hartog on 29-01-18.
//  Copyright © 2018 Timo den Hartog. All rights reserved.
//

import UIKit
import YelpAPI
import MapKit

class StorePin: NSObject, MKAnnotation {
    
    init(business: YLPBusiness) {
        coordinate = CLLocationCoordinate2DMake(business.location.coordinate!.latitude, business.location.coordinate!.longitude)
        
        title = business.name
        city = business.location.city
        address = business.location.address.first!
        url = business.url
        imageURL = business.imageURL!
    }
    
    func mapItem() -> MKMapItem {
        let placeMark: MKPlacemark = MKPlacemark(coordinate: coordinate)
        return MKMapItem(placemark: placeMark)
    }
    
    var imageURL: URL
    var title: String?
    var city: String
    var address: String
    var coordinate: CLLocationCoordinate2D
    var url: URL
}

