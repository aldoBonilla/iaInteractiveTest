//
//  CarteleraTableViewController.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 16/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

class CarteleraTableViewController: UITableViewController {

    var movies: [Pelicula] = []
    var complex: Complejo?
    var movieSelected: Pelicula?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = complex!.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if movies.count == 0 {
            guard let moviesDb = SQLiteApi.sharedInstance.getCarteleraForComplex(complex!.id, inCity: complex!.cityName) else {
                showSimpleAlertWithTitle(title: "No pudimos obtener la cartelera", message: "", viewController: self)
                return
            }
            movies = moviesDb
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        let thisMovie = movies[indexPath.row]
        cell.textLabel?.styleWithText(thisMovie.title, labelStyle: .CellTitle, aligment: .left)
        cell.detailTextLabel?.styleWithText("Duracion: \(thisMovie.duration)    Clasificación: \(thisMovie.classification)", labelStyle: .CellDetail, aligment: .left)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelected = movies[indexPath.row]
        performSegue(withIdentifier: "movieDetail", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetail" {
            guard let movieVC = segue.destination as? MovieViewController else {
                return
            }
            movieVC.movie = movieSelected
        }
    }
}
