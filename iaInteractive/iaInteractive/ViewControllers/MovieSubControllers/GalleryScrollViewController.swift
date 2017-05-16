//
//  GalleryScrollViewController.swift
//  iaInteractive
//
//  Created by Aldo Bonilla on 16/05/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import UIKit
import Kingfisher

class GalleryScrollViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var images: [String] = []
    var startAtIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeGallery))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for (index, image) in images.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * self.view.frame.width, y: 0, width: self.view.frame.width, height:  self.view.frame.height))
            imageView.contentMode = .scaleAspectFit
            imageView.kf.setImage(with: URL(string: image))
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: CGFloat(images.count) * self.view.frame.width, height: self.view.frame.height)
        scrollView.setContentOffset(CGPoint(x: CGFloat(startAtIndex) * self.view.frame.width, y: 0), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeGallery() {
        dismiss(animated: true, completion: nil)
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
