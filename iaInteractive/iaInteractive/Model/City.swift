//
//  City.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 15/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import Foundation

struct City {
    
    let estado: String
    let id: Int
    let idEstado: Int
    let idPais: Int
    let latitude: Double
    let longitude: Double
    let nombre: String
    let pais: String
    
    init (dictionary: BasicDictionary) {
        
        estado = dictionary["Estado"] as? String ?? ""
        id = dictionary["Id"] as? Int ?? -1
        idEstado = dictionary["IdEstado"] as? Int ?? -1
        idPais = dictionary["IdPais"] as? Int ?? -1
        latitude = dictionary["Latitud"] as? Double ?? 0.0
        longitude = dictionary["Longitud"] as? Double ?? 0.0
        nombre = dictionary["Nombre"] as? String ?? ""
        pais = dictionary["Pais"] as? String ?? ""
    }
}
