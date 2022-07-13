//
//  Model.swift
//  CS map
//
//  Created by Аркадий Торвальдс on 11.07.2022.
//

import Foundation
import MapKit
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore

struct trackFB {
    let name: String
    let locations: Array<GeoPoint>
}

struct trackGPS {
    let name: String
    let locations: Array<CLLocationCoordinate2D>
}
