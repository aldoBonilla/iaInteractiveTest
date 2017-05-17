//
//  MovieSchedulesTableViewController.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 16/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

class MovieSchedulesTableViewController: UITableViewController {

    var horarios: [(Date, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return horarios.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "horariosCell", for: indexPath)
        let thisDate = horarios[indexPath.row]
        cell.textLabel?.styleWithText(thisDate.0.convertToStringWithFormat(), labelStyle: .CellTitle, aligment: .left)
        cell.detailTextLabel?.styleWithText(thisDate.1, labelStyle: .CellDetail, aligment: .left)
        return cell
    }
}
