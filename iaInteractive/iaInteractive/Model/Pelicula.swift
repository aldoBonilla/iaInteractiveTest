//
//  Pelicula.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 16/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import Foundation
import FMDB

class Pelicula: Hashable, CustomStringConvertible {
    
    let id: Int
    let title: String
    let originalTitle: String?
    let gender: String
    let classification: String
    let duration: String
    let director: String?
    let mainActors: String?
    let sinopsis: String?
    let poster: String
    var horarios: [(Date, String)] = []
    
    init(fmResult: FMResultSet) {
        id = Int(fmResult.int(forColumn: "IdPelicula"))
        title = fmResult.string(forColumn: "Titulo")
        originalTitle = fmResult.string(forColumn: "TituloOriginal")
        gender = fmResult.string(forColumn: "Genero")
        classification = fmResult.string(forColumn: "Clasificacion")
        duration = fmResult.string(forColumn: "Duracion")
        director = fmResult.string(forColumn: "Director")
        mainActors = fmResult.string(forColumn: "Actores")
        sinopsis = fmResult.string(forColumn: "Sinopsis")
        poster = fmResult.string(forColumn: "ImagenCartel")
    }
    
    var description: String {
        return "\(title) by: \(director ?? "")"
    }
    
    var hashValue: Int {
        return id
    }
}

func ==(lhs: Pelicula, rhs: Pelicula) -> Bool {
    return lhs.id == rhs.id
}
