//
//  CityCinemasTableViewController.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 15/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

class CityCinemasTableViewController: UITableViewController {
    
    var cinemas: [Complejo] = []
    var showDetailForCinema: ((Complejo) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinemas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "complejoCell", for: indexPath)
        let thisComplejo = cinemas[indexPath.row]
        cell.textLabel?.styleWithText(thisComplejo.title, labelStyle: .CellTitle, aligment: .left)
        cell.detailTextLabel?.styleWithText(thisComplejo.direccion, labelStyle: .CellDetail, aligment: .left)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thisComplejo = cinemas[indexPath.row]
        showDetailForCinema?(thisComplejo)
    }
}
