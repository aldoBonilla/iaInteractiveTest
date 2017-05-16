//
//  MovieGalleryCollectionViewController.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 16/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "galleryCell"

class MovieGalleryCollectionViewController: UICollectionViewController {

    var images: [String] = []
    var indexSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        let thisImage = images[indexPath.row]
        cell.image.kf.setImage(with: URL(string: thisImage), options: [.transition(ImageTransition.fade(1))])
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        performSegue(withIdentifier: "viewGallery", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewGallery" {
            let navigation = segue.destination as! UINavigationController
            let galleryScroll = navigation.viewControllers.first as? GalleryScrollViewController
            galleryScroll?.images = images
            galleryScroll?.startAtIndex = indexSelected
        }
    }

}
