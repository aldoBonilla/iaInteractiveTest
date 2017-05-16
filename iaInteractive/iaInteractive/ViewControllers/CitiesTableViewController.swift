//
//  CitiesTableViewController.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 15/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    var cities: [City] = []
    var citySelected: City?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if cities.count == 0 {
            HUD.showWithStatus("Obteniendo Ciudades")
            LibraryApi.sharedInstance.getCities({ cities, error in
                if error == nil && cities != nil {
                    self.cities = cities!
                    DispatchQueue.main.async {
                        HUD.dismiss()
                        self.tableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        HUD.dismiss()
                        showSimpleAlertWithTitle(title: "No pudimos obtener la informacion que necesitas, intenta mas tarde", message: "", viewController: nil)
                    }
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let thisCity = cities[indexPath.row]
        cell.textLabel?.styleWithText(thisCity.nombre, labelStyle: .CellTitle, aligment: .left)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        citySelected = cities[indexPath.row]
        performSegue(withIdentifier: "showCity", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCity" {
            let masterCinemasVC = segue.destination as! MasterCinemasViewController
            masterCinemasVC.city = citySelected
        }
    }
    
}
