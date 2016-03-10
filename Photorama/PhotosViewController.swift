//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Sebastian on 3/9/16.
//  Copyright © 2016 Sebastian. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchRecentPhotos()
    }
}
