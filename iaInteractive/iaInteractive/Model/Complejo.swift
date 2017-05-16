//
//  Complejo.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 15/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import Foundation
import FMDB
import MapKit

class Complejo: NSObject, MKAnnotation {
    
    let id: Int
    let title: String?
    let latitud: Double
    let longitud: Double
    let direccion: String
    let url: String
    let coordinate: CLLocationCoordinate2D
    let cityName: String
    
    init(fmResult: FMResultSet, city: String) {
        title = fmResult.string(forColumn: "Nombre")
        id = Int(fmResult.int(forColumn: "Id"))
        latitud = fmResult.double(forColumn: "Latitud")
        longitud = fmResult.double(forColumn: "Longitud")
        direccion = fmResult.string(forColumn: "Direccion")
        url = fmResult.string(forColumn: "UrlSitio")
        coordinate = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        cityName = city
        super.init()
    }
    
    var subtitle: String? {
        return direccion
    }
}
