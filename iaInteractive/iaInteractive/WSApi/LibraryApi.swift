//
//  LibraryApi.swift
//  KokonutTemplate
//
//  Created by Aldo Bonilla on 01/09/16.
//  Copyright © 2016 Aldo Bonilla. All rights reserved.
//  Here is were you put all your web calls

import Foundation
import Alamofire
 
class LibraryApi {
    
    static let sharedInstance = LibraryApi()
    
    //TODO: change this URL for the server you are using
    private let Server = "http://api.cinepolis.com.mx/"
    
    
    func getCities(_ onCompletition: @escaping (([City]?, NSError?)) -> ()) {
        let citiesUrl = "\(Server)Consumo.svc/json/ObtenerCiudades"
        WSApi.sharedInstance.serviceWithURL(url: citiesUrl, method: .GET, parameters: nil, onCompletition: { response, error in
            if error != nil { onCompletition((nil, error)) }
            else {
                guard let objects = response else {
                    onCompletition((nil, NSError(domain: "Library", code: -1, userInfo: ["error" : "Couldnt load cities"])))
                    return
                }
                let mappedProducts = objects.map({City(dictionary: $0)})
                onCompletition((mappedProducts, nil))
            }
        })
    }
   
    func getCityCinemas(_ cityId: Int, cityName: String, _ onCompletition: @escaping (([Complejo]?, NSError?)) -> ()) {
        if (filePathWithName(cityName) != nil) {
            guard let complejos = SQLiteApi.sharedInstance.getComplexesForCity(cityName) else {
                onCompletition((nil, NSError(domain: "Library", code: -1, userInfo: ["error" : "Couldnt load products"])))
                return
            }
            onCompletition((complejos, nil))
        } else {
            let cinemasURL = "\(Server)sqlite.aspx?idCiudad=\(cityId)"
            WSApi.sharedInstance.downloadFileWithUrl(url: cinemasURL, destinationName: cityName, onCompletition: { success in
                if success == true {
                    guard let complejos = SQLiteApi.sharedInstance.getComplexesForCity(cityName) else {
                        onCompletition((nil, NSError(domain: "Library", code: -1, userInfo: ["error" : "Couldnt load products"])))
                        return
                    }
                    onCompletition((complejos, nil))
                } else {
                    onCompletition((nil, NSError(domain: "Library", code: -1, userInfo: ["error" : "Couldnt load complexes"])))
                }
            })
        }
    }
}
