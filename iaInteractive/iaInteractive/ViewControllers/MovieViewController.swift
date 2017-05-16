//
//  MovieViewController.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 16/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblActores: UILabel!
    @IBOutlet weak var lblSinopsis: UILabel!
    @IBOutlet weak var containerGallery: UIView!
    @IBOutlet weak var containerTrailer: UIView!
    @IBOutlet weak var containerHorarios: UIView!
    
    var movie: Pelicula?
    var city: String?
    var galleryCVC: MovieGalleryCollectionViewController?
    var scheduleTVC: MovieSchedulesTableViewController?
    var trailerVC: MovieTrailerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie!.title
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblDirector.styleWithText(movie!.director, labelStyle: .Title, aligment: .left)
        lblActores.styleWithText(movie!.mainActors, labelStyle: .Detail, aligment: .left)
        lblSinopsis.styleWithText(movie?.sinopsis, labelStyle: .SmallText, aligment: .left)
        if movie?.gallery.count == 0 {
            HUD.show()
            SQLiteApi.sharedInstance.getGalleryURLSForMovie(movie!.id, city: city!, onCompletition: { gallery, error in
                if error == nil && gallery != nil && gallery!.count > 0 {
                    self.movie!.gallery = gallery!
                    self.galleryCVC?.images = gallery!
                    DispatchQueue.main.async {
                        HUD.dismiss()
                        self.galleryCVC?.collectionView?.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        HUD.dismiss()
                        showSimpleAlertWithTitle(title: "No Pudimos obtener informacion de la pelicula", message: "", viewController: self)
                    }
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            containerGallery.isHidden = false
            containerTrailer.isHidden = true
            containerHorarios.isHidden = true
        case 1:
            containerGallery.isHidden = true
            containerTrailer.isHidden = false
            containerHorarios.isHidden = true
        case 2:
            containerGallery.isHidden = true
            containerTrailer.isHidden = true
            containerHorarios.isHidden = false
        default:
            return
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGallery" && segue.destination is MovieGalleryCollectionViewController {
            galleryCVC = segue.destination as? MovieGalleryCollectionViewController
        } else if segue.identifier == "showTrailer" && segue.destination is MovieGalleryCollectionViewController {
            trailerVC = segue.destination as? MovieTrailerViewController
        } else if segue.identifier == "showHorarios" {
            scheduleTVC = segue.destination as? MovieSchedulesTableViewController
        }
    }
    
}
