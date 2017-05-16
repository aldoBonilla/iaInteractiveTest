//
//  MasterCinemasViewController.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 15/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

class MasterCinemasViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var containerCinemaTVC: UIView!
    @IBOutlet weak var containerCinemaMVC: UIView!
    
    var cinemaTVC: CityCinemasTableViewController?
    var cinemaMVC: CinemasMapViewController?
    var cinemaForDetail: Complejo?
    var showingList = false
    var firstAppear = true
    var cinemas: [Complejo] = []
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(city!.nombre) Cinemas"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(changeViewMode))
        changeViewMode()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if firstAppear == true {
            HUD.showWithStatus("Obteniendo Complejos")
            LibraryApi.sharedInstance.getCityCinemas(city!.id, cityName: city!.nombre, { complejos, error in
                if error == nil && complejos != nil {
                    self.cinemas = complejos!
                    self.cinemaTVC?.cinemas = self.cinemas
                    self.cinemaMVC?.cinemas = self.cinemas
                    DispatchQueue.main.async {
                        self.cinemaTVC?.tableView.reloadData()
                        self.cinemaMVC?.drawCinemas()
                        HUD.dismiss()
                    }
                } else {
                    DispatchQueue.main.async {
                        HUD.dismiss()
                        showSimpleAlertWithTitle(title: "No se pudo acceder a la informacion", message: "", viewController: self)
                    }
                }
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeViewMode() {
        if showingList == true {
            UIView.transition(with: viewContainer, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.containerCinemaTVC.isHidden = true
            }, completion: { complete in
                self.containerCinemaMVC.isHidden = false
                self.showingList = false
            })
        } else {
            UIView.transition(with: viewContainer, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.containerCinemaMVC.isHidden = true
            }, completion: { complete in
                self.containerCinemaTVC.isHidden = false
                self.showingList = true
            })
        }
    }
    
    private func showCinemaDetail(cinema: Complejo) {
        cinemaForDetail = cinema
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "showCartelera", sender: self)
        })
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embebedCinemaTVC" {
            guard let destinationVC = segue.destination as? CityCinemasTableViewController else {
                return
            }
            cinemaTVC = destinationVC
            cinemaTVC?.showDetailForCinema = showCinemaDetail
        } else if segue.identifier == "embebedCinemaMVC" {
            guard let destinationVC = segue.destination as? CinemasMapViewController else {
                return
            }
            cinemaMVC = destinationVC
            cinemaMVC?.showDetailForCinema = showCinemaDetail
        } else if segue.identifier == "showCartelera" {
            guard let carteleraVC = segue.destination as? CarteleraTableViewController else {
                return
            }
            carteleraVC.complex = cinemaForDetail
        }
    }

}
