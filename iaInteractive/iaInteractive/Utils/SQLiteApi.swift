//
//  SQLiteApi.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 15/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import Foundation
import FMDB

class SQLiteApi {
    
    static let sharedInstance = SQLiteApi()
    
    func getComplexesForCity(_ city: String) -> [Complejo]? {
        
        let query = "SELECT * FROM Complejo"
        
        guard let path = filePathWithName(city), let db = FMDatabase(path: path) else {
            return nil
        }
        if db.open() {
            
            let results: FMResultSet? = db.executeQuery(query, withArgumentsIn: nil)
            var complejos: [Complejo] = []
            while (results?.next())! {
                complejos.append(Complejo(fmResult: results!, city: city))
            }
            db.close()
            return complejos
            
        } else {
            db.close()
            return nil
        }
    }
    
    func getCarteleraForComplex(_ idComplex: Int, inCity city: String) -> [Pelicula]? {
        
        let query = "SELECT * FROM Cartelera C INNER JOIN Pelicula ON Pelicula.Id = C.IdPelicula WHERE C.IdComplejo = '\(idComplex)'"
        guard let path = filePathWithName(city), let db = FMDatabase(path: path) else {
            return nil
        }
        if db.open() {
            
            let results: FMResultSet? = db.executeQuery(query, withArgumentsIn: nil)
            var movies: [Pelicula] = []
            while (results?.next())! {
                let idMovie = Int(results!.int(forColumn: "IdPelicula"))
                if let movie = movies.filter({$0.id == idMovie}).first {
                    movie.horarios.append((Date.convertFromString(results!.string(forColumn: "Fecha"))!, results!.string(forColumn: "Horario")))
                } else {
                    movies.append(Pelicula(fmResult: results!))
                }
            }
            db.close()
            return movies
            
        } else {
            db.close()
            return nil
        }
    }
    
    func getGalleryURLSForMovie(_ idMovie: Int, city: String, onCompletition: @escaping (([String]?, NSError?) -> ())) {
        
        let query = "SELECT * FROM Multimedia WHERE IdPelicula = '\(idMovie)' AND Tipo = 'Imagen'"
        guard let path = filePathWithName(city), let db = FMDatabase(path: path) else {
            onCompletition(nil, NSError(domain: "SQLiteAPi", code: -1, userInfo: ["error" : "No se encontro la base de datos"]))
            return
        }
        if db.open() {
            let results: FMResultSet? = db.executeQuery(query, withArgumentsIn: nil)
            var images: [String] = []
            while (results?.next())! {
                let url = results!.string(forColumn: "Archivo")
                images.append("http://www.cinepolis.com/_MOVIL/iPhone/galeria/thumb/\(url!)")
            }
            db.close()
            onCompletition(images, nil)
            return
        } else {
            db.close()
            onCompletition(nil, NSError(domain: "SQLiteAPi", code: -1, userInfo: ["error" : "No se pudo abrir la base de datos"]))
            return
        }
    }
}
