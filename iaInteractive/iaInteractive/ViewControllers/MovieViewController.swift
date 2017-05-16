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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie!.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeSegment(_ sender: Any) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
